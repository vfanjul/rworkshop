
source("code/functions.R")

datos <- crear_datos(1000)
summary(datos)

write.csv(datos, "data/datos_reuma_practica.csv", row.names = FALSE)
rm(datos)
