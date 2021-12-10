#!/bin/bash


# we use a simple example in demo1 to demonstrate the use of negative control sgrnas or genes

# users can specify the list of control sgRNAs:

mageck2 test -k sample.txt -t HL60.final,KBM7.final -c HL60.initial,KBM7.initial  -n demo_ctrlsg --norm-method control --control-sgrna control_sgrna.txt    

# or, the list of control genes:

mageck2 test -k sample.txt -t HL60.final,KBM7.final -c HL60.initial,KBM7.initial  -n demo_ctrlgene --norm-method control --control-gene control_gene.txt

# for mageck mle in demo 3 , you can use it in a similar approach

mageck2 mle -k leukemia.new.csv -d designmat.txt -n beta_leukemia_controlsg --norm-method control --control-sgrna control_sgrna.txt  --permutation-round 2

mageck2 mle -k leukemia.new.csv -d designmat.txt -n beta_leukemia_controlgene --norm-method control --control-gene control_gene.txt  --permutation-round 2


