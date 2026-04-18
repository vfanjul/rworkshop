
crear_datos <- function(n, seed = 50) {
  set.seed(50)
  b <- sample(c(1, 0), n, TRUE, c(0.4, 0.6))
  e <- pmax(0, pmin(round(ifelse(b == 1, rnorm(n, 62, 14), rnorm(n, 55, 14))), 100))
  t <- c("fumador", "no fumador", "fumador > 2 cajetillas", "ex fumador")
  dt <- data.frame(
    id_paciente = factor(replicate(n, paste0(sample(LETTERS, 5, TRUE), collapse = ""))),
    brote = factor(b),
    sexo = factor(sample(c("hombre", "mujer", "macho"), n, TRUE, c(0.5, 0.45, 0.05))),
    edad = e, 
    tabaquismo = factor(ifelse(b == 1, sample(t, n, TRUE, c(0.325, 0.525, 0.05, 0.1)), 
                               sample(t, n, TRUE, c(0.2, 0.65, 0.05, 0.1)))),
    diabetes = as.logical(sample(c(1, 0, NA), n, TRUE, c(0.2, 0.6, 0.2))),
    pcr = pmin(200, round(ifelse(b == 1, rgamma(n, 2, 0.12), rgamma(n, 1.2, 0.5)) + (e * 0.05), 2)),
    vsg = ifelse(runif(n) < 0.9, NA, pmin(round(rgamma(n, 2, 0.08)), 120)),
    test = as.logical(sample(c(1, 0), n, TRUE, c(0.3, 0.7)))
  )
  dt
}