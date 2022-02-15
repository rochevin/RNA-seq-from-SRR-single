
def getSRRFiles(wildcards):
	return(["RAW/SRR/"+f+SAMPLEEXT for f in README[wildcards.sample]])



rule sra_getfastq:
	output:
		"RAW/SRR/{prefix}"+SAMPLEEXT
	params:
		supp = "--gzip --split-files",
		outdir = "RAW",
		name = "{prefix}",
		oldname = "RAW"+"/{prefix}_1"+SAMPLEEXT
	benchmark: SAMPLEOUT+"/benchmarks/fastqdump/{prefix}.benchmark.txt"
	conda:
		"envs/sra-tools.yaml"
	shell:
		"fastq-dump"
		" {params.supp}"
		" --outdir {params.outdir}"
		" -F {params.name} && mv {params.oldname} {output}"


rule merge_and_rename_fastq:
	output:
		"RAW/{sample}"+SAMPLEEXT
	input:
		getSRRFiles
	params:
		nogz = "RAW/{sample}"+".fastq"
	benchmark: SAMPLEOUT+"/benchmarks/mergefastq/{sample}.benchmark.txt"
	shell:
		"zcat {input} > {params.nogz} && gzip {params.nogz}"
