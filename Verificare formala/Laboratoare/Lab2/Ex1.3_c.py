from z3 import *

# Variabile
x11 = Bool('x11')
x12 = Bool('x12')
x13 = Bool('x13')
x21 = Bool('x21')
x22 = Bool('x22')
x23 = Bool('x23')
x31 = Bool('x31')
x32 = Bool('x32')
x33 = Bool('x33')

y1 = Bool('y1')
y2 = Bool('y2')
y3 = Bool('y3')

# Constrangeri
#  1. Valori de 0|1
c1 = [
    Or(x11, x12, x13, x21, x22, x23, x31, x32, x33)
]

#  2. O masina virtuala se aloca doar unui server
c2 = [
    If(x11, 1, 0) + If(x12, 1, 0) + If(x13, 1, 0) == 1,
    If(x21, 1, 0) + If(x22, 1, 0) + If(x23, 1, 0) == 1,
    If(x31, 1, 0) + If(x32, 1, 0) + If(x33, 1, 0) == 1
]

#  3. Un server este activ daca gazduieste o masina virtuala
c3 = [
    And(y1 >= If(x11, 1, 0), y1 >= If(x21, 1, 0), y1 >= If(x31, 1, 0)),
    And(y2 >= If(x12, 1, 0), y2 >= If(x22, 1, 0), y2 >= If(x32, 1, 0)),
    And(y3 >= If(x13, 1, 0), y3 >= If(x23, 1, 0), y3 >= If(x33, 1, 0))
]

#  4. Constrangeri de capabilitate/hardware
c4 = [
    100*If(x11, 1, 0) + 50*If(x21, 1, 0) + 15*If(x31, 1, 0) <= 100*If(y1, 1, 0),
    100*If(x12, 1, 0) + 50*If(x22, 1, 0) + 15*If(x32, 1, 0) <= 75*If(y2, 1, 0),
    100*If(x13, 1, 0) + 50*If(x23, 1, 0) + 15*If(x33, 1, 0) <= 200*If(y3, 1, 0)
]

solver = Optimize()
solver.add(c1+c2+c3+c4)
solver.minimize(10*If(y1, 1, 0) + 5*If(y2, 1, 0) + 20*If(y3, 1, 0))
solver.minimize(If(y1, 1, 0)+If(y2, 1, 0)+If(y3, 1, 0))

if solver.check() == sat:
    model = solver.model()
    print(model)
else:
    print("Problem is unsatisfiable")

print(solver.sexpr())