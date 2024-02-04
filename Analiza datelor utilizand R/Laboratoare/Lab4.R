# 1. Generați în R 5000 de numere aleatoare care urmează o repartiție uniforma,
# binomială și geometrică. Calculați pentru aceste variabile media și dispersia.

set.seed(123)

# Repartitie uniforma
nr_uniforme <- runif(5000, min = 0, max = 100)
media_uniforma <- mean(nr_uniforme)
dispersia_uniforma <- var(nr_uniforme)

# Repartitie binomiala
n <- 25 # Setam numarul de incercari
p <- 0.35 # Setam probabilitatea de success
nr_binomiale <- rbinom(5000, n, p) 
media_binomiala <- mean(nr_binomiale)
dispersia_binomiala <- var(nr_binomiale)

# Repartitie geometrica
pg <- 0.2 # Setam probabilitatea de success
nr_geometrice <- rgeom(5000, pg) 
media_geometrica <- mean(nr_geometrice)
dispersia_geometrica <- var(nr_geometrice)

# Afisarea rezultatelor
cat("Distributia uniforma:\n", "Media:", media_uniforma, "\n", "Dispersia:", dispersia_uniforma, "\n\n")
cat("Distributia binomiala:\n", "Media:", media_binomiala, "\n", "Dispersia:", dispersia_binomiala, "\n\n")
cat("Distributia geometrica:\n", "Media:", media_geometrica, "\n", "Dispersia:", dispersia_geometrica, "\n")


# 2. Pentru o variabilă X care urmează o repariție normală de parametrii: 
# media este 3 și dispersia este 9, calculați următoarele probabilități:
#   • distributie normala -> deviatia standard = sqrt(dispersie) = 3

# a) P(X<4)
p_a <- pnorm(4, mean = 3, sd = 3)
cat("P(X<4) =", p_a, "\n")

# b) P(X>=5)
p_b <- 1 - pnorm(5, mean = 3, sd = 3)
cat("P(X>=5) =", p_b, "\n")

# c) P(X-2>3) = P(X>5) = 1 - P(X<=5)
p_c <- 1 - pnorm(5, mean = 3, sd = 3)
cat("P(X-2>3) = P(X>5) = ", p_c, "\n")

# d) F(7) - stim ca F(X)=P(Y<X) => F(7)=P(X<7)
p_d <- pnorm(7, mean = 3, sd = 3)
cat("F(7) =", p_d, "\n")


# 3. Pentru o variabilă X care urmează o repariție binomială de parametrii
# 20 și 1/4 calculați următoarele probabilități:
#   • n=20, p=1/4
  
# a) P(X<=4) 
pb_a <- pbinom(4, size = 20, prob = 1/4)
cat("P(X<=4) =", pb_a, "\n")

# b) P(X>5) = 1 - P(X<=5)
pb_b <- 1 - pbinom(5, size = 20, prob = 1/4)
cat("P(X>5) =", pb_b, "\n")

# c) P(X<2) = P(X<=1)
pb_c <- pbinom(1, size = 20, prob = 1/4)
cat("P(X<2) = P(X<=1)=", pb_c, "\n")

# d) F(5) = P(X<5) = P(X<=4)
pb_d <- pbinom(4, size = 20, prob = 1/4)
cat("F(5) =", pb_d, "\n")


# 4. Afișați setul de date din mtcars
library(summarytools)
library(ggplot2)
data(mtcars)

# a) Alegeți două variabile și afișați media, abaterea standard și dispersia 
# pentru aceste variabile.
v1 <- mtcars$mpg
v2 <- mtcars$hp

r1 <- data.frame(Media = mean(v1), 
                 Abatere_Standard = sd(v1),
                 Dispersie = var(v1))
r2 <- data.frame(Media = mean(v2),
                 Abatere_Standard = sd(v2),
                 Dispersie = var(v2))
print(r1)
print(r2)

# b) Calculați pentru aceleași variabile cele 4 quartile, mediana, modul și
# afișați cutia cu mustăți. Identificați în grafic valorile numerice calculate.
q1 <- quantile(v1)
q2 <- quantile(v2)
m1 <- median(v1)
m2 <- median(v2)
mod1 <- mode(v1)
mod2 <- mode(v2)

data_boxplot <- data.frame(
  Variabila = rep(c("mpg", "disp"), each = length(v1)),
  Valoare = c(v1, v2)
)

#box-plot - cutia cu mustati
par(mfrow=c(1,2))
boxplot(v1,
        xlab = "Cars",
        ylab = "MPG",
        col = "orange",
        border = "brown",
        horizontal = TRUE)
boxplot(v2,
        xlab = "Cars",
        ylab = "HP",
        col = "orange",
        border = "brown",
        horizontal = TRUE)


# 5. Generați 1000 de numere întregi în intervalul [0,100] și calculați
# quantilele de ordinele 0.32, 0.56, 0.76. Alegeți centila (percentila) egală
# cu mediana și afișați-o.
nr <- sample(0:100, 1000, replace = TRUE)

q_032 <- quantile(nr, probs = 0.32)
q_056 <- quantile(nr, probs = 0.56)
q_076 <- quantile(nr, probs = 0.76)

centila_mediana <- quantile(nr, probs = 0.5)


# 6. Înlocuiți valorile NA cu 0
data <- data.frame(x1 = c(4, 7, 2, 5, 5),
                   x2 = c(NA, NA, 6, NA, 5),
                   x3 = c(3, NA, 5, 1, 9))
data
data(is.na(data)) <- 0