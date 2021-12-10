pdf(file='demo.pdf',width=4.5,height=4.5);
gstable=read.table('demo.gene_summary.txt',header=T)
# 
#
# parameters
# Do not modify the variables beginning with "__"

# gstablename='__GENE_SUMMARY_FILE__'
startindex=3
# outputfile='__OUTPUT_FILE__'
targetgenelist=c("ACTR8","ACIN1","AHCY","AATF","ABT1","AHCTF1","ACLY","ADIRF","AGBL5","ACTR3")
# samplelabel=sub('.\\w+.\\w+$','',colnames(gstable)[startindex]);
samplelabel='HL60.final,KBM7.final_vs_HL60.initial,KBM7.initial neg.'


# You need to write some codes in front of this code:
# gstable=read.table(gstablename,header=T)
# pdf(file=outputfile,width=6,height=6)


# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")

######
# function definition

plotrankedvalues<-function(val, tglist, ...){
  
  plot(val,log='y',ylim=c(max(val),min(val)),type='l',lwd=2, ...)
  if(length(tglist)>0){
    for(i in 1:length(tglist)){
      targetgene=tglist[i];
      tx=which(names(val)==targetgene);ty=val[targetgene];
      points(tx,ty,col=colors[(i %% length(colors)) ],cex=2,pch=20)
      # text(tx+50,ty,targetgene,col=colors[i])
    }
    legend('topright',tglist,pch=20,pt.cex = 2,cex=1,col=colors)
  }
}



plotrandvalues<-function(val,targetgenelist, ...){
  # choose the one with the best distance distribution
  
  mindiffvalue=0;
  randval=val;
  for(i in 1:20){
    randval0=sample(val)
    vindex=sort(which(names(randval0) %in% targetgenelist))
    if(max(vindex)>0.9*length(val)){
      # print('pass...')
      next;
    }
    mindiffind=min(diff(vindex));
    if (mindiffind > mindiffvalue){
      mindiffvalue=mindiffind;
      randval=randval0;
      # print(paste('Diff: ',mindiffvalue))
    }
  }
  plot(randval,log='y',ylim=c(max(randval),min(randval)),pch=20,col='grey', ...)
  
  if(length(targetgenelist)>0){
    for(i in 1:length(targetgenelist)){
      targetgene=targetgenelist[i];
      tx=which(names(randval)==targetgene);ty=randval[targetgene];
      points(tx,ty,col=colors[(i %% length(colors)) ],cex=2,pch=20)
      text(tx+50,ty,targetgene,col=colors[i])
    }
  }
  
}




# set.seed(1235)



pvec=gstable[,startindex]
names(pvec)=gstable[,'id']
pvec=sort(pvec);

plotrankedvalues(pvec,targetgenelist,xlab='Genes',ylab='RRA score',main=paste('Distribution of RRA scores in \\n',samplelabel))

# plotrandvalues(pvec,targetgenelist,xlab='Genes',ylab='RRA score',main=paste('Distribution of RRA scores in \\n',samplelabel))


pvec=gstable[,startindex+1]
names(pvec)=gstable[,'id']
pvec=sort(pvec);

plotrankedvalues(pvec,targetgenelist,xlab='Genes',ylab='p value',main=paste('Distribution of p values in \\n',samplelabel))

# plotrandvalues(pvec,targetgenelist,xlab='Genes',ylab='p value',main=paste('Distribution of p values in \\n',samplelabel))



# you need to write after this code:
# dev.off()






# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(2674.7657941046295,2294.76646752251,1851.4403872098367,812.8016679134727),c(1068.3236159885355,981.7368258637497,633.8119095587681,178.69383402620315),c(1364.2888251586928,1129.1708014793305,213.95855810380806,37.780982051254384),c(1615.9383880359921,1285.2773638958276,682.1944980747046,1317.228833678869),c(2073.339165844417,2006.8365857320819,166.1135539047153,209.83761652791284),c(378.2656951426074,763.1876384806534,194.06793838058974,557.0142083502504),c(1851.7609343801282,983.471343223933,303.7351390167125,198.09487886333378),c(973.3615167895546,1411.897131189209,1263.3231445827864,941.4612284123389),c(701.1368324191426,1056.3210723516318,490.8144812783336,956.777842757442),c(307.0441207433717,398.93899284215973,84.40073774446701,39.82319729726813))
targetgene="ACTR8"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(604.5920315668453,804.8160551250527,365.01975113689866,516.6804572414788),c(3687.694852227093,3729.212324394102,1697.6912725925274,615.7278966731458),c(911.636152310217,962.6571349017333,285.4572722440253,371.17262096299913),c(2619.3712362385577,2072.748245419047,909.5926640996062,138.87063672893504),c(1408.6044714515506,2135.190870385646,1263.3231445827864,889.8952934504917),c(436.8256563153123,261.9121213876788,145.14776554780948,98.02633180866002),c(690.0579208459282,546.3729684577405,606.3951093997374,564.1619617112985),c(1019.2598647357287,459.6471004485754,565.0011170027695,408.4430492027501),c(265.89387775714664,173.45173601833034,24.19129425796825,0.0),c(612.5055398334271,598.4084892632396,480.60037925830255,241.491952841126))
targetgene="ACIN1"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(324.45383892985154,641.7714232678222,194.60552269743346,122.53291476082502),c(1229.759184626803,1073.6662459534648,96.22759271502926,89.85747082460502),c(849.9107878308794,655.6475621492887,616.6092114197685,525.3598720370372),c(422.58134143546516,402.40802756252634,284.9196879271816,190.94712550228567),c(2163.553160083449,2183.7573564707786,2076.6882159673632,1729.2457595621431),c(1153.7895052676183,397.20447548197643,549.9487561311448,311.94837882860037),c(66.47346943928666,213.3456353025463,523.6071246058017,403.84806489921914),c(701.1368324191426,858.5860932907351,202.13170313324582,16.84827577961344),c(1750.468028567882,1377.2067839855429,1828.8618459023996,1772.6428335399353),c(1134.7970854278221,862.0551280111017,90.85174954659186,94.45245512813595))
targetgene="AHCY"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(710.6330423390407,790.9399162435863,750.4677063138595,715.7964437278195),c(780.27191508496,1061.5246244321816,592.4179171618002,274.16739677734597),c(900.5572407370025,1259.2596034930782,399.425147414898,158.7822353775691),c(395.67541332908723,558.5145899790236,255.8901348176197,104.15297754670127),c(558.6936836206712,617.488180225256,534.8963952595202,275.6990582118563),c(436.8256563153123,253.2395345867623,276.3183388576818,148.57115914750034),c(2256.9325576291135,1914.9071656423669,1340.7352862082848,562.1197464652848),c(299.13061247678996,424.9567532449093,155.36186756784053,0.0),c(1071.4890192951682,466.5851698893086,620.3723016376747,245.57638333315347),c(2353.4773584814106,1448.3219957530582,1484.270298805563,1661.8526564436893))
targetgene="AATF"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(525.4569489010279,359.0450935579438,266.1042368376507,393.6369886691504),c(386.17920340918914,385.0628539606933,505.3292578331145,239.44973759511223),c(1877.0841608331898,1933.986856604383,713.3743884516415,251.1924752596913),c(1720.3966971548714,1430.9768221512252,907.979911149075,885.8108629584642),c(128.19883391862427,369.4521977190436,158.04978915205922,114.87460758827346),c(1061.99280937527,728.4972912769874,279.5438447587442,269.57241247381506),c(563.4417885806203,678.1962878316716,287.07002519455654,533.5287330210923),c(1682.411857475279,745.8424648788204,359.6439079684613,196.56321742882346),c(33.23673471964333,175.18625337851364,203.2068717669333,164.90888111561034),c(365.6040819160766,437.0983747661924,264.4914838871195,183.79937214123754))
targetgene="ABT1"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(212.08202154439076,294.86795123116156,361.2566609189925,30.633228690206256),c(1191.7743449472107,1032.0378293090655,1485.3454674392506,720.3914280313504),c(805.5951415380216,476.9922740504084,204.28204040062076,426.3124326053704),c(1179.11273172068,862.0551280111017,713.9119727684852,325.7333317391932),c(729.6254621788369,308.744090112628,523.0695402889579,731.1130580729226),c(1161.7030135342002,1571.4727283260727,297.2841272145876,173.07774209966536),c(1547.8822169433893,1070.1972112330982,273.09283295661936,143.9761748439694),c(910.0534506569006,645.2404579881888,461.24734385192795,571.8202688838501),c(593.5131199936309,723.2937391964375,940.2349701596993,555.4825469157402),c(647.3249762063867,879.4003016129348,626.8233134397996,672.9099235615307))
targetgene="AHCTF1"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(1365.871526812009,1378.941301345726,968.1893546355736,538.6342711361267),c(352.9424686895458,444.03644420692564,44.08191398118659,21.44326008314438),c(142.4431487984714,235.89436098492925,104.82894178452908,58.71368832289532),c(533.3704571676096,572.3907288604901,238.1498523617763,217.4959237004644),c(1087.3160358283317,1077.1352806738314,1054.202845330572,896.5324930000364),c(944.8728870298603,699.0104961538713,458.55942226770924,530.4654101520716),c(1717.2312938482387,1082.3388327543812,516.0809441699893,113.85349996526658),c(338.6981538096987,246.30146514602907,75.79938867496718,321.13834743566224),c(552.3628770074058,263.6466387478621,175.25248729105886,112.83239234225971),c(819.8394564178687,464.8506525291253,476.8372890403964,532.5076253980855))
targetgene="ACLY"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(530.2050538609769,216.8146700229129,263.9538995702758,91.89968607061877),c(262.72847445051394,234.15984362474595,111.27995358665395,155.71891250854847),c(791.3508266581745,657.382079509472,528.982967774239,420.1857868673291),c(1156.954908574251,927.9667876980673,938.0846328923243,663.7199549544689),c(756.5313902852148,986.9403779442996,1100.4350965791334,907.7646768531121),c(1774.2085533676272,742.3734301584537,584.3541524091441,542.7187016281541),c(1024.0079696956777,844.7099544092687,517.1561128036768,686.1843226606202),c(468.4796893816393,424.9567532449093,234.92434646071388,303.2689640330419),c(96.54480085229729,204.67304850162978,177.94040887527757,271.6146277198288),c(1430.7622945979795,1535.0478637622234,956.9000839818552,1210.5230870746504))
targetgene="ADIRF"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(690.0579208459282,588.0013851021398,261.80356230290084,172.05663447665847),c(381.4310984492401,274.0537429089619,174.1773186573714,246.08693714465693),c(838.8318762576649,910.6216140962342,663.3790469851738,807.6961297984383),c(672.6482026594483,541.1694163771906,316.09957830411844,498.3005200273551),c(1220.262974706905,1361.596127743893,544.5729129627075,1009.3648853422961),c(455.8180761551085,402.40802756252634,191.38001679637102,380.87314338156443),c(319.7057339699025,810.0196072056026,417.1654298707414,1100.243463789908),c(737.5389704454186,534.2313469364574,335.9901980273368,505.4482733884032),c(474.81049599490467,615.7536628650727,370.3955943053361,407.9324953912466),c(1193.3570466005272,1923.5797524432833,908.5174954659187,1190.100934614513))
targetgene="AGBL5"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(1103.1430523614952,1330.3748152605936,753.1556278980781,353.81379137188225),c(1236.0899912400685,1021.6307251479657,691.3334314610481,166.44054255012065),c(1418.1006813714487,1151.7195271617134,1142.366673292945,945.035105092863),c(963.8653068696565,804.8160551250527,596.7185916965501,509.53270388043074),c(1025.5906713489942,1068.4626938729148,1055.8155982811031,1300.8911117107589),c(829.3356663377668,535.9658642966407,641.3380899945805,328.2861007967104),c(91.79669589234824,620.9572149456226,154.28669893415307,557.0142083502504),c(777.1065117783273,751.0460169593703,498.34066171414594,792.8900692648385),c(584.0169100737328,757.9840864001035,356.41840206739886,416.61191018680506),c(2337.6503419482474,2197.633495352245,1198.275442244694,1038.466452597992))
targetgene="ACTR3"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}



