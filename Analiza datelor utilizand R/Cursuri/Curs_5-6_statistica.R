# Generez 30 de note pentru studentii unei grupe
note <- sample(1:10, 30, replace=TRUE)


# Sortare note
sort(note)  # ordine crescatoare
sort(note, decreasing = TRUE)  # ordine descrescatoare


# Mediana = valoarea unei serii ordonate crescător / descrescător care împarte
#           seria în 2 părți egale a.î. 50% din termenii seriei au valori mai 
#           mici sau egale cu mediana, iar 50% mai mari sau egale
#   • poate să fie din setul de date sau nu
median(note)


# Valoarea medie -> mean(x)
mean(note)


# Modul = valoarea cea mai des întâlnită în setul de date
mode(note)


# Frecvența absolută = valorile distincte din setul de date și nr. de repetări
#   • table(x) -> primul rând - valorile variabile
#              -> al doilea rând - nr. de apariții al fiecărei variabile
table(note)


# Frecvențe cumulate - cumsum(table(x))
#   • frecvența cumulată a unei valori ”a” din setul de date este suma
#   frecvențelor absolute ale valorilor mai mici decât valoarea ”a”
cumsum(table(note))


# Frecvențe relative - table(x) / length(x)
#   • nr. de apariții al fiecărei valori în setul de date / nr. total de date
#   • sunt numere cuprinse între 0 și 1
table(note)/length(note)


# Amplitudinea = diferența dintre valoarea minimă și maximă
max(note)-min(note)


#  Informatii din setul de date: min, max, prima si a treia quantila, mediana,
# media
summary(note)


# Quantila de ordin q a unei liste de val. numerice (0 < q <= 1) = cel mai mic
#       număr a.î. o proporție q de elemente ale listei sunt mai mici sau cel
#       mult egale cu quantila.
#   • quantile(x,q), q<1
q1<-quantile(note, 0.25); q1
q2<-quantile(note, 0.5); q2
q3<-quantile(note, 0.75); q3

# Intervalul interquartilic (IQR):
#   • quantile(x, 0.75) - quantile(x, 0.25)
#   • IQR(x) 
q3-q1
IQR(note)


# Suma abaterilor față de medie: sum(x - mean(x))
sum(note - mean(note))


#  Deviația standard = rădăcina pătrată din media pătratului (abaterilor față
# de medie)
sqrt(sum((note-mean(note))^2)/length(note))


# Abaterea standard de selecție /(n-1) -> sd(x)
sqrt(sum((note-mean(note))^2)/(length(note)-1)) # = sd(note)


# Sispersia de selecție (/n-1) -> var(x)
sum((note-mean(note))^2)/(length(note)-1) # = var(x)


# Date citite dintr-un set de date - prezența valorilor NA
head(airquality)
airquality$Ozone
mean(airquality$Ozone) # = NA -> trebuie să eliminăm valorile Na
mean(airquality$Ozone,na.rm=T) # = 42.12931



# Reprezentări grafice

#  1. Diagramă cerc pie(valorile,frecvențe)
pie(note)
table(note)
pie(table(note))
etichete<-c("nota 4","nota 5","nota 6","nota 7","nota 8","nota 9","nota 10")
pie(table(note),etichete)

library(plotrix)
pie3D(table(note))

pie3D(table(note),labels=etichete,labelcol = "red",labelcex =0.75)
pie3D(table(note),radius=0.7,labels=etichete,labelcol = "blue",labelcex = 0.75,explode=0.25)
#  • explode e folosit pentru despărțirea bucăților

#  2. Box-plot - cutia cu mustăți
boxplot(note)
boxplot(airquality$Ozone)
boxplot(airquality$Ozone,
        main = "Mean ozone in parts per billion at Roosevelt Island",
        xlab = "Parts Per Billion",
        ylab = "Ozone",
        col = "orange",
        border = "brown",
        horizontal = TRUE
)



