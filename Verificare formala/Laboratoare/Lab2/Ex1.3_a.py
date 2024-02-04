from z3 import *

# Variabile
x11 = Int('x11')
x12 = Int('x12')
x13 = Int('x13')
x21 = Int('x21')
x22 = Int('x22')
x23 = Int('x23')
x31 = Int('x31')
x32 = Int('x32')
x33 = Int('x33')

y1 = Int('y1')
y2 = Int('y2')
y3 = Int('y3')

# Constrangeri
#  1. Valori de 0|1
c1 = [
    And(x11 >= 0, x11 <= 1),
    And(x12 >= 0, x12 <= 1),
    And(x13 >= 0, x13 <= 1),
    And(x21 >= 0, x21 <= 1),
    And(x22 >= 0, x22 <= 1),
    And(x23 >= 0, x23 <= 1),
    And(x31 >= 0, x31 <= 1),
    And(x32 >= 0, x32 <= 1),
    And(x33 >= 0, x33 <= 1),
    And(y1 >= 0, y1 <= 1),
    And(y2 >= 0, y2 <= 1),
    And(y3 >= 0, y3 <= 1)
]

#  2. O masina virtuala se aloca doar unui server
c2 = [
    x11 + x12 + x13 == 1,
    x21 + x22 + x23 == 1,
    x31 + x32 + x33 == 1
]

#  3. Un server este activ daca gazduieste o masina virtuala
c3 = [
    And(y1 >= x11, y1 >= x21, y1 >= x31),
    And(y2 >= x12, y2 >= x22, y2 >= x32),
    And(y3 >= x13, y3 >= x23, y3 >= x33)
]

#  4. Constrangeri de capabilitate/hardware
c4 = [
    100*x11 + 50*x21 + 15*x31 <= 100*y1,
    100*x12 + 50*x22 + 15*x32 <= 75*y2,
    100*x13 + 50*x23 + 15*x33 <= 200*y3
]

solver = Optimize()
solver.add(c1+c2+c3+c4)
solver.minimize(10*y1 + 5*y2 + 20*y3)
solver.minimize(y1+y2+y3)

if solver.check() == sat:
    model = solver.model()
    print(model)
else:
    print("Problem is unsatisfiable")

print(solver.sexpr())