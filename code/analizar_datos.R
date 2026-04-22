
### 1. Diseño
# Objetivo: predecir brote en pacientes con SpA
# Poblacion: pacientes adultos con SpA
# Resultado: brote en prox 12 meses
# Predictores: demo, comorb, lab



### 2. Configuración
## Rutas
ruta_datos <- "https://raw.githubusercontent.com/vfanjul/rworkshop/refs/heads/main/data/datos_reuma_practica.csv"


## Funciones
# install.packages("table1")
library(table1)
library(randomForest)


### 3. Preparar datos
## 3.1. Cargar datos
datos <- read.csv(ruta_datos, stringsAsFactors = TRUE)
summary(datos)


## 3.2. Limpieza de datos
# Comprobar que no pacientes duplicados

# Corregir clase de variable
str(datos)
datos$brote <- factor(datos$brote)
summary(datos)

# Corregir erratas (cambios codificacion, errores por espacios, tildes, comas...)
table(datos$sexo)
datos$sexo[datos$sexo == "macho"] <- "hombre"
table(datos$sexo)

datos$sexo <- factor(datos$sexo)
summary(datos)

# Reenfocar variables (ingenieria)
datos$fumador <- datos$tabaquismo != "no fumador"
summary(datos)

# Gestionar datos ausentes
# Imputar diabetes y excluir VSG para modelos


## 3.3. Definir poblacion
# Todos tienen SpA, pero falta filtrar adultos
datos[datos$edad < 18, ]
datos <- datos[datos$edad >= 18, ]
summary(datos)


## 3.4. Explorar variables
# Variables categoricas
table(datos$brote)
prop.table(table(datos$brote))
barplot(prop.table(table(datos$brote)))
barplot(prop.table(table(datos$sexo)))
barplot(prop.table(table(datos$fumador)))
barplot(prop.table(table(datos$diabetes)))

# Variables numericas
hist(datos$edad)
hist(datos$pcr)
hist(datos$vsg)



### 4. Analisis estadistico clasico
## 4.1. Descriptivo
summary(datos)
summary(datos[datos$brote == 0,])
summary(datos[datos$brote == 1,])

# Tablas
table1( ~ sexo + edad + fumador + diabetes + pcr + vsg | brote, datos)

# Graficas categorica vs categorica
table(datos$fumador, datos$brote)
prop.table(table(datos$fumador, datos$brote), margin = 2)
barplot(prop.table(table(datos$fumador, datos$brote), margin = 2))

# Graficas numerica vs categorica
boxplot(edad ~ brote, datos)
boxplot(pcr ~ brote, datos)

# Graficas numerica vs numerica
plot(pcr ~ edad, datos)


## 4.2. Inferencial (contraste de hipotesis)
# Categoricas
chisq.test(datos$sexo, datos$brote)
chisq.test(datos$fumador, datos$brote)
chisq.test(datos$diabetes, datos$brote)

# Numericas
t.test(edad ~ brote, datos)
wilcox.test(pcr ~ brote, datos)
cor.test(datos$pcr, datos$edad)



### 5. Ajuste de modelos
## 5.1. Modelos univariables
# Dependiente numerica
mlin <- lm(pcr ~ edad, datos)
abline(mlin)
summary(mlin)

# Dependiente categorica
mlog <- glm(brote ~ edad, datos, family = "binomial")
summary(mlog)


## 5.2. Modelos multivariables
# lr <- glm(brote ~ edad + sexo + fumador + diabetes + pcr, datos, family = "binomial")
# Preparacion de datos
datos$diabetes[is.na(datos$diabetes)] <- FALSE
summary(datos)

train <- datos[datos$test == FALSE, ]
test <- datos[datos$test == TRUE, ]

# Ajuste y explicabilidad
lr <- glm(brote ~ edad + sexo + fumador + diabetes + pcr, train, family = "binomial")
summary(lr)

# Prediccion
lr_prob <- predict(lr, newdata = test, type = "response")
head(lr_prob)
lr_pred <- as.numeric(lr_prob >= 0.5)
head(lr_pred)

# Evaluacion (matriz confusion)
lr_comp <- data.frame(real = test$brote, prob = lr_prob, pred = lr_pred)

lr_mc <- table(real = test$brote, pred = lr_prob >= 0.5)
lr_mc
(lr_mc[1, 1] + lr_mc[2, 2])/sum(lr_mc) # Exactitud



### 6. Exportar resultados
# Datos
write.csv(datos, "datos_reuma_limpios.csv", row.names = FALSE)

# Graficas -> Exportar desde pestaña "Plots"
# Tablas html -> Exportar desde pestaña "Viewer"
# Resultados -> copiar de "Console"
