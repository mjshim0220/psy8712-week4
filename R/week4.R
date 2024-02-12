#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

#Data Import
import_tbl<-read_delim("../data/week4.dat",delim="-",col_names=c("casenum","parnum","stimver","datadate","qs"))
glimpse(import_tbl)
wide_tbl<-separate(import_tbl, qs, into=paste0("q",1:5), sep=" - ")
wide_tbl[5:9]<-sapply(wide_tbl[5:9], as.numeric)
wide_tbl$datadate<-as.POSIXct(wide_tbl$datadate, format="%b %d %Y, %H:%M:%S")
wide_tbl[5:9]<-replace(wide_tbl[5:9], wide_tbl[5:9]==0, NA)
wide_tbl<-wide_tbl[!is.na(wide_tbl$q2),]
long_tbl<- pivot_longer(wide_tbl, c(q1,q2,q3,q4,q5))