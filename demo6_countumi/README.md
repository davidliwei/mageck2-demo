
# Demo: counting UMIs

This demo shows an example of counting UMIs in CRISPR screening datasets. 
The example datasets are downloaded from the [iBAR](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1628-0) paper, where the barcode is around 20 nucleotide dowstream of guide RNA sequence.
The example datasets are part of a larger datasets downloaded [here](https://www.ncbi.nlm.nih.gov//bioproject/PRJNA494953).

# Run the demo

Simply execute the "run.sh" in the command line to run the demo.


    ./run.sh 


# Running parameters

The running parameters are as follows.
 
    mageck2 count -l ibar_library.txt --umi auto -n count/ibar_hela  --sample-label tcb_r1,tcb_r2,ref_r1,ref_r2 --fastq fastq/SRR7975605_1.fastq.gz fastq/SRR7975606_1.fastq.gz  fastq/SRR7975595_1.fastq.gz fastq/SRR7975596_1.fastq.gz  


You can see the vast majority of the parameters are the same as counting sgRNAs in a typical CRISPR screen.
The only additional parameter is

    --umi auto

This is to tell the program to automatic search UMIs in read 1, and/or in read 2 (if --fastq-2 option is provided). 
mageck2 will first determine the possible UMI regions in either read 1 or read 2 (in this case, read 1), 
and extracts UMI barcode in that location.

# Automatic search for UMIs

The log contains information on the automatic search process. For example, you will see the log contains the following:


    INFO  @ Fri, 10 Dec 2021 20:38:34: --count-freq data for UMI search (A/T/G/C): 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   0  2741.0/1900.0/53262.0/566.0 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   1  446.0/55195.0/2551.0/276.0 
    ....
    INFO  @ Fri, 10 Dec 2021 20:38:34:   17 8481.0/1123.0/47918.0/933.0 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   18 47326.0/2210.0/6693.0/2226.0 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   19 18464.0/13658.0/12769.0/13558.0 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   20 15308.0/14454.0/13802.0/14883.0 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   21 15214.0/14929.0/14058.0/14244.0 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   22 15178.0/15808.0/12669.0/14786.0 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   23 16184.0/14792.0/13797.0/13668.0 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   24 23821.0/11978.0/13315.0/9326.0 
    INFO  @ Fri, 10 Dec 2021 20:38:34:   25 52440.0/1436.0/1844.0/2720.0 
    ....
    INFO  @ Fri, 10 Dec 2021 20:38:34: UMI found in the first read. Position (after guide): 19-25

These numbers are the A/T/G/C frequencies after the guides, where mageck2 are used to determine the possible UMI locations. 
From the frequencies, it is clear that the UMI starts from 19bp after the guide, and ends at 24bp after the guide. 
Therefore mageck2 reports the UMI location as 19-25.


# Output

You should be able to see an additional umi_count.txt file to record UMI records:

    sort -k 3,3n count/ibar_hela.umi_count.txt | grep 'CSPG4'


Here is the example output:

    sgRNA_umi       Gene    tcb_r1  tcb_r2  ref_r1  ref_r2
    CSPG4_19708_GCCTTG      CSPG4_19708     91      123     0       0
    CSPG4_19708_GGACAA      CSPG4_19708     93      106     0       0
    CSPG4_19709_CCACGC      CSPG4_19709     95      148     0       0
    CSPG4_19709_ATGTGG      CSPG4_19709     116     178     0       0
    CSPG4_19709_ACGTCG      CSPG4_19709     186     247     0       0


The columns are "sgRNAID+UMI", "sgRNAID", followed by read counts in each condition.
CSPG4 is served as a positive control that are supposed to have strong enrichment in TCDB treated samples, as is identified in [iBAR](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1628-0) paper.


# Other parameters


If you know exactly where the UMI is located, you can use optional arguments for searching for UMIs:

    --umi {none,firstpair,secondpair,auto}
                        Search UMIs, located within the first pair or the second pair of the read, or automatically search for possible UMIs. If you are aware of the location of the UMI, specify the values of --umi-start/--umi-end (if --umi firstpair),
                        or --umi-start-2/--umi-end-2 (if --umi secondpair). The program will automatically search for UMI locations if --umi auto.
    --umi-start UMI_START
                        The relative start position of UMI from guides, if UMI is found on the first pair. For example, for a read NNNNAATACGNNNCGACNNNN with guide AATACG and UMI CGAC, set --umi-start to 4 and --umi-end to 8.
    --umi-end UMI_END     The relative end position of UMI from guides, if UMI is found on the first pair.
    --umi-start-2 UMI_START_2
                        The relative start position of UMI (from the first nucleotide of the read), if UMI is found on the second pair. For example, for a read NNNNCGAC with UMI CGAC, set --umi-start-2 to 4 and --umi-end-2 to 8.
    --umi-end-2 UMI_END_2
                        The relative end position of UMI (from the first nucleotide of the read), if UMI is found on the second pair.



