#  Liste - pot contine elem. de tipuri diferite si pot fii organizate pe mai
# multe niveluri. Se creaza cu ajutorul instructiunei list(...)
#  = vectori de vectori ce pot avea dimensiuni diferite

# Creaza cate o lista pentru fiecare element
l1<-list(1,3,5,"Ana","Livia","Radu")
l1

# Creaza doua liste, prima [1,3,5], a doua ["Ana","Livia","Radu"]
l2<-list(c(1,3,5),c("Ana","Livia","Radu"))
l2

# l2[[1]] va afisa prima sub lista 
# l2[[1]][1] va afisa primul element din prima sub lista
#   1          3
l2[[1]][1]+l2[[1]][2]


#  Fiecarui vector ii se poate da o denumire, acesta putand fi accesat cu
# sintaxa numeLista + $ + numeVector
l3<-list(Valori=c(1,3,5), Caractere=c("Ana", "Livia", "Radu"))
l3$Caractere  # == l3[[2]]

# mode afiseaza tipul obiectelor si implicit a celor din lista

mode(l3)
mode(l3$Valori)
mode(l3$Caractere)


# Matrice - matrix(data, nrow=, ncol=, byrow=FALSE)
#            • data = valorile din matrice
#            • nrow = numar linii | ncol = numar coloane
#            • byrow = cum se scriu elem, pe linie / coloana
#  = cazuri particulare de liste cu acelasi tip de elem si de aceeasi 
#  dimensiune
t<-matrix(0,nrow=2,ncol=3)  # toate elem 0
t
m1<-matrix(1:4,2,2);m1
m2<-matrix(1:4,2,2,byrow=T);m2

# Elem pot fi date ca un vector de valori
valori<-c(1:24)
A<-matrix(valori,nrow=4,ncol=3);A
B<-matrix(valori,nrow=4,ncol=3,byrow=TRUE);B

# Afisarea elementelor matricii: m[nrow,ncol]
B[2,3]

# Liniile si coloanele se pot numi: colnames(x) <- value | rownames(x) <- value
A[4,2]
colnames(A)<-c("coloana1","coloana2","coloana3")
rownames(A)<-c("linia1","linia2","linia3","linia4")
A["linia4","coloana2"]  # == A[4,2]
A["linia2","coloana3"]  # == A[2,3]

# Diferite moduri de a afisa elemente din matrice
A["linia1",]  # == A[1,]
A[,"coloana1"]  # == A[,1]
B[2,]
B[,2]

# Operatii cu matrici:
A+B   # suma, matricile trebuie sa aiba aceeasi dimensiune
A*B   # calculeaza o matrice in care inmulteste element cu element
A%*%B # inmultirea
5*A   # inmultire cu scalar
A-B   # diferenta
t(A)  # transpusa matricei


#A(4,3) t(2,3)
#dimensiuni (4,3)*(3,2)=(4,2)
#cum functioneaza inmultire?
#matematic cu %*% doar trebuie patratice

A=matrix(c(2,4,6,8),2,2)
A
B=matrix(c(1,3),2,1)
B
C=matrix(c(1,3),1,2)
D=matrix(c(1,2),2,2)
A%*%B
A%*%C
A%*%D

# Adaugare linii/coloane: rbind(vect1, vect2,...) | cbind(vect1, vect2,...)
A<-cbind(A,c(10,11,12,13));A
A<-rbind(A,0);A

# Factor - variabile categoricale = vector cu valori limitate
v1<-c(2,3,1,3,2,4,2,1,1,3,2,2,3,4);v1
f1<-as.factor(v1);f1

v2<-c("F","M","M","F","M","F","F","M","F","M");v2
f2<-as.factor(v2);f2


# Afisarea nivelelor: levels(x)
levels(f2)
# Redenumirea nivelelor: levels(x)<-vect
levels(f2)<-c("Feminin", "Masculin");f2
levels(f2)

# Afisarea pe categorii
table(f2)

# Exista posibilitatea ordonarii
f3<-factor(c("ora 8","ora 9.40","ora 13.00","ora 8","ora 11.20","ora 11.20","ora 8","ora 9.40"),
                levels=c("ora 8","ora 9.40","ora 11.20","ora 13.00"),ordered=TRUE)
f3
table(f3)


#  Dataframe - colectie din unul sau mai multi vectori si/sau factori de aceeasi
# lungime de orice tip. Cea mai buna reprezentare a seturilor de date statistice.
#   • liniile = obiecte (elem din setul de date)
#   • coloanele = atribute 
marca<-c("VW","Re","Fi")
motor<-c("D","B","B")
capacitate<-c(1600,1900,1200)
auto<-data.frame(marca,motor,capacitate)
auto

x <- data.frame("masa"=c(65,75),"inaltime"=c(168,175),"gen"=c("m","f")); x