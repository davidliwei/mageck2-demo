#!/bin/bash


# automatically match the labels in designmat.txt with the columns in cnv_data
mageck2 mle -k leukemia.new.csv -d designmat.txt -n beta_leukemia --cnv-norm cnv_data.txt --permutation-round 2

# or, specify the cell lines to be used (this will ignore the labels in designmat.txt)
mageck2 mle -k leukemia.new.csv -d designmat.txt -n beta_leukemia_hl60 --cnv-norm cnv_data.txt --permutation-round 2 --cell-line HL60_HAEMATOPOIETIC_AND_LYMPHOID_TISSUE
