library('psych')

# ------- Ex. 1 -------
# a) Să se denumească fiecare dintre cele două categorii: nume și nota.
studenti <- list(
  nume = c("Iacob Alin", "Iacob Maria", "Pop Radu", "Radu Laura", "Ionescu Irina", "Suciu Maria"),
  nota = c(8, 7, 10, 6, 10, 5)
)

# b) Să se afișeze pentru fiecare element: Studentul..... a obținut nota ... la 
# ultimul test.
paste("Studentul", studenti$nume, "a obținut nota", studenti$nota, "la ultimul test")

# c) Să se afișeze doar numele și prenumele studenților.
paste(studenti$nume)


# ------ Ex. 2 ------
x <- c(1, 4, 2, 6, 8, 9, 11, 10, -21, -1, 1, -21, 3, -8, -6, -21)

# a) Să se afișeze doar elementele de pe pozițiile multiplu de 3.
x[(1:length(x)%%3==0)]

# b) Să se calculeze media geometrică a elementelor pozitive din vector.
x_poz <- x[x>0]
geometric.mean(x_poz)

# c) Să se afișeze pozițiile pe care se găsesc valorile minime din vector.
which(x==min(x))


# ------ Ex. 3 ------
# a) Să se creeze o matrice A care are 3 linii și 4 coloane, iar toate 
# elementele sunt egale cu 3.
A <- matrix(3, nrow = 3, ncol = 4)
print(A)

# b) Să se creeze o matrice B care va avea 2 linii și 3 coloane, iar toate 
# elementele să fie diferite.
B <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3)
print(B)

# c) Încercați să calculați produsele A*B și B*A.
#   A*B nu se poate calcula deoarece matricile nu sunt compatibile (nr. de 
# coloane din prima matrice trebuie sa fie egal cu nr. de linii din a doua matrice)
rezultat <- B %*% A

# d) Adăugați linii și/sau coloane astfel încât cele două matrice să pot fi adunate.
B <- cbind(B, rep(0, nrow(B)))
B <- rbind(B, rep(0, ncol(B)))
print(B)

rezultat2 <- A+B
print(rezultat2)


# ------ Ex. 4 ------
library(MASS)
data(Cars93)
View(Cars93)

# a) Să se construiască un dataframe care conține doar variabilele Manufacturer,
# Make, Price, Passengers și Origin.
d <- Cars93[c("Manufacturer", "Make", "Price", "Passengers", "Origin")]
View(d)

# b) Să se afișeze doar datele pentru mașinile de proveniență americană. Să se 
# determine câte astfel de mașini sunt în setul de date.
cars_usa <- subset(d, Origin == "USA")
cat("Nr. mașini de proveniență americană:", nrow(cars_usa), "\n")

# c) Să se afișeze modelele de mașini ale căror producător este Ford.
ford_cars <- subset(Cars93, Manufacturer == "Ford")
modele <- ford_cars["Model"]
print(modele)

# d) Să se selecteze și afișeze datele pentru mașinile care pot transporta cel
# puțin 5 pasageri, sortate crescător după preț.
cars_5plus <- subset(d, Passengers >= 5)
cars_5plus_sorted <- cars_5plus[order(cars_5plus$Price), ]
View(cars_5plus_sorted)

