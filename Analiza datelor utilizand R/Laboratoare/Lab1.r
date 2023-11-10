# Ex. 1
rez1 <- 2^6 + 6 * 1/10
rez2 <- sin(pi*2) + tan(pi/2) + log(7)
rez3 <- abs(7 - exp(-4))


# Ex. 2
# - 48:14*3 va crea un vector cu numere de la 48 la 14; apoi aceste numere
# vor fi inmultite cu 3  
# - 48:(14*3) va efectua prima data inmultirea; apoi se va crea un vector cu
# numere de la 48 la 42 (14*3)

48 : 14*3
48 : (14*3)

#  Ridicarea la putere are o prioritate mai mare => intre cele 2 variante nu 
# exista nicio diferenta si vor genera numere intre 48 si 196
48 : 14^2
48 : (14^2)


# Ex. 3
numere <- 48:14
patrate <- numere^2


# Ex. 4
v1 <- rep(0:4, each = 5)
v1

v2 <- rep(1:5, times = 5)
v2

v3 <- c(1:5, 2:6, 3:7, 4:8, 5:9)
v3

v4 <- rep((rep(0:1, c(3,4))), times=5)
v4

v5 <- 1 / (1:10)
v5

v6 <- (1:6)^3
v6


# Ex. 5
s1 <- sum(1:100)
s2 <- sum((1:100)^2)
