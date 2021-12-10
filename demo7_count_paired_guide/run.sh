
#!/bin/bash

mageck2 count -l lib/Cpf1_lib.txt -n count/pg_test --sample-label HAP1_Dual,HAP1_Dual_Torin1 --pairguide auto   --reverse-complement --list-seq-2 lib/Cas9_lib.txt  --fastq fastq/SRR10969645_1.fastq.gz fastq/SRR10969652_1.fastq.gz --fastq-2 fastq/SRR10969645_2.fastq.gz fastq/SRR10969652_2.fastq.gz


mageck2 count -l lib/Cpf1_lib.txt -n count/pg_full --sample-label HAP1_Dual,HAP1_Dual_Torin1 --pairguide auto   --reverse-complement --list-seq-2 lib/Cas9_lib.txt  --fastq fastq/SRR10969645_1.fastq.gz fastq/SRR10969652_1.fastq.gz --fastq-2 fastq/SRR10969645_2.fastq.gz fastq/SRR10969652_2.fastq.gz

mageck2 count -l lib/Cpf1_lib.txt -n count/pg_full-pair --sample-label HAP1_Dual,HAP1_Dual_Torin1 --pairguide auto  --pg-pair-only lib/guide_pair.txt   --reverse-complement --list-seq-2 lib/Cas9_lib.txt   --fastq fastq/SRR10969645_1.fastq.gz fastq/SRR10969652_1.fastq.gz --fastq-2 fastq/SRR10969645_2.fastq.gz fastq/SRR10969652_2.fastq.gz
