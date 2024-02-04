library(UsingR)
data(normtemp)

# ----------- Teste de inferență statistică ----------- 

# ----- Ex. 1 ----- 
# a) Să se verifice la nivelul de semnificație 0.03 ipoteza că temperatura 
# corporală normală este mai mică decât 98.6◦F.
#    • nivel semnificatie = 0.03 -> conf.level = 0.97
#    • folosim test cu coadă inferioară pt. a testa dacă prima medie e mai 
#    mică decât a doua medie 
r1 <- t.test(normtemp$temp, mu = 98.6, alternative = "less", conf.level = 0.97)
r1
# Adevarat

# b) Să se verifice la nivelul de semnificație 0.05 ipoteza că temperatura 
# corporală este mai ridicată la femei decât la bărbați.
#   • nivel semnificatie = 0.05 -> conf.level = 0.95 = default
temp1 <- subset(normtemp, gender == 1)$temp
temp2 <- subset(normtemp, gender == 2)$temp

#  • Folosim test cu coadă superioară pt. a testa dacă prima medie e mai 
#  mare decât a doua medie
r2 <- t.test(temp1, temp2, alternative = "greater")
r2
# Adevarat


# ----- Ex. 2 ----- 
data(babies)

# a) Să se extragă timpul de gestație pentru mamele care au fumat cel puțin o 
# dată și pentru cele nefumătoare.
set1 <- babies[babies$smoke >= 1, "gestation"]
set2 <- babies[babies$smoke == 0, "gestation"]

# b) Să se verifice la nivelul de semnificație 0.05 dacă timpul de gestație 
# este același pentru mamele fumătoare și pentru cele nefumătoare.
#   • folosim test bilateral (two.sided) pt. a a evalua dacă există o diferență
#   între cele două grupuri.
r3 <- t.test(set1, set2, alternative="two.sided")
r3
# => Nu e acelasi

# c) Există diferențe între vârstele mamelor și taților?
varsta_mame <- babies$age
vartsa_tati <- babies$dage

# • Folosim test bilateral (two.sided) pt. a a evalua dacă există o diferență
# între cele două grupuri.
r4 <- t.test(varsta_mame, vartsa_tati, alternative="two.sided")
r4
# Da, exista diferente


# ----- Ex. 3 ----- 
media_initiala <- 3.5
abatere_standard <- 0.04
n <- 73 # esantion
media_esantion <- 3.97 
abatere_standard_esantion <- 2.21
nivel_semnificatie <- 0.03

#  Calculam statistica testului
stat <- (media_esantion - media_initiala) / (abatere_standard_esantion / sqrt(n))

#  Calculam valoarea critica
valoare_critica <- qt(1 - nivel_semnificatie / 2, df = n - 1)

# Afisam valoarea critica și a statistica testului
print(paste("Valoarea critică este:", valoare_critica))
print(paste("Statistica t este:", stat))

#  Testarea ipotezei nule H0 (Greutatea medie adevarata a pisicilor din aceasta 
# rasă este 3.5 kilograme)
if (abs(stat) > valoare_critica) {
  print("Media diferențelor este semnificativ diferită de 3.5 kg.")
} else {
  print("Media diferențelor nu este semnificativ diferită de 3.5 kg.")
}



# --- Corelație liniară. Regresie liniară unifactorială și multifactorială ---
library(MASS)
data(anorexia)

# ----- Ex. 1 ----- 
# a) Există o corelație liniară între cele două variabile? Există corelație 
# liniară la niveul populației?

correlation <- cor(anorexia$Prewt, anorexia$Postwt)  # coef. de corelație
print(correlation)
# nivel de corelație = 0.3324062 => corelație liniară slabă

# b) Să se afișeze ecuația de regresie liniară
model_regresie <- lm(Postwt ~ Prewt, data = anorexia)
coeficienti <- coef(model_regresie)
cat("Postwt =", coefficients[1], "+", coefficients[2], "* Prewt", "\n")

# c) Analizând detaliile regresiei se poate ajunge la acelați răspuns ca și la
# subpunctul a
summary(model_regresie)$r.squared
summary(model_regresie)

# d) Să se reprezinte norul de puncte și dreapta de regresie liniară.
plot(anorexia$Prewt, anorexia$Postwt, xlab = "Prewt", ylab = "Postwt", main = "Norul de Puncte și dreapta de Regresie")
abline(model_regresie, col = "red")  # dreapta de regresie

# e) Încercați să afișați corelația liniară între greutatea pacientelor 
# înainte și după tratament, dar pentru fiecare tratament în parte (variabila 
# Treat este o variabilă factor cu mai multe posibilități de răspuns)
par(mfrow = c(1, 3))
for (t in unique(anorexia$Treat)) {
  set <- anorexia[anorexia$Treat == t, ]
  model_regresie_aux <- lm(Postwt ~ Prewt, data = set)
  
  plot(set$Prewt, set$Postwt, 
       xlab = "Greutate înainte de tratament", ylab = "Greutate după tratament",
       main = paste("Tratament:", t))
  
  abline(model_regresie_aux, col = "blue")
}

# f) Să se creeze o nouă variabilă care indică creșterea în greutate după
# tratament (Postwt-Prewt) și să se calculeze media acestei variabile.
crestere_greutate <- anorexia$Postwt - anorexia$Prewt
media_crestere_greutate <- mean(crestere_greutate)
media_crestere_greutate


# ----- Ex. 2 ----- 
library(mfp)
data("bodyfat")

varsta <- lm(brozek ~ age, data = bodyfat)
greutate <- lm(brozek ~ weight, data = bodyfat)
circumferinta <- lm(brozek ~ abdomen, data = bodyfat)
varsta_greutate <- lm(brozek ~ age + weight, data = bodyfat)
varsta_circumferinta <- lm(brozek ~ age + abdomen, data = bodyfat)
greutate_circumferinta <- lm(brozek ~ weight + abdomen, data = bodyfat)
toate <- lm(brozek ~ age + weight + abdomen, data = bodyfat)

summary(varsta)   # p-value: 3.045e-06
summary(varsta)$r.squared  # 0.08362132

summary(greutate)  # p-value: < 2.2e-16
summary(greutate)$r.squared  # 0.3759604

summary(circumferinta)  # p-value: < 2.2e-16
summary(circumferinta)$r.squared  # 0.6621178

summary(varsta_greutate)  # p-value: < 2.2e-16
summary(varsta_greutate)$r.squared  # 0.4641771

summary(varsta_circumferinta)  # p-value: < 2.2e-16
summary(varsta_circumferinta)$r.squared  # 0.673038

summary(greutate_circumferinta)  # p-value: < 2.2e-16
summary(greutate_circumferinta)$r.squared  # 0.7187265

summary(toate)  # p-value: < 2.2e-16
summary(toate)$r.squared  # 0.7188867
# => cea mai mare calitate o are modelul cu toate variabilele 