# 
#
# parameters
# Do not modify the variables beginning with "__"

# gstablename='__GENE_SUMMARY_FILE__'
startindex=9
# outputfile='__OUTPUT_FILE__'
targetgenelist=c("ACRC","ABCB8","ADRA1A","AGTPBP1","AHRR","ADCK1","ACTR1A","ADNP2","ADK","ADRBK1")
# samplelabel=sub('.\\w+.\\w+$','',colnames(gstable)[startindex]);
samplelabel='HL60.final,KBM7.final_vs_HL60.initial,KBM7.initial pos.'


# You need to write some codes in front of this code:
# gstable=read.table(gstablename,header=T)
# pdf(file=outputfile,width=6,height=6)


# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")

######
# function definition

plotrankedvalues<-function(val, tglist, ...){
  
  plot(val,log='y',ylim=c(max(val),min(val)),type='l',lwd=2, ...)
  if(length(tglist)>0){
    for(i in 1:length(tglist)){
      targetgene=tglist[i];
      tx=which(names(val)==targetgene);ty=val[targetgene];
      points(tx,ty,col=colors[(i %% length(colors)) ],cex=2,pch=20)
      # text(tx+50,ty,targetgene,col=colors[i])
    }
    legend('topright',tglist,pch=20,pt.cex = 2,cex=1,col=colors)
  }
}



plotrandvalues<-function(val,targetgenelist, ...){
  # choose the one with the best distance distribution
  
  mindiffvalue=0;
  randval=val;
  for(i in 1:20){
    randval0=sample(val)
    vindex=sort(which(names(randval0) %in% targetgenelist))
    if(max(vindex)>0.9*length(val)){
      # print('pass...')
      next;
    }
    mindiffind=min(diff(vindex));
    if (mindiffind > mindiffvalue){
      mindiffvalue=mindiffind;
      randval=randval0;
      # print(paste('Diff: ',mindiffvalue))
    }
  }
  plot(randval,log='y',ylim=c(max(randval),min(randval)),pch=20,col='grey', ...)
  
  if(length(targetgenelist)>0){
    for(i in 1:length(targetgenelist)){
      targetgene=targetgenelist[i];
      tx=which(names(randval)==targetgene);ty=randval[targetgene];
      points(tx,ty,col=colors[(i %% length(colors)) ],cex=2,pch=20)
      text(tx+50,ty,targetgene,col=colors[i])
    }
  }
  
}




# set.seed(1235)



pvec=gstable[,startindex]
names(pvec)=gstable[,'id']
pvec=sort(pvec);

plotrankedvalues(pvec,targetgenelist,xlab='Genes',ylab='RRA score',main=paste('Distribution of RRA scores in \\n',samplelabel))

# plotrandvalues(pvec,targetgenelist,xlab='Genes',ylab='RRA score',main=paste('Distribution of RRA scores in \\n',samplelabel))


pvec=gstable[,startindex+1]
names(pvec)=gstable[,'id']
pvec=sort(pvec);

plotrankedvalues(pvec,targetgenelist,xlab='Genes',ylab='p value',main=paste('Distribution of p values in \\n',samplelabel))

# plotrandvalues(pvec,targetgenelist,xlab='Genes',ylab='p value',main=paste('Distribution of p values in \\n',samplelabel))



# you need to write after this code:
# dev.off()






# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(496.96831914133355,490.86841293187484,379.5345276916796,793.4006230763421),c(82.30048597245015,88.46038536934847,381.14728064221083,318.58557837814504),c(278.55549098367743,669.5237010307551,454.7963320498031,500.3427352733688),c(250.06686122398312,666.0546663103885,234.92434646071388,417.1224639983085),c(1500.4011673438988,1437.9148915919584,885.9389541584817,475.3255985097004),c(2579.8036949056486,2384.961370252042,2098.7291729579565,2196.4024970877886),c(533.3704571676096,591.4704198225064,988.079974358792,1443.335625120218),c(734.3735671387859,803.0815377648694,1339.6601175745973,1190.100934614513),c(1035.0868812688923,1071.9317285932814,817.6657459193268,807.6961297984383),c(2089.1661823775808,1259.2596034930782,803.1509693645459,984.8583023901311))
targetgene="ACRC"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(644.159572899754,1011.2236209868659,934.3215426744182,1506.6442977466443),c(1299.3980573727224,737.169878077904,811.7523184340457,549.8664549892023),c(158.2701653316349,260.1776040274955,249.43912301549483,221.06980038098848),c(471.645092688272,390.2664060412432,188.1545108953086,246.08693714465693),c(161.4355686382676,253.2395345867623,750.4677063138595,218.5170313234713),c(397.2581149824036,185.59335753961344,596.7185916965501,349.72936087985477),c(1016.094461429096,738.9043954380872,524.1447089226453,1309.5705265063175),c(832.5010696443995,834.3028502481689,544.0353286458637,565.6936231458088),c(1175.9473284140472,905.4180620156843,752.6180435812344,1074.7157732147361),c(269.05928106377934,372.9212324394102,537.0467325268951,512.5960267494513))
targetgene="ABCB8"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(174.0971818647984,225.48725682382943,320.9378371557121,437.544616458446),c(0.0,0.0,58.0591062191238,164.3983273041069),c(1133.214383774506,1273.1357423745446,839.1691185930764,970.0522418565314),c(873.6513126306246,567.1871767799402,630.048819340862,558.5458697847607),c(1691.908067395177,1422.3042353503088,1221.9291521858183,1233.4980085923053),c(359.2732753028112,544.6384510975572,538.6594854774263,607.5590356890907),c(1090.4814391349644,960.92261754155,859.5973226331384,736.7291499994604),c(610.9228381801107,496.07196501242476,426.3043632570849,330.3283160427241),c(1177.5300300673637,912.3561314564175,619.2971330039871,745.9191186065224),c(598.2612249535799,485.66486085132493,816.0529929687956,201.1582017323544))
targetgene="ADRA1A"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(840.4145779109813,853.3825412101852,1219.7788149184435,1317.228833678869),c(1801.114481474005,882.8693363333014,1026.2484608546974,1346.330400934565),c(783.4373183915927,435.3638574060091,427.9171162076161,420.6963406788326),c(2141.39533693702,1214.1621521283123,1219.7788149184435,1409.1285197494879),c(0.0,353.8415414773939,373.08351588955475,341.56049989579975),c(471.645092688272,333.02733315519424,390.82379834539813,606.5379280660839),c(326.0365405831679,327.82378107464433,233.8491778270264,310.41671739409),c(1266.1613226530792,1120.498214678414,774.6590005718277,1091.5640489943496),c(169.34907690484934,116.21266313228132,34.40539627799929,538.1237173246233),c(705.8849373790916,438.8328921263757,384.91037086011704,461.03009178760414))
targetgene="AGTPBP1"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(371.934888529342,159.5755971368639,404.26340626649164,429.37575547439104),c(447.90456788852674,364.2486456384937,181.16591477634,311.43782501709694),c(1.582701653316349,81.52231592861526,0.0,56.16091926537813),c(378.2656951426074,147.43397561558078,246.2136171144324,371.68317477450256),c(604.5920315668453,166.51366657759712,169.87664412262149,367.5987442824751),c(270.6419827170957,216.8146700229129,1333.2091057724724,1340.7143090080272),c(792.9335283114908,872.4622321722015,949.9114878628866,409.9747106372604),c(364.02138026276026,593.2049371826897,322.5505901062433,58.20313451139189),c(1324.721283825784,513.4171386142577,713.3743884516415,843.4348966036789))
targetgene="AHRR"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(713.7984456456734,985.2058605841163,938.6222172091681,1512.260389673182),c(1666.5848409421155,1920.1107177229167,1593.399915124842,2100.4183805251423),c(1571.6227417431344,1151.7195271617134,1104.7357711138834,1090.5429413713427),c(1285.1537424928754,1323.4367458198603,1382.1292786052527,1700.6547461179507),c(935.3766771099622,685.1343572724048,613.9212898355498,538.6342711361267),c(859.4069977507775,751.0460169593703,1260.097638681724,1566.88964750405),c(1258.2478143864973,886.338371053668,749.3925376801719,872.5364638593749),c(872.0686109773083,671.2582183909384,578.4407249238631,772.4679168047011),c(1342.131002012264,735.4353607177206,1109.0364456486332,1128.323923422597),c(889.4783291637881,778.7982947223031,833.2556911077952,1844.1203671504165))
targetgene="ADCK1"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(1137.9624887344548,2105.7040752625303,1189.674093175194,1096.1590332978806),c(449.4872695418431,218.5491873830962,101.60343588346664,98.53688562016346),c(433.6602530086796,157.8410797766806,606.3951093997374,639.2133720023039),c(865.7378043640429,728.4972912769874,554.7870149827385,1004.2593472272617),c(1050.9138978020558,650.4440100687387,398.3499787812105,153.6766972625347),c(652.0730811663358,721.5592218362542,1742.8483552074015,1000.1749167352342),c(704.3022357257753,1016.4271730674158,930.558452456512,1031.318699236944),c(1047.748494495423,1073.6662459534648,654.7776979156739,2091.738965729584),c(1440.2585045178776,705.9485655946045,639.1877527272055,884.2792015239539),c(1335.8001953989985,816.9576766463358,183.8538363605587,320.1172398126554))
targetgene="ACTR1A"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(0.0,0.0,13.439607921093472,150.61337439351408),c(705.8849373790916,605.3465587039728,478.98762630777134,595.8162980245116),c(267.476579410463,104.0710416109982,244.06327984705743,411.5063720717707),c(604.5920315668453,381.5938192403267,409.1016651180853,691.8004145871579),c(802.4297382313889,600.1430066234229,386.52312381064826,821.481082709031),c(1392.777454918387,1273.1357423745446,857.9845696826072,1263.620683471008),c(835.6664729510322,1250.5870166921616,959.0504212492301,1123.7289391190661),c(799.2643349247562,593.2049371826897,447.8077359308345,537.1026097016163),c(256.39766783724855,227.22177418401273,355.88081775055514,488.0894437972863),c(381.4310984492401,313.9476421931779,288.14519382824403,257.31912099773257))
targetgene="ADNP2"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(1585.8670566229816,1786.5528809888024,1076.2438023211653,1173.763212646403),c(224.74363477092155,64.17714232678222,248.90153869865108,312.4589326401038),c(1088.8987374816481,1139.5779056404303,556.3997679332697,767.8729325011701),c(599.8439266068963,669.5237010307551,745.6294474622658,909.8068920991258),c(390.9273083691382,806.550572485236,627.898482073487,311.94837882860037),c(1620.6864929959413,440.56740948655903,556.9373522501135,884.2792015239539),c(213.6647231977071,27.752277762932852,212.8833894701206,102.11076230068753),c(471.645092688272,72.84972912769874,217.1840640048705,206.2637398473888),c(865.7378043640429,461.3816178087587,1138.6035830750388,1073.6946655917293),c(489.0548108747518,478.7267914105917,763.9073142349529,611.6434661811182))
targetgene="ADK"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}




# parameters
# Do not modify the variables beginning with "__"
targetmat=list(c(400.4235182890363,856.8515759305518,2041.2076510556765,1396.3646744619018),c(1194.9397482538434,1111.8256278774975,826.8046793056703,891.426954885002),c(1574.788145049767,1181.2063222848296,1310.0929801481916,1355.520369541627),c(631.4979596732232,964.3916522619166,633.8119095587681,1170.6998897773824),c(1096.8122457482298,700.7450135140546,912.2805856838248,1021.1076230068752),c(1367.4542284653255,1184.675357005196,1355.7876470799094,1449.9728246697628),c(1422.8487863313976,1753.5970511453197,1260.097638681724,1103.817340470432),c(978.1096217495036,813.4886419259692,1397.1816394768773,1131.8978001031212),c(993.9366382826671,740.6389127982704,1260.6352229985675,1138.5349996526659),c(732.7908654854696,619.2226975854393,271.48008000608814,563.1408540882917))
targetgene="ADRBK1"
collabel=c("HL60.initial","KBM7.initial","HL60.final","KBM7.final")

# set up color using RColorBrewer
#library(RColorBrewer)
#colors <- brewer.pal(length(targetgenelist), "Set1")

colors=c( "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00",  "#A65628", "#F781BF",
          "#999999", "#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3", 
          "#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5",
          "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")


## code

targetmatvec=unlist(targetmat)+1
yrange=range(targetmatvec[targetmatvec>0]);
# yrange[1]=1; # set the minimum value to 1
for(i in 1:length(targetmat)){
  vali=targetmat[[i]]+1;
  if(i==1){
    plot(1:length(vali),vali,type='b',las=1,pch=20,main=paste('sgRNAs in',targetgene),ylab='Read counts',xlab='Samples',xlim=c(0.7,length(vali)+0.3),ylim = yrange,col=colors[(i %% length(colors))],xaxt='n',log='y')
    axis(1,at=1:length(vali),labels=(collabel),las=2)
    # lines(0:100,rep(1,101),col='black');
  }else{
    lines(1:length(vali),vali,type='b',pch=20,col=colors[(i %% length(colors))])
  }
}



dev.off()
Sweave("demo_summary.Rnw");
library(tools);

texi2dvi("demo_summary.tex",pdf=TRUE);

