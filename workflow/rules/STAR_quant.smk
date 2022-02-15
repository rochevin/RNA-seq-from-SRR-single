#STAR
rule star_index_gtf:
	output:
		GENDIR+"chrName.txt"
	input:
		fasta=GENOME,
		genomeDir=GENDIR,
		gtf=GTF
	params:
		splice_junction_overhang = STAR_OPT["reads_length"]
	priority: 90
	threads:
		THREADS["index"]
	benchmark: SAMPLEOUT+"/benchmarks/star_index_gtf/{input.fasta}.benchmark.txt"
	conda:
		"envs/star.yaml"
	message: "Indexing with STAR for {input.fasta} with annotation : {input.gtf}"
	shell:
		"STAR"
		" --runMode genomeGenerate"
		" --runThreadN {threads}"
		" --genomeDir {input.genomeDir}"
		" --genomeFastaFiles {input.fasta}"
		" --sjdbGTFfile {input.gtf}"
		" --sjdbOverhang {params.splice_junction_overhang}"


rule star_aln_quant:
	output:
		SAMPLEOUT+"/mapping/sam/{sample}/{sample}_Aligned.out.sam",
		SAMPLEOUT+"/mapping/sam/{sample}/{sample}_ReadsPerGene.out.tab"
	input:
		fastq = "RAW/{sample}"+SAMPLEEXT,
		index = GENDIR+"chrName.txt"
	params:
		readFilesCommand = STAR_OPT["readFilesCommand"],
		genomeDir = GENDIR,
		prefix = SAMPLEOUT+"/mapping/sam/{sample}/{sample}_",
		supp=STAR_OPT["custom"],
		name="{sample}"
	priority: 50
	threads:
		THREADS["aln"]
	benchmark: SAMPLEOUT+"/benchmarks/star_aln/{sample}.benchmark.txt"
	conda:
		"envs/star.yaml"
	message: "STAR aln for {params.name}"
	shell:
		"STAR"
		" {params.supp}"
		" --genomeLoad NoSharedMemory"
		" {params.readFilesCommand}"
		" --genomeDir {params.genomeDir}"
		" --runThreadN {threads}"
		" --readFilesIn {input.fastq}"
		" --outFileNamePrefix {params.prefix}"
		" --quantMode GeneCounts"

rule cp_STAR_quant_to_counts:
	input:SAMPLEOUT+"/mapping/sam/{sample}/{sample}_ReadsPerGene.out.tab"
	output:SAMPLEOUT+"/mapping/counts/STAR/{sample}_counts.tsv"
	priority:50
	message: "Copy {input} to {output}"
	benchmark:SAMPLEOUT+"/benchmarks/cp_STAR_quant_to_counts/{sample}.benchmark.txt"
	conda:
		"envs/pipeline.yaml"
	shell:"cp {input} {output}"

