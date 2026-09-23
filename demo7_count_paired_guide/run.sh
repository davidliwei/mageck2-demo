
#!/bin/bash

# The second guide occupies positions 3-23 of read 2 in this dataset; see README.md
# for how that window was determined.

mageck2 count -l lib/Cpf1_lib.txt -n count/pg_test --sample-label HAP1_Dual,HAP1_Dual_Torin1 --pairguide secondpair --pg-start-2 3 --pg-end-2 23   --reverse-complement --list-seq-2 lib/Cas9_lib.txt  --fastq fastq/SRR10969645_1.fastq.gz fastq/SRR10969652_1.fastq.gz --fastq-2 fastq/SRR10969645_2.fastq.gz fastq/SRR10969652_2.fastq.gz

mageck2 count -l lib/Cpf1_lib.txt -n count/pg_full-pair --sample-label HAP1_Dual,HAP1_Dual_Torin1 --pairguide secondpair --pg-start-2 3 --pg-end-2 23  --pg-pair-only lib/guide_pair.txt   --reverse-complement --list-seq-2 lib/Cas9_lib.txt   --fastq fastq/SRR10969645_1.fastq.gz fastq/SRR10969652_1.fastq.gz --fastq-2 fastq/SRR10969645_2.fastq.gz fastq/SRR10969652_2.fastq.gz
