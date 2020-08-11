<!-- dx-header -->
# vcf_annotator (DNAnexus Platform App)

## What does this app do?

Convert a bam file to 2 gzipped fastqs

## What are typical use cases for this app?

This app may be executed as a standalone app.
This app was created for the case where a reanalysis request came through and we only have a BAM file.

## What data are required for this app to run?

This app requires just the BAM file.

## What does this app output?

This app outputs 2 gzipped fastqs.

Example cmd line:

``` bash
dx run bam2fqs_v1.0.0 -ibam=file.bam
```

### This app was made by EMEE GLH
