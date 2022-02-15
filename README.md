# Snakemake workflow: `RNA-seq-from-SRR-single`

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/rochevin/RNA-seq-from-SRR-single/workflows/Tests/badge.svg?branch=main)](https://github.com/rochevin/RNA-seq-from-SRR-single/actions?query=branch%3Amain+workflow%3ATests)


A Snakemake workflow for RNA-seq pipeline using `fastq-dump`, `STAR` and `samtools` for single-end reads.

## Usage

The usage of this workflow is described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=rochevin%2FRNA-seq-from-SRR-single).

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) RNA-seq-from-SRR-singlesitory and its DOI (see above).

# TODO

* Replace `rochevin` and `RNA-seq-from-SRR-single` everywhere in the template (also under .github/workflows) with the correct `RNA-seq-from-SRR-single` name and owning user or organization.
* Replace `<name>` with the workflow name (can be the same as `RNA-seq-from-SRR-single`).
* Replace `<description>` with a description of what the workflow does.
* The workflow will occur in the snakemake-workflow-catalog once it has been made public. Then the link under "Usage" will point to the usage instructions if `rochevin` and `RNA-seq-from-SRR-single` were correctly set.