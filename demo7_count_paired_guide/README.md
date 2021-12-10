
# Demo: counting paired-guide CRISPR screens 

This demo shows an example of counting paired-guide CRISPR screening datasets. 
The example datasets are downloaded from the [CHyMErA](https://www.nature.com/articles/nbt.4062) paper, where the two guides (one from Cas9, the other from Cpf1) are integrated into one vector.
The example datasets are downloaded from [here](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE144281), 
including [GSM4284932](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM4284932) and [GSM4284933](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM4284933).

# Run the demo

Simply execute the "run.sh" in the command line to run the demo.


    ./run.sh 


# Running parameters

The following parameters ask mageck2 to search for possible paired-guides, and report all possible detected paired-guide counts from the fastq files.
 
    mageck2 count -l lib/Cpf1_lib.txt -n count/pg_test --sample-label HAP1_Dual,HAP1_Dual_Torin1 --pairguide auto   --reverse-complement --list-seq-2 lib/Cas9_lib.txt  --fastq fastq/SRR10969645_1.fastq.gz fastq/SRR10969652_1.fastq.gz --fastq-2 fastq/SRR10969645_2.fastq.gz fastq/SRR10969652_2.fastq.gz


The parameter to search for paired guides is

    --pairguide auto  --list-seq-2 lib/Cas9_lib.txt 

This is to tell the program to automatic search the second pair of guides, defined in lib/Cas9_lib.txt, in read 1 and/or read 2 (if --fastq-2 option is provided). 

# Automatic search for paired-guides 

The program will automatically invoke functions (used in UMI search), and search for the position of the second pair, which can be seen from the log file:


    INFO  @ Fri, 10 Dec 2021 21:23:20: --count-freq data for UMI search (A/T/G/C): 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   0  676.0/334.0/1005.0/97840.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   1  490.0/351.0/3159.0/96000.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   2  1206.0/1380.0/96291.0/1123.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   3  23641.0/31222.0/20874.0/24263.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   4  23907.0/24992.0/25487.0/25614.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   5  30009.0/25083.0/25852.0/19056.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   6  23894.0/22071.0/30305.0/23730.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   7  25325.0/23821.0/24872.0/25982.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   8  27601.0/22515.0/26819.0/23065.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   9  25463.0/21730.0/26773.0/26034.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   10 25964.0/24308.0/24283.0/25445.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   11 30569.0/23156.0/24184.0/22091.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   12 27912.0/20554.0/26844.0/24690.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   13 28507.0/21945.0/25156.0/24392.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   14 27557.0/25686.0/20188.0/26569.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   15 21366.0/22573.0/23919.0/32142.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   16 27395.0/30513.0/19355.0/22737.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   17 24901.0/29269.0/21488.0/24342.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   18 24725.0/22841.0/22141.0/30293.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   19 24447.0/19864.0/26083.0/29606.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   20 20198.0/19699.0/21011.0/39092.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   21 20903.0/19662.0/33093.0/26342.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   22 28894.0/4639.0/42112.0/24355.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   23 1585.0/12324.0/84864.0/1227.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   24 1279.0/93910.0/3375.0/1436.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20:   25 2218.0/94091.0/1717.0/1974.0 
    INFO  @ Fri, 10 Dec 2021 21:23:20: UMI found in the second read. Position: 3-23

These numbers are the A/T/G/C frequencies after the guides, where mageck2 are used to determine the possible guide locations. 
From the frequencies, the second sgRNA starts from 3bp in the second read, and ends at 23bp. 

# Dealing with reverse complements

You can use the optional parameter *--reverse-complement* or *--reverse-complement-2* to use the reverse complement sequences of the guide for search.



# Output

You should be able to see an additional pg_count.txt file to record UMI records:

    head count/pg_test.pg_count.txt 


Here is the example output:

    sgRNA1_sgRNA2   Gene1_Gene2     HAP1_Dual       HAP1_Dual_Torin1
    Cpf1:Paralogs:USP21:CTAGTGTCTCCCCTGTCAGTGAA_Cas9:Paralogs:USP2:GCCCATCCAGAAGAAAGCGA     USP21:exonic_USP2:exonic        4       0
    Cpf1:DualTargeting:---:CATGCAGAACAACACATCCTTAA_Cas9:DualTargeting:CD2AP:CTTCTTGAGTGGTGTGGACC    CD2AP:intergenic_CD2AP:exonic   4       0
    Cpf1:Paralogs:UNC5B:GGATACTCACCGGTCCATAGAGA_Cas9:Paralogs:UNC5C:AACCCGGCACCACTCAATGG    UNC5B:exonic_UNC5C:exonic       3       0
    Cpf1:Paralogs:UNC5B:GGATACTCACCGGTCCATAGAGA_Cas9:Paralogs:UNC5C:ACACTTGAAATAGATCTGGG    UNC5B:exonic_UNC5C:exonic       5       0
    Cpf1:Paralogs:RBL2:TGTCACACCAGTTCCTGGACAGA_Cas9:Paralogs:RBL1:TCTTGACAGACGCGTTTGGC      RBL2:exonic_RBL1:exonic 5       0
    Cpf1:Paralogs:RBL2:TGTCACACCAGTTCCTGGACAGA_Cas9:Paralogs:---:TGCCATAACTTGTGCCATGG       RBL2:exonic_---:intergenic      5       0
    Cpf1:Paralogs:RBL2:TGTCACACCAGTTCCTGGACAGA_Cas9:Paralogs:RBL1:CAGGAGCTGAACCTGGACGA      RBL2:exonic_RBL1:exonic 4       0
    Cpf1:Paralogs:TTC39A:ACCAAGCACTCGTCATCCACTGA_Cas9:Paralogs:TTC39B:TCAGAAGAACAAACTTCAGC  TTC39A:exonic_TTC39B:exonic     3       0
    Cpf1:Paralogs:TTC39A:ACCAAGCACTCGTCATCCACTGA_Cas9:Paralogs:TTC39B:ATTGATCAGAACTTGAAGGA  TTC39A:exonic_TTC39B:exonic     5       0

The output will be the concatenation of two sgRNA IDs (separated by the underscore _), the concatenation of two genes (separated by the underscore _),
followed by the read counts in each sample.

# Only report guide pairs in the design

The default parameter reports guides as long as they both can be found in the two libraries (Cas9_lib.txt and Cpf1_lib.txt, respectively).
To only report guide pairs in the design, the second run uses the following paramter:

    --pg-pair-only lib/guide_pair.txt   


where guide_pair.txt lists two sgRNA ID combinations that are allowed:

    guide1    guide2
    Cpf1:DualTargeting:---:GAGCCACTGATTATACCTCTAGT  Cas9:DualTargeting:GSK3B:CGGCAGCAAGGTGACAACAG
    Cpf1:DualTargeting:---:GAGCCACTGATTATACCTCTAGT  Cas9:DualTargeting:GSK3B:GCGGGAGATAGAGGCTCGTA
    Cpf1:DualTargeting:---:GGCGTCTGCGTCCTGCACAACTG  Cas9:DualTargeting:KEAP1:AATGAACACCATCCGAAGCG
    Cpf1:DualTargeting:---:GAAGAATCAAGTGTTAGGATTCA  Cas9:DualTargeting:DAPK3:CGTGAACTACGACTTCGACG


# Other parameters


If you know exactly where the second guide is located, you can use optional arguments:

Optional arguments for counting paired-guide screens:

    --pairguide {none,firstpair,secondpair,auto}
                          Search for second gRNA, located within the first pair or the second pair of the read, or automatically search for possible guides. If you are aware of the location of the guide, specify the values of --pg-start/--pg-end (if
                          --pairguide firstpair), or --pg-start-2/--pg-end-2 (if --pairguide secondpair). The program will automatically search for locations if --pairguide auto.
    --list-seq-2 LIST_SEQ_2
                          A library file for the second sgRNA, containing the list of sgRNA names, their sequences and associated genes. Support file format: csv and txt.
    --reverse-complement-2
                          Reverse complement the sequences in the second pair guide library for read mapping. Note: for performance considerations, only the guide sequences are reverse complemented, not the read.
    --pg-start PG_START   The relative start position of UMI from guides, if UMI is found on the first pair. For example, for a read NNNNAATACGNNNCGACNNNN with guide AATACG and UMI CGAC, set --umi-start to 4 and --umi-end to 8.
    --pg-end PG_END       The relative end position of UMI from guides, if UMI is found on the first pair.
    --pg-start-2 PG_START_2
                          The relative start position of UMI (from the first nucleotide of the read), if UMI is found on the second pair. For example, for a read NNNNCGAC with UMI CGAC, set --umi-start-2 to 4 and --umi-end-2 to 8.
    --pg-end-2 PG_END_2   The relative end position of UMI (from the first nucleotide of the read), if UMI is found on the second pair.
    --pg-min-read PG_MIN_READ
                          Only report paired-guides whose total reads in all samples no less than this number. Setting to higher numbers to avoid reporting a large number of records with very few reads. Default 2.
    --pg-pair-only PG_PAIR_ONLY
                          Only report paired-guides whose combination is listed in the file designated by --pg-pair-only. Each line in this file should has the format "sgid_1 sgid_2", where sgid_1 and sgid_2 are sgRNA IDs from --list-seq and --list-seq-2,
                          respectively.



