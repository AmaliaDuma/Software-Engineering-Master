#  Pentru reprezentare grafica a punctelor se poate folosi plot
# https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/plot
#  Pentru culori
# https://r-graph-gallery.com/42-colors-names.html

# Argumente pentru plot:
#  • type = "p" (point - implicit) sau "l" (line)
#  • main = titlu grafic
#  • sub = subtitlu
#  • xlab = nume axa Ox | ylab=nume axa Oy
#  • col = culoare
#  • xlim=c(valStart,valFinal) | ylim=c(valStart,valFinal) =  domeniu de reprezentare
#  • pch = valoare numerica (plotting character) - tip simbol  
#  • cex= = valoare numerica (character expansion) - dimensiune simbol
#  • lty = "solid/dashed/dotted/dotdash/..." (line type)
#  • lwd = valoare numerica (line width)

plot(1,2) # un punct

# Reprezentarea punctelor de coordonate [1,2],[-1,3],[5,7]:
x=c(1,-1,5)
y=c(2,3,7)
plot(x,y)
plot(x,y,type="l",main="Primul grafic") # main-titlul graficului

colors()
# Culoarea se poate specifica: denumire | cod hexazecimal | rgb
plot(x,y,pch=6,col="blue",xlim=c(-2,6),ylim=c(1,8))
plot(x,y,pch=16,col="#00009F",xlim=c(-2,6),ylim=c(1,8))
plot(x,y,pch=16,col=rgb(0,0,0.8),xlim=c(-2,6),ylim=c(1,8))

# Completarea graficelor cu text
text(x+0.2,y,labels=c("A","B","C"))  # va pune A,B,C ca label punctelor
abline(h=4,col="red",lty="dotted")
abline(v=3,col="green",lty="dotted")

#http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r

plot(1:20,1:20,pch=1:20,col=1:20)

# Graficul functiei sin pe intervalul [0,2pi] -> sin(x)=f(x) -> plot(x,f(x))
x=seq(0,10*pi,by=0.1);x
y=sin(x);y
plot(x,y)

# http://www.sthda.com/english/wiki/line-types-in-r-lty
# Se poate modifica si felul liniei la reprezentarea grafica
plot(x,y,type="l",main="Graficul functiei sin",
     sub="subtitlu",xlab="t",ylab="sin(t)",xlim=c(0,50),
     ylim=c(-2,2),col="orangered2",lty="dashed",lwd=2)


# Structuri de decizie:
#  • if (conditie) { ... } else { ... }

if (vector[2]==11) {
  print("elementul de pe pozitia 2 este 11")
} else {print("Elementul de pe pozitia 2 nu este 11")}

# Alta versiune: ifelse(conditie, expresie 1, expresie 2)
x <- c(6:-4);x
sqrt(x)  # NOT A NUMBER NAN
sqrt(ifelse(x >= 0, x, NA))  # neg. nr. nu se calculeaza radical si vor fi NA

#  • for (index in interval) { ... }
litere=c("p","r","o","b","a"); litere
for(i in 1:length(litere)) {print(litere[i])} # = for (i in litere) {print(i)}


# Functii: numeFct = function(params) { ... }
#  Orice variabila externa este vizibila in interiorul functiei
#  Ex.: Calculati n!=1*2*3*...*n
produs=function(n)
{
  produs<-1
  for(i in 2:n){
    produs<-produs*i
  }
  return(produs) 
}
produs(5)


# Sa se calculeze primele 20 de elemente din urmatorului sir:
#   x[1]=1, x[2]=1, iar x[n+2]=x[n+1]+x[n]
x=numeric(20) # creaza un vector de dimensiune 20 cu toate elem 0
x[1]=1
x[2]=1
for(i in 3:20) {x[i]=x[i-1]+x[i-2]}
x

# while(cond) { ... }
a=1
print(a)
b=1
print(b)
i=3
while(i<=20){
  c=a+b
  print(c)
  a=b
  b=c
  i=i+1
}

# repeat { ... }
a=1
print(a)
b=1
print(b)
repeat{
  c=a+b
  if(c>1000) break
  print(c)
  a=b
  b=c
}