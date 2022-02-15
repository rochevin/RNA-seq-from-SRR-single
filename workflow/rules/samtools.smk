rule sam_to_bam:
	input:
		sam=SAMPLEOUT+"/mapping/sam/{prefix}/{prefix}_Aligned.out.sam",
		genome=GENOME+".fai"
	output:
		temp(SAMPLEOUT+"/mapping/bam/{prefix}.bam")
	params:
		quality=SAMTOOLS_OPT["quality"],
		custom=SAMTOOLS_OPT["custom"]
	benchmark :
		SAMPLEOUT+"/benchmarks/sam_to_bam/{prefix}.txt"
	conda:
		"envs/samtools.yaml"
	priority: 50
	threads: THREADS["samtools"]
	message: "##RUNNING : samtools view for {input.sam}"
	shell:
		"samtools view "
		"{params.custom} -@ {threads} "
		"-b -S "
		"-q {params.quality} "
		"-t {input.genome} "
		"-o {output} "
		"{input.sam}"

rule samtools_sort:
	input:
		bam=SAMPLEOUT+"/mapping/bam/{prefix}.bam"
	output:
		protected(SAMPLEOUT+"/mapping/bam/{prefix}.sorted.bam")
	benchmark :
		SAMPLEOUT+"/benchmarks/samtools_sort/{prefix}.txt"
	conda: "envs/samtools.yaml"
        priority: 50
        threads: THREADS["samtools"]
	message: "##RUNNING : samtools sort {input.bam}"
	shell:
		"samtools sort -@ {threads} "
		"-o {output} "
		"{input.bam}"

rule samtools_index_sorted:
	input:
		bam=SAMPLEOUT+"/mapping/bam/{prefix}.sorted.bam"
	output:
		protected(SAMPLEOUT+"/mapping/bam/{prefix}.sorted.bai")
	benchmark :
		SAMPLEOUT+"/benchmarks/samtools_index_sorted/{prefix}.txt"
	conda:"envs/samtools.yaml"
        priority: 50
        threads: THREADS["samtools"]
	message: "##RUNNING : samtools index {input}"
	shell:
		"samtools index -@ {threads} {input} {output}"




#SAMTOOLS
rule samtools_faidx:
	input:
		genome=GENOME
	output:
		genome=GENOME+".fai"
	benchmark:
		SAMPLEOUT+"/benchmarks/samtools_faidx/samtools_faidx.txt"
	conda: "envs/samtools.yaml"
	priority:50
	message: "##RUNNING : samtools faidx for {input.genome}"
	shell:
		"samtools faidx {input.genome}"


