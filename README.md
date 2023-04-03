Mitogenome Comparative Analysis - ABas & CBas
========================================
Ryan Snow

Copmarative analysis of *Salarias fasciatus* mitochondrial assemblies from samples collected during the USS Albatross fieldwork (approximately 100 years ago) and current, contemporary assemblies. The intent of this study is to potentially identify any mitochondrial variants that may play a role in stress acclimation, associated with climate change responses. Initial thoughts behind this study were derived from several components 
1. Mitochondrial plasticity and likelihood to adapt while mainting core functions 
1. Energy metabolism genes' role as an important factor in stress acclimation and adaptation responses across phyla 
1. Importance of oxygen availability in a warming ocean and the association with mitochondria. 

The data collected data was sequenced using a lcwgs technique. The low-coverage aspect of this study is regarded as a non-issue due to the abundance of mitochondria, and mitochondrial DNA, in cells, allowing for in-depth assemblies of the ~16,500 bp (mito)genome.

### ABas - USS Albatross Samples
### CBas - Contemporary Samples
### Bas - Combination of ABas and CBas Samples
### [Sfa_mtDNA](Sfa_mtDNA_Ref.fasta) - Salarias fasciatus Mitochondrion Reference

# Steps for mitogenmoic comparative analysis:

1. [MUMmerQuery](MUMmerQuery.sh)
	* Creates a multifasta files containing the samples of interest 
1. [Nucmer_mtDNA](Nucmer_mtDNA.sh)
	* Performs Nucmer on all fasta files using Sfa_mtDNA as a reference
	<!-- The *m-to-m* files are to be used --!>
1. [SNPs2Counts.R](SNPs2Counts.R)
	* Transforms Nucmer SNPs to counts in vcf file format	
1. [mtDNAFilter.R](mtDNAFilter.R)
	* Applies filter to the vcf formatted SNP data
1. [SnpEff](snpEff.sh)
	* Annotation from gff3 to vcf
	1. [Assemblytics.sh](Assemblytics) (Optional - May be removed, Not properly running)
		* Calls structural variants
1. [SnpSift](snpSift.sh)
	* Performs Hardy-Weinberg equilibrium and calls TsTv information
1. [Plink](Plink.sh)
	* Creates eigenvec and eigenval files for diversity statistics
1. [DiversityStats.R](DiversityStats.R)
	* Calculation of diversity statistics (Fst)

# Steps for phylogenetic verification

1. MEGA...MUSCLE...


# Versions

* Nucmer - 
* R Studio - 
