#!/bin/bash

#set -x

usage()
{
cat <<EOF
${txtcyn}

***CREATED BY Chen Tong (chentong_biology@163.com)***

Usage:

$0 options${txtrst}

${bldblu}Function${txtrst}:

This script is used to draw a line specifially for output of
count_features_given_MIN_FPKM_threshold.pl.

${txtbld}OPTIONS${txtrst}:
	-f	Data file (with header line, the first column is the
 		will not be treated as rownames, tab seperated)${bldred}[NECESSARY]${txtrst}

	-m	When true, it will skip melt preprocesses. But the format must be
		the same as listed before.
		${bldred}[Default FALSE, accept TRUE]${txtrst}
	-a	Name for x-axis variable
		[${txtred}Necessary, no default value when -m is used.  
		For the second examples, 'Pos' should be given here. 
		For the first example,  default the first column will be used,
		program will assign an value 'xvariable' to represent it.
	   	]${txtrst}]
	-A	The attribute of x-axis variable.
		[${txtred}Default TRUE, means X-axis label is text.
		FALSE means X-axis label is number.${txtrst}]
	-l	Levels for legend variable
		[${txtred}Default column order, accept a string like
		"'ctcf','h3k27ac','enhancer'"  
		***When -m is used, this default will be ignored too.********* 
	   	${txtrst}]
	-P	Legend position[${txtred}Default right. Accept
		top,bottom,left,none, or c(0.08,0.8).${txtrst}]
	-L	Levels for x-axis variable, suitable when x-axis is not used
		as a number. 
		[${txtred}Default the order of first column, accept a string like
		"'g','a','j','x','s','c','o','u'"  
	   	This will only be considered when -A is TRUE.
		***When -m is used, this default will be ignored too.********* 
		${txtrst}]
	-o	Smooth your data or not.
		[${txtred}Default FALSE means no smooth. Accept TRUE to smooth
		lines.${txtrst}]
	-O	The smooth method you want to use.
		[${txtred}smoothing method (function) to use,  eg. lm, glm,
		gam, loess,rlm. 
		For datasets with n < 1000 default is 'loess'. 
		For datasets with 1000 or more observations defaults to 'gam'.
		${txtrst}]
	-V	Add vertical lines.${bldred}[Default FALSE, accept a series of
		numbers in following format "c(1,2,3,4,5)" or other
		R code that can generate a vector]${txtrst}
	-I	Manually set the position of xtics.
		${bldred}[Default FALSE,  accept a series of
		numbers in following format "c(1,2,3,4,5)" or other R code
		that can generate a vector to set the position of xtics]${txtrst}
	-b	Manually set the value of xtics when -I is specified.
		${bldred}[Default the content of -I when -I is specified, 
		accept a series of
		numbers in following format "c(1,2,3,4,5)" or other R code
		that can generate a vector to set the position of xtics]${txtrst}
	-X	Display xtics. ${bldred}[Default TRUE]${txtrst}
	-Y	Display ytics. ${bldred}[Default TRUE]${txtrst}
	-R	Rotation angle for x-axis value(anti clockwise)
		${bldred}[Default 0]${txtrst}
	-B	line size.[${txtred}Default 1. Accept a number.${txtrst}]
	-t	Title of picture[${txtred}Default empty title${txtrst}]
	-x	xlab of picture[${txtred}Default empty xlab${txtrst}]
	-y	ylab of picture[${txtred}Default empty ylab${txtrst}]
	-c	Manually set colors for each line.[${txtred}Default FALSE,
		meaning using ggplot2 default.${txtrst}]
	-C	Color for each line.[${txtred}
		When -c is TRUE, one have two options
		1. Supplying a function to generate colors, 
		like "rainbow(11)" or "rainbow(11, alpha=0.6)", 
		    rainbow is an R color palletes, 
		    11 is the number of colors you want to get, 
			0.6 is the alpha value.
		The R palletes include heat.colors, terrain.colors,
		topo.colors, cm.colors.
		2. Supplying a list of colors in given format, 
		ususlly the number of colors should be equal to the number of
		bars like "'red','pink','blue','cyan','green','yellow'" or
		"rgb(255/255,0/255,0/255),rgb(255/255,0/255,255/255),
		 rgb(0/255,0/255,255/255),rgb(0/255,255/255,255/255),
		 rgb(0/255,255/255,0/255),rgb(255/255,255/255,0/255)"
		${txtrst}]
	-s	Scale y axis
		[${txtred}Default null. Accept TRUE. This function is
		depleted. If the supplied number after -S is not 0, this
		parameter is TRUE${txtrst}]
	-F	The formula for facets.[${bldred}Default no facets, 
		+facet_grid(level ~ .) means divide by levels of 'level' vertcally.
		+facet_grid(. ~ level) means divide by levels of 'level' horizontally.
		+facet_grid(lev1 ~ lev2) means divide by lev1 vertically and lev2
		horizontally.
		+facet_wrap(~level, ncol=2) means wrap horizontally with 2
		columns.
		Example: +facet_wrap(~Size,ncol=6,scale='free')
		${txtrst}]
	-G	If facet is given, you may want to specifize the order of
		variable in your facet, default alphabetically.
		[${txtred}Accept sth like 
		(one level one sentence, separate by';') 
		data\$size <- factor(data\$size, levels=c("l1",
		"l2",...,"l10"), ordered=T) ${txtrst}]
	-v	If scale is TRUE, give the following
		scale_y_log10()[default], coord_trans(y="log10"), or other legal
		command for ggplot2)${txtrst}]
	-S	A number to add if scale is used.
		[${txtred}Default 0. If a non-zero number is given, -s is
		TRUE.${txtrst}]	
	-p	Other legal R codes for gggplot2 will be given here.
		[${txtres}Begin with '+' ${txtrst}]
	-w	The width of output picture.[${txtred}Default 20${txtrst}]
	-u	The height of output picture.[${txtred}Default 12${txtrst}] 
	-E	The type of output figures.[${txtred}Default pdf, accept
		eps/ps, tex (pictex), png, jpeg, tiff, bmp, svg and wmf)${txtrst}]
	-r	The resolution of output picture.[${txtred}Default 300 ppi${txtrst}]
	-z	Is there a header[${bldred}Default TRUE${txtrst}]
	-e	Execute or not[${bldred}Default TRUE${txtrst}]
	-i	Install depended packages[${bldred}Default FALSE${txtrst}]
