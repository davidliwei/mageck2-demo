Sweave("demo_countsummary.Rnw");
library(tools);

texi2dvi("demo_countsummary.tex",pdf=TRUE);

