library(readr)
library(dplyr)
library(tidyr)
library(purrr)

datos_train<-read_delim("C:/Users/JoséFrancisco/Documents/Luz/ITAM/MAD/Tareas/tic/aux_ticdataL4.txt",
                       delim="|",col_names=TRUE)

resumen_train<-datos_train%>%
  select(MAANTHUI:ABYSTAND)
resumen_trainT<-t(resumen_train)
resumen_trainT<-as.data.frame(resumen_trainT)
MIN=apply(resumen_trainT[,2:5822],1,FUN=min)
MAX=apply(resumen_trainT[,2:5822],1,FUN=max)
MEDIA=apply(resumen_trainT[,2:5822],1,FUN=mean)               
SD=apply(resumen_trainT[,2:5822],1,FUN=sd)
tabla_train<-bind_cols(resumen_trainT[,0],MIN,MAX,MEDIA,SD)
colnames(tabla_train)=c("Mínimo","Máximo","Media","Desv.Est")

res_train_cat<-datos_train%>%
  select(MOSTYPECAT:PWAPARTCAT)

f_MOSTYPECAT<-res_train_cat%>%
  group_by(MOSTYPECAT)%>%
  summarise(frecuencia=n())

f_MGEMLEFCAT<-res_train_cat%>%
  group_by(MGEMLEEFCAT)%>%
  summarise(frecuencia=n())

f_MOSHOOFDCAT<-res_train_cat%>%
  group_by(MOSHOOFDCAT)%>%
  summarise(frecuencia=n())

f_MGODRKCAT<-res_train_cat%>%
  group_by(MGODRKCAT)%>%
  summarise(frecuencia=n())

f_PWAPARTCAT<-res_train_cat%>%
  group_by(PWAPARTCAT)%>%
  summarise(frecuencia=n())

datos_eval<-read_delim("C:/Users/JoséFrancisco/Documents/Luz/ITAM/MAD/Tareas/tic/aux_ticevalL4.txt",
                       delim="|",col_names=TRUE)

resumen_eval<-datos_eval%>%
  select(MAANTHUI:ABYSTAND)
resumen_evalT<-t(resumen_eval)
resumen_evalT<-as.data.frame(resumen_evalT)
MIN=apply(resumen_evalT[,2:4000],1,FUN=min)
MAX=apply(resumen_evalT[,2:4000],1,FUN=max)
MEDIA=apply(resumen_evalT[,2:4000],1,FUN=mean)               
SD=apply(resumen_evalT[,2:4000],1,FUN=sd)
tabla_eval<-bind_cols(resumen_evalT[,0],MIN,MAX,MEDIA,SD)
colnames(tabla_eval)=c("Mínimo","Máximo","Media","Desv.Est")

res_eval_cat<-datos_eval%>%
  select(MOSTYPECAT:PWAPARTCAT)

f_MOSTYPECAT_E<-res_eval_cat%>%
  group_by(MOSTYPECAT)%>%
  summarise(frecuencia=n())

f_MGEMLEFCAT_E<-res_eval_cat%>%
  group_by(MGEMLEEFCAT)%>%
  summarise(frecuencia=n())

f_MOSHOOFDCAT_E<-res_eval_cat%>%
  group_by(MOSHOOFDCAT)%>%
  summarise(frecuencia=n())

f_MGODRKCAT_E<-res_eval_cat%>%
  group_by(MGODRKCAT)%>%
  summarise(frecuencia=n())

f_PWAPARTCAT_E<-res_eval_cat%>%
  group_by(PWAPARTCAT)%>%
  summarise(frecuencia=n())