EOF
}

file=
title=''
melted='FALSE'
xlab='NULL'
ylab='NULL'
xvariable='xvariable'
level=""
x_level=""
x_type='TRUE'
scaleY='FALSE'
y_add=0
scaleY_x='scale_y_log10()'
header='TRUE'
execute='TRUE'
ist='FALSE'
uwid=20
vhig=12
res=300
ext='pdf'
par=''
legend_pos='right'
smooth='FALSE'
smooth_method='auto'
line_size=1
xtics='TRUE'
xtics_angle=0
ytics='TRUE'
color='FALSE'
color_v=''
vline=0
facet=''
facet_o=''
xtics_pos=0
xtics_value=0


while getopts "hf:m:a:A:b:I:t:x:l:F:G:P:L:y:V:c:C:B:X:Y:R:w:u:r:o:O:s:S:p:z:v:e:E:i:" OPTION
do
	case $OPTION in
		h)
			usage
			exit 1
			;;
		f)
			file=$OPTARG
			;;
		m)
			melted=$OPTARG
			;;
		a)
			xvariable=$OPTARG
			;;
		A)
			x_type=$OPTARG
			;;
		V)
			vline=$OPTARG
			;;
		I)
			xtics_pos=$OPTARG
			;;
		b)
			xtics_value=$OPTARG
			;;
		t)
			title=$OPTARG
			;;
		x)
			xlab=$OPTARG
			;;
		l)
			level=$OPTARG
			;;
		F)
			facet=$OPTARG
			;;
		G)
			facet_o=$OPTARG
			;;
		P)
			legend_pos=$OPTARG
			;;
		B)
			line_size=$OPTARG
			;;
		c)
			color=$OPTARG
			;;
		C)
			color_v=$OPTARG
			;;
		X)
			xtics=$OPTARG
			;;
		R)
			xtics_angle=$OPTARG
			;;
		Y)
			ytics=$OPTARG
			;;
		L)
			x_level=$OPTARG
			;;
		p)
			par=$OPTARG
			;;
		y)
			ylab=$OPTARG
			;;
		w)
			uwid=$OPTARG
			;;
		u)
			vhig=$OPTARG
			;;
		r)
			res=$OPTARG
			;;
		E)
			ext=$OPTARG
			;;
		o)
			smooth=$OPTARG
			;;
		O)
			smooth_method=$OPTARG
			;;
		s)
			scaleY=$OPTARG
			;;
		S)
			y_add=$OPTARG
			;;
		v)
			scaleY_x=$OPTARG
			;;
		z)
			header=$OPTARG
			;;
		e)
			execute=$OPTARG
			;;
		i)
			ist=$OPTARG
			;;
		?)
			usage
			exit 1
			;;
	esac
