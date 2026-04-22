
## Valores
# Valores numericos
2.3
2 + 3
3.5 * 4
6 / 3
2^3


# Valores logicos
TRUE
FALSE
2 > 3
2 <= 3
3 == 3
2 != 3


# Cadenas de caracteres
"hola"
"2.3"


# Asignacion de valores
a1 <- 2
a1

a2 <- "hola"
a2

a1 <- 4
a1

a1 * 2


## Vectores
# Asignacion
b1 <- c(1, 4, 2, 6)
b2 <- c(3.4, 4.3, 2.1, 6.6)
b3 <- c(TRUE, FALSE, TRUE, TRUE)
b4 <- c("Madrid", "Asturias", "Galicia", "Sevilla")
b5 <- c("hombre", "mujer", "mujer", "hombre")
b5
b5 <- factor(b5)
b5

# Operaciones
b1 - b2

# Acceso a valores
b1[1]

b4[3]
b4[3] <- "Valencia"
b4



## Conjuntos de datos
# Asignacion
c1 <- data.frame(b1, b2)
c1

c2 <- data.frame(brote = b3, sexo = b5, edad = b1, provincia = b4, pcr = b2)
c2

# Acceso a valores
c2[1, 2]
c2[2, ]
c2[, 3]
c2[, "edad"]
c2$edad

# Filtros
c2[c2$edad < 3, ]
c2[c2$sexo == "hombre", ]

# Edicion
c2[1, 2]
c2[1, 2] <- "mujer"
c2

c2$hipertension <- c(1, 0, 0, 1)
c2


## Funciones
# Nativas
mean(c2$edad)
sd(c2$edad)

# Propias (no lo vemos)

# Paquetes
install.packages("table1")
library(table1)

# Ayuda
?table1()

