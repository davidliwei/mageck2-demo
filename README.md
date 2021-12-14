# mageck2-demo

mageck2-demo stores the demo files for [mageck2](https://github.com/davidliwei/mageck2).

# Prerequisite

You will need to install [mageck2](https://github.com/davidliwei/mageck2) in your system first.

# How to run the demo

Simply run the script "run.sh" in the respective folder. For example



    cd demo1_rra_from_count_table
    bash run.sh


# Demos

## Basic usage of mageck2

* Demo1: Compare two conditions by runing RRA from count table. See the [README file on Demo1](demo1_rra_from_count_table/README.md).
* Demo2: Collect read counts from fastq files, followed by running RRA. See [Demo 2](demo2_run_mageck_from_fastq/README.md).

## More functions of mageck2

* Demo3: Compare multiple conditions by using MLE modle, with the option to correct CNV effects. See [Demo 3](demo3_mle_with_cnv_correction/README.md).
* Demo4: Correct CNV effects from RRA.  See [Demo 4](demo4_rra_with_cnv_correction/README.md).
* Demo5: Use control guides in RRA or MLE. See [Demo 5](demo5_use_control_guides/README.md).

## Counting UMIs using mageck2

* Demo6: Count UMIs in fastq file. See the [Demo6](demo6_countumi/README.md) for more details.


## Counting paired-guide CRISPR screens using mageck2

* Demo7: Count and search for two gRNAs in fastq file. See [Demo7](demo7_count_paired_guide/README.md) for more details.



