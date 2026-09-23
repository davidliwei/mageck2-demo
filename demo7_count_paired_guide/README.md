
# Demo: counting paired-guide CRISPR screens 

This demo shows an example of counting paired-guide CRISPR screening datasets. 
The example datasets are downloaded from the [CHyMErA](https://www.nature.com/articles/nbt.4062) paper, where the two guides (one from Cas9, the other from Cpf1) are integrated into one vector.
The example datasets are downloaded from [here](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE144281), 
including [GSM4284932](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM4284932) and [GSM4284933](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM4284933).

# Run the demo

Simply execute the "run.sh" in the command line to run the demo.


    ./run.sh 


# Running parameters

The following parameters ask mageck2 to count paired guides, and report all detected paired-guide counts from the fastq files.
 
    mageck2 count -l lib/Cpf1_lib.txt -n count/pg_test --sample-label HAP1_Dual,HAP1_Dual_Torin1 --pairguide secondpair --pg-start-2 3 --pg-end-2 23   --reverse-complement --list-seq-2 lib/Cas9_lib.txt  --fastq fastq/SRR10969645_1.fastq.gz fastq/SRR10969652_1.fastq.gz --fastq-2 fastq/SRR10969645_2.fastq.gz fastq/SRR10969652_2.fastq.gz


The parameters for the second guide are

    --pairguide secondpair --pg-start-2 3 --pg-end-2 23  --list-seq-2 lib/Cas9_lib.txt

These tell the program that the second guide is defined in lib/Cas9_lib.txt and is located
at positions 3-23 of read 2 (supplied with --fastq-2).

# Locating the second guide

`--pg-start-2 3 --pg-end-2 23` is a 0-based, end-exclusive window into read 2, so it
selects a 20bp slice -- the length of a Cas9 guide. Read 2 in this dataset looks like:

    NCGTAAACCAGCTTCTCTCACAGGTTT
       \__________________/
       positions 3-23: the Cas9 guide

To find the window for your own data, count how many reads match the second-guide library
exactly at each candidate offset. The right offset stands out unambiguously -- here 77% of
reads match the Cas9 library at offset 3, and under 3% at every other offset:

    gunzip -c fastq/SRR10969645_2.fastq.gz | awk 'NR%4==2' | head -20000 > r2.txt
    awk -F'\t' 'NR>1{print $2}' lib/Cas9_lib.txt | sort -u > lib2.txt
    awk 'NR==FNR{lib[$1]=1; next}
         {for(off=0; off<=5; off++){w=substr($0,off+1,20); if(w in lib) hit[off]++} tot++}
         END{for(off=0; off<=5; off++) printf "read2[%d:%d]\t%d / %d\n",off,off+20,hit[off],tot}' \
        lib2.txt r2.txt

    read2[0:20]	104 / 20000
    read2[1:21]	45 / 20000
    read2[2:22]	496 / 20000
    read2[3:23]	15465 / 20000
    read2[4:24]	103 / 20000
    read2[5:25]	0 / 20000

Adjust the guide length (20) and the offset range to match your library and read layout.

Earlier versions of this demo used `--pairguide auto`, which tried to locate the second
guide from base composition alone. That search looked for UMIs rather than guides, and was
removed in MAGeCK2 0.3.0 -- see
[mageck2#32](https://github.com/davidliwei/mageck2/issues/32). The window above is the one
it reported for this dataset, and it is correct: the commands here reproduce the counts
shown below.

The *first* guide needs no coordinates. `count` finds it on its own and reports the offset
in the log:

    INFO  @ ...: Auto determination of trim5 results: 2
    INFO  @ ...: Possible gRNA lengths:23

The 23bp Cpf1 guide starts at position 2 of read 1, reverse-complemented -- which is what
`--reverse-complement` is for.

# Dealing with reverse complements

You can use the optional parameter *--reverse-complement* or *--reverse-complement-2* to use the reverse complement sequences of the guide for search.

This demo needs only *--reverse-complement*, which applies to the first library
(lib/Cpf1_lib.txt): the Cpf1 guide appears reverse-complemented in read 1, while the Cas9
guide appears in the forward orientation in read 2.



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

    --pairguide {none,firstpair,secondpair}
                          Search for second gRNA, located within the first pair or the second pair of the read. Specify the location of the guide with --pg-start/--pg-end (if --pairguide firstpair),
                          or --pg-start-2/--pg-end-2 (if --pairguide secondpair); these are required. Note: the "auto" choice is disabled pending a reimplementation, as the search it used located UMIs
                          rather than guides and never found a usable window.
    --list-seq-2 LIST_SEQ_2
                          A library file for the second sgRNA, containing the list of sgRNA names, their sequences and associated genes. Support file format: csv and txt.
    --reverse-complement-2
                          Reverse complement the sequences in the second pair guide library for read mapping. Note: for performance considerations, only the guide sequences are reverse complemented,
                          not the read.
    --pg-start PG_START   The relative start position of the second guide, measured from the end of the first guide, when the second guide is on the first read (--pairguide firstpair). For a second
                          guide immediately following the first guide, set --pg-start to 0.
    --pg-end PG_END       The relative end position of the second guide, measured from the end of the first guide, when the second guide is on the first read (--pairguide firstpair).
    --pg-start-2 PG_START_2
                          The relative start position of the second guide, measured from the first nucleotide of the second read, when the second guide is on the second read (--pairguide secondpair).
                          For example, for a 20bp second guide at the very start of read 2, set --pg-start-2 to 0 and --pg-end-2 to 20.
    --pg-end-2 PG_END_2   The relative end position of the second guide, measured from the first nucleotide of the second read, when the second guide is on the second read (--pairguide secondpair).
    --pg-min-read PG_MIN_READ
                          Only report paired-guides whose total reads in all samples no less than this number. Setting to higher numbers to avoid reporting a large number of records with very few
                          reads. Default 3.
    --pg-pair-only PG_PAIR_ONLY
                          Only report paired-guides whose combination is listed in the file designated by --pg-pair-only. Each line in this file should has the format "sgid_1 sgid_2", where sgid_1 and
                          sgid_2 are sgRNA IDs from --list-seq and --list-seq-2, respectively. IDs that were dropped from a library for duplicating an earlier sgRNA sequence are resolved to the sgRNA
                          that represents that sequence, so a pair file written against the original library nomenclature does not need to be rewritten.



