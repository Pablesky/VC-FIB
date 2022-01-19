import os
import random
import shutil

directory = input("Introduce nombre de la carpeta\n")
donde1 = input("Donde el train\n")
donde2 = input("Donde el test\n")
porcentaje = input("Porcentaje del train (valores de 0 a 1)\n")

lista = os.listdir(directory)
longitud = len(lista)

random.shuffle(lista)
print(lista)
n = longitud * float(porcentaje);

for i in range(0, int(n)):
    original = directory + "\\" + lista[i]
    target = donde1 + "\\" + lista[i]

    print("original: " + original)
    print("copia: " + target)

    shutil.copyfile(original, target)

for i in range(int(n), longitud):
    original = directory + "\\" + lista[i]
    target = donde2 + "\\" + lista[i]

    print("original: " + original)
    print("copia: " + target)

    shutil.copyfile(original, target)
