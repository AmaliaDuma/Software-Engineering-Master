# ----- Ex. 1 -----
#  Simulați experimentul aruncării repetate a unei monede. Calculați numărul
#  necesar de aruncări pentru a obține două fețe de același fel consecutive.
aruncare_moneda <- function() {
  m1 <- sample(0:1, 1)
  aruncari <- 1
  
  while (TRUE) {
    m2 <- sample(0:1, 1)
    aruncari <- aruncari + 1
    
    if (m1 == m2) {
      cat("Dupa ", aruncari, "aruncari s-a obtinut aceeasi fata consecutiv.", "\n")
      break
    }
    
    m1 <- m2
  }
}
aruncare_moneda()


# ----- Ex. 2 -----
#  Să se arunce două zaruri până când se obțin două numere egale (o dublă).
#  Să se afișeze de câte ori a fost nevoie să se arunce zarul.
aruncare_zar <- function() {
  aruncari <- 0
  
  while (TRUE) {
    z1 <- sample(1:6, 1)
    z2 <- sample(1:6, 1)
    aruncari <- aruncari + 1
    
    if (z1 == z2) {
      cat("Dupa ", aruncari, "aruncari s-a obtinut o dubla.", "\n")
      break
    }
  }
}
aruncare_zar()


# ----- Ex. 3 -----
#  Să se scrie o funcție care verifică dacă un număr specificat ca argument
#  este prim sau nu.
prim <- function(n) {
  if (n==0 || n==1) return(FALSE)

  divisor <- 2
  
  while (divisor <= sqrt(n)) {
    if (n %% divisor == 0) return(FALSE)
    divisor <- divisor + 1
  }
  
  return(TRUE)
}
prim(3)


# ----- Ex. 4 -----
#  Să se afișeze toate numerele Fibonacci mai mici de 1000.
fibonacci <- function() {
  vect <- c(0,1)
  i <- 3
  while (vect[i-2] + vect[i-1] < 1000) {
    vect <- append(vect, vect[i-2] + vect[i-1])
    i <- i+1
  }
  print(vect)
}
fibonacci()

# ----- Ex. 5 -----
#  Analizând datele din setul de date de la ultimul exercițiu de la laboratorul
#  precedent să se construiască un grafic alegând variabilele și specificând
#  numele variabilei pe fiecare axe, titlul graficului, etc.
library(MASS)
data(Cars93)
d <- Cars93[c("Manufacturer", "Make", "Price", "Passengers", "Origin")]

par(las=2)
p1 <- plot(d$Manufacturer, d$Price, xlab="Manufacturer", ylab="Price", col="turquoise", main = "T1")
p2 <- plot(d$Make, d$Passengers, xlab="Make", ylab="Passengers", col="turquoise", main = "T2")
p3 <- plot(d$Origin, d$Price, xlab="Origin", ylab="Price", col="turquoise", main = "T3")
p4 <- plot(d$Manufacturer, d$Origin, xlab="Manufacturer", ylab="Origin", col="turquoise", main = "T4")