done

if [ -z $file ]; then
	usage
	exit 1
fi

if test ${y_add} -ne 0; then
	scaleY="TRUE"
fi

mid='.lines_lm'

if test "${smooth}" == 'TRUE'; then
	mid=${mid}'.smooth'
fi

cat <<END >${file}${mid}.r

if ($ist){
	install.packages("ggplot2", repo="http://cran.us.r-project.org")
	install.packages("reshape2", repo="http://cran.us.r-project.org")
	install.packages("grid", repo="http://cran.us.r-project.org")
}

data <- read.table(file="${file}", sep="\t", header=$header,
 check.names=F, quote="")

pdf(file="${file}${mid}.pdf", onefile=FALSE, 
paper="special", width=8, height=6, bg="white", pointsize=12)

plot(data, xlim=c(-100, 0), ylim=c(0, 100000), type='b',
xlab="Expression values",
ylab="Number of features", xaxt="n")

axis(1, at=seq(-100, 0, by=10), 
	labels=paste('>',seq(100,0,by=-10)))

filt_data <- data[data[,1] > -100 & data[,1] < -10, ]

fit <- lm(filt_data[,2] ~ filt_data[,1])

abline(fit, col='green', lwd=3)

dev.off()

#if(! $melted){
#
#	data_rownames <- rownames(data)
#	data_colnames <- colnames(data)
#	data\$${xvariable} <- data_rownames
#	data_m <- melt(data, id.vars=c("${xvariable}"))
#} else {
#	data_m <- read.table(file="$file", sep="\t",
#	header=$header, check.names=F)
#}
#
#if (${y_add} != 0){
#	data_m\$value <- data_m\$value + ${y_add}
#}
#
#if ("${level}" != ""){
#	level_i <- c(${level})
#	data_m\$variable <- factor(data_m\$variable, levels=level_i)
#} else if(! $melted){
#	data_m\$variable <- factor(data_m\$variable, levels=data_colnames,
#	ordered=T)
#}
#
##if (${x_type}){
##	if ("${x_level}" != ""){
##		x_level <- c(${x_level})
##		data_m\$${xvariable} <- factor(data_m\$${xvariable},levels=x_level)
##	} else if(! $melted){
##		data_m\$${xvariable} <- factor(data_m\$${xvariable},levels=data_rownames,ordered=TRUE)
##	}
##} 
#
#if ("${x_level}" != ""){
#	x_level <- c(${x_level})
#	data_m\$${xvariable} <- factor(data_m\$${xvariable},levels=x_level)
#} else if(! $melted){
#	data_m\$${xvariable} <- factor(data_m\$${xvariable},levels=data_rownames,ordered=TRUE)
#}
#
#if (! ${x_type}){
#	data_m\$${xvariable} <- 
#		as.numeric(levels(data_m\$${xvariable}))[data_m\$${xvariable}]
#}
#
##if(! ${color}){
##	data_m\$variable <- 
##		as.numeric(levels(data_m\$variable))[data_m\$variable]
##}
#
#
#${facet_o}
#
#p <- ggplot(data_m, aes(x=$xvariable, y=value, color=variable,
#	group=variable)) + 
#	xlab("$xlab") + ylab("$ylab") + theme_bw() +
#	theme(legend.title=element_blank(),
#   	panel.grid.major = element_blank(), panel.grid.minor = element_blank())
#
#p <- p ${facet}
#
#p <- p + expand_limits(y = 0)
##p <- p + scale_y_continuous(expand=c(0, 0))
#
#p <- p + theme(legend.key=element_blank()) 
#
##legend.background = element_rect(colour='white'))
#
##legend.background = element_rect(fill = "white"), legend.box=NULL, 
##legend.margin=unit(0,"cm"))
#
#if (${smooth}){
#	if ("${line_size}" != ""){
#		p <- p + stat_smooth(method="${smooth_method}", se=FALSE,
#		size=${line_size})
#	}else{
#		p <- p + stat_smooth(method="${smooth_method}", se=FALSE,
#		size=${line_size})
#	}	
#}else{
#	if ("${line_size}" != ""){
#		p <- p + geom_line(size=${line_size}) 
#	}else{
#	p <- p + geom_line() 
#	}
#}
#
#if("$scaleY"){
#	p <- p + $scaleY_x
#}
#
#if(${color}){
#	p <- p + scale_color_manual(values=c(${color_v}))
#} 
##else {
#	#p <- p + scale_colour_brewer()
#	#p <- p + scale_colour_discrete(limits=levels(data_m\$variable),
#	#breaks=unique(data_m\$variable))
##}
#
#if ("$xtics" == "FALSE"){
#	p <- p + theme(axis.text.x=element_blank(), axis.ticks.x = element_blank())
#}else{
#	if (${xtics_angle} != 0){
#	p <- p + theme(axis.text.x=element_text(angle=${xtics_angle},hjust=1))
#	}
#}
#if ("$ytics" == "FALSE"){
#	p <- p + theme(axis.text.y=element_blank())
#}
#
#
#top='top'
#botttom='bottom'
#left='left'
#right='right'
#none='none'
#legend_pos_par <- ${legend_pos}
#
#p <- p + theme(legend.position=legend_pos_par)
#
#xtics_pos <- ${xtics_pos}
#xtics_value <- ${xtics_value}
#
#if(length(xtics_pos) > 1){
#	if(length(xtics_value) <= 1){
#		xtics_value <- xtics_pos
#	}
#	p <- p + scale_x_continuous(breaks=xtics_pos, labels=xtics_value)
#}
#
#custom_vline_coord <- ${vline}
#if(length(custom_vline_coord) > 1){
#	p <- p + geom_vline(xintercept=custom_vline_coord, 
#	linetype="dotted" )
#}
#
#p <- p${par}
#
##png(filename="${file}${mid}.png", width=$uwid, height=$vhig,
##res=$res)
#
#ggsave(p, filename="${file}${mid}.${ext}", dpi=$res, width=$uwid,
#height=$vhig, units=c("cm"))
END

if [ "$execute" == "TRUE" ]; then
	Rscript ${file}${mid}.r
	convert -density 150 ${file}${mid}.pdf ${file}${mid}.png
if [ "$?" == "0" ]; then /bin/rm -f ${file}${mid}.r; fi
fi

