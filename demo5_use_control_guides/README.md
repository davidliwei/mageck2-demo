# Use control guides in analysis

This *--control-sgrna* or *--control-gene* tells MAGeCK to use provided negative control sgRNAs to normalize guides, 
and generate the null distribution when calculating the p values. 
If this option is not specified, MAGeCK generates the null distribution of RRA scores by assuming all of the genes in the library are non-essential. 
This approach is sometimes over-conservative, and you can improve this if you know some genes are not essential. 
By providing the corresponding sgRNA IDs in the --control-sgrna option, MAGeCK will have a better estimation of p values.

In addition, you can use the list of negative control sgRNAs to do the normalization. 
If *--norm-method control* option is specified, the median factor used for normalization will be calculated based on control sgRNAs only, rather than all the sgRNAs (by default).

New since 0.5.9.3: We include a new demo (demo5) in the MAGeCK source code to demonstrate the usage of control-sgrnas. Besides, we have an additional --control-gene option to specify the control genes instead of control sgRNAs.

To use this option, you need to prepare a text file specifying the IDs of control sgRNAs (or genes), one line for one sgRNA ID (or gene ID). 
Here is an example of the file:

    NonTargetingControlGuideForHuman_0001
    NonTargetingControlGuideForHuman_0002
    NonTargetingControlGuideForHuman_0003
    NonTargetingControlGuideForHuman_0004

There are several issues that you need to keep in mind:

* You should have enough number of negative control guides (>100 recommended) for accurate p value estimation and normalization.
* It is known that for growth based screens, non-targeting controls may lead to high false positives (e.g., Morgens et al. 2017). Use non-targeting controls carefully.
* Our [mageckflute](https://www.nature.com/articles/s41596-018-0113-7) protocol uses a list of non-essential genes which would be a good source for control guides in the analysis.

