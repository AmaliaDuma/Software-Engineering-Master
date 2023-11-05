#  Vectori -- contin elem. de acelasi tip, daca sunt introduse elem. diferite
# de ex. un numar si un caracter, toate elem. vor fi transformate in caractere
#  Pentru a aduna doi vectori, lungimea unui vector trebuie sa fie multiplu
# de lungimea celuilalt.

# CREARE DE VECTORI

a<-1:10
b<-c("ana","are","mere")

#  Vectorii cu valori logice se pot folosi pt. afișarea unor elemente dintr-un
# vector. Operatii posibile si fara ca dimensiunea acestora sa fie multiplu
# de dimensiunea vectorului pe care e aplicat.
c<-c(T,F,T)
a[c]


# ----- Ex.1 -----
# a) Construiti vectorul: (30, 29, . . . , 2,1)
a<-30:1

# b) Afisati doar elementele de pe pozitiile pare
a[c(F,T)]

# c) Elementele de pe pozitiile ce sunt multiplii de 6 
a[(1:length(a)%%6==0)]

# d) Elementele care sunt multiplu de 12
a[a%%12==0]

# e) Numerele pare din vector
a[a%%2==0]
#----------------


# FUNCȚII SPECIFICE PENTRU VECTORI LOGICI
#  - all(x) -> T daca toate sunt T
#  - any(x) ->  T daca cel putin una este T
#  - which(x) -> pozitiile pentru care valoarea este T
x<-c(T,F,F,T,T,F,T)
all(x)
any(x)
which(x)

# Toate componentele mai mari ca 0?
all(y>0)

# O componenta mai mare ca 0?
any(y>0)

# Ce componente sunt mai mari decat 0?
which(y>0)

# ----- Ex. 2 -----
# a) Construiti vectorul: x=[2,1,-3,26,15,17,20]
x=c(2,1,-3,26,15,17,20)

# b) Sa se afiseze pe ce pozitii din x se gasesc elemente pare
which(x%%2==0)

# c) Sa se afiseze elementele de pe pozitiile pare
x[c(F,T)]

#d) Sa se determine cel mai mic si cel mai mare element din vector
min(x)
max(x)
# sau functia range care afiseaza si min si max
range(x)

#e) Sa se afiseze pozitia minimului si maximului
which.min(x)  # Retine prima pozitie a min/max
which.max(x)

#f) Adaugati la x elemente -3,2,8,-1 si reafisati pozitia celui mai mic numar 
x<-c(x,-3,2,8,-1)
which(x==min(x))  # Pentru a afisa toate pozitiile minimului
#----------------

# TIP: which(cond pt elementul unui vector pt a fi afisat) -> pozitiile elem

sum(y)  # Suma elem. unui vector
prod(y)  # Prod elem. unui vector
cumsum(y)  # Suma cumulativa: 1st elem, 1st + 2nd, 1st + 2nd + 3rd, etc.
cumprod(y) # Prod cumulativ
diff(y)  # Diff la fel ca pt. cumsum
length(y)


# SORTAREA UNUI VECTOR
sort(y)
sort(y,decreasing=T)

# SCRIEREA VECTORULUI IN ORDINE INVERSA
rev(y)

# POZITIILE ELEM. PENTRU A LE AFISA IN ORDINE CRESCATOARE
order(y)
y[order(y)] # == sort(x)

# ELEMENTE DISTINCTE
y<-c(2,1,2,5)
unique(y)

# Sa se verifice daca toate valorile din x sunt identice
length(unique(y))==1


#NA (not available) - codificare pentru date lipsa
NA+2
NA==5
NA==NA
x=c(NA,x,NA)
x
sum(x)  # Va afisa NA -> trebuie eliminate valorile NA = na.rm=T
mean(x)

sum(x,na.rm=T)
mean(x,na.rm=T)

# Afiseaza daca exista valori NA in vector
is.na(x)
