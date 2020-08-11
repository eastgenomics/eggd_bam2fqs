#!/bin/bash

set -euxo pipefail

main() {
    echo "Value of bam: '$bam'"

    # Compile samtools and bedtools
    tar xfj samtools-1.10.tar.bz2
    cd samtools-1.10
    ./configure
    make
    sudo make install
    cd ..

    tar xzf bedtools-2.29.2.tar.gz
    cd bedtools2
    make
    sudo make install
    cd ..

    dx download "$bam"

    # get sample id from bam file name
    sample_id=$(echo ${bam_prefix} | awk -F "_" '{print $1}')
    echo $sample_id

    # Run samtools, bedtools until you get fastqs
    samtools sort -n ${bam_name} -o ${bam_name}_sorted.bam
    samtools fixmate -O bam ${bam_name}_sorted.bam ${bam_name}_sorted_fix.bam
    bedtools bamtofastq -i ${bam_name}_sorted_fix.bam -fq ${sample_id}_R1.fastq -fq2 ${sample_id}_R2.fastq
    gzip ${sample_id}_R*.fastq

    # Upload the fastqs
    mkdir -p /home/dnanexus/out/fastq1
    mkdir -p /home/dnanexus/out/fastq2

    mv ${sample_id}_R1.fastq.gz /home/dnanexus/out/fastq1/.
    mv ${sample_id}_R2.fastq.gz /home/dnanexus/out/fastq2/.

    dx-upload-all-outputs
}