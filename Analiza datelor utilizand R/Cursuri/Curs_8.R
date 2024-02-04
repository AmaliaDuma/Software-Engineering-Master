#1. GENERALITATI DESPRE TESTELE STATITSTICE
#2. INFERENTA ASUPRA MEDIEI UNEI POPULATII

#respingerea unei ipoteze nule nu este acelasi lucru cu infirmarea ei. 

# --- Teste de inferență asupra mediei unei populații --- 

# 1. Cazul 1 - se cunoaște abaterea standard (sigma) a unei populații - testul z
#  • variabila z urmează o repartiție normală standard N(0,1)
#  • z =         (medie eșantion - medie populație) / 
#         (abatere standard populație / radical(volum eșantion))


# H0: mu=72; Ha = mu:72; Datele din eșantion nu sunt cunoscute
alpha<-0.05
mu<-72       # media populației
sigma<-12    # abaterea standard a populației
n<-36        # dimensiune eșantion
medie<-75.2  # media eșantionului

z<-(medie-mu)/(sigma/sqrt(n)); z # statistica z = 1.6

qnorm(0.95,0,1)  # qnorm(p, mean, sd) = 1.644854
#  => 1.6 nu este în regiunea critica (1.644854, infinit), nu resping H0


# Datele din eșantion sunt cunoscute. Se consideră urm. valori:
#        65, 78, 88, 55, 48, 95, 66, 57, 79
#  Media=75; abaterea standard=3; nivel de neîncredere=0.1
#Sunt suficiente pentru a afirma ca media populatiei este mai mica decat 75. 

x <- c(65, 78, 88, 55, 48, 95, 66, 57, 79)
alpha<-0.1
mu<-75
sigma<-3
n<-length(x)
medie<-mean(x)
z<-(medie-mu)/(sigma/sqrt(n)); z # = -4.888889
 
qnorm(0.1,0,1) # qnorm(p, mean, sd) = -1.281552
# => -4.888889 este în regiunea critica (-infinit,-1.281552), resping H0


install.packages("BSDA")
library(BSDA)
# z.test(eșantionul, mu, sigma.x, alternative, conf.level
#   • mu - valoare medie populație
#   • sigma.x - valoare abatere populație
#   • alternative - ipoteza alternativă
#   • conf.level - nivel de încredere = 1-alpha

test1 <- z.test(x, mu = 75, sigma.x = 3, alternative = 'less', conf.level = 0.9)

names(test1)
test1$conf.int
test1$p.value

# Folosing if pt. a afișa decizia finală
if(test1$p.value <= 1 - test1$conf.int[2]) {
  print("Respingem ipoteza nulă") 
} else {  
  print("Nu respingem ipoteza nula")
}
 
 
# 2. Cazul 2 - nu se cunoaște abaterea standard a populației - testul t
#  • variabila t urmează o repartiție Student cu n-1 grade de libertate
#  • t =       (medie eșantion - medie populație) /
#        (abatere standard eșantion / radical(volum eșantion)))

#  Problema: un producător al unei gustări era interesat de greutatea neta 
# medie a conținutului într-un pachet de 80 de grame. Un consumator sună cu o 
# plângere - de-a lungul timpului a cumpărat și a cântărit conținutul a 44 de 
# pachete de 80 de grame alese aleatoriu:
snacks <- c(87.7,80.01,77.28,78.76,81.52,74.2,80.71,79.5,77.87,81.94,80.7,82.32,
            75.78,80.19,83.91,79.4,77.52,77.62,81.4,74.89,82.95,
            73.59,77.92,77.18,79.83,81.23,79.28,78.44,79.01,80.47,76.23,
            78.89,77.14,69.94,78.54,79.7,82.45,77.29,75.52,77.21,75.99,
            81.94,80.41,77.7)
length(snacks)

#Consumatorul afirmă că greutatea netă medie este mai mică de 80 de grame
# - încercăm un test statistic de inferență asupra mediei. H0: mu=80, Ha: mu<80
# - nu știm abaterea standard a populației -> testul t

mu=80
medie_esantion<-mean(snacks)
sigma_esantion<-sd(snacks)
n<-length(snacks)

t_calc<-(medie_esantion-mu)/(sigma_esantion/sqrt(n)); t_calc

# Zona critica
alpha<0.05
qt(alpha,n-1)

#  Valoare statistică calculată este -2.364419, iar regiunea critică este
# (-infinit,-1.301552) => e în regiunea critică, resping H0

# Cum am calcula p-value?
pt(t_calc,df=length(snacks)-1) # = 0.01132

# Același test folosing intrucțiune din R
#  t.test(eșantion, mu, alternative, conf.level)
#   • mu - valoare medie populație
#   • alternative - ipoteza alternativă
#   • conf.level - nivel de încredere = 1-alpha

t.test(snacks, mu=80, alternative="less") # conf.level = 0.95 valoare implicită
# • p-value = 0.1132 > alpha=0.05 => resping H0



# --- Compararea mediilor a două populații ---

# Pentru populații cu distribuție aprox. normală sau volum de eșantion mare
#  I - testul t pentru eșantioane independente
# II - testul t pentru eșantioane dependente (perechi)

# În cazul populațiilor cu distribuție non-normală si eșantioane mici se 
# folosesc teste neparametrice:
#   Testul Mann - Whitney - eșantioane independente
#   Testul Wilcoxon - eșantioane dependente (perechi)

library(UsingR)
dataset=normtemp
attach(dataset)
View(dataset)
t.test(facilityA,mu=180,alternative="less")
t.test(facilityA,facilityB,mu=0,alternative="two.sided")

inainte=c(268,225,252,192,307,228,246,298,231,185)
dupa=c(106,236,253,110,203,101,211,176,194,203)
t.test(inainte,dupa,mu=0,alternative="greater",paired=T)








             
