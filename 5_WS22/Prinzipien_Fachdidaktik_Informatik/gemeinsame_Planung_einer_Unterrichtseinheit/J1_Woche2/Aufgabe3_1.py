def grammBier(anzahl):
    return anzahl * 20

def grammWein(anzahl):
    return anzahl * 16

def grammSekt(anzahl):
    return anzahl * 8.4

def grammJäger(anzahl):
    return anzahl * 5.6

bier = int(input("Flaschen Bier: "))
wein = int(input("Gläser Wein: "))
sekt = int(input("Gläser Sekt: "))
jäger= int(input("Shots Jägermeister: "))

summe_gramm = grammBier(bier) + grammWein(wein) + grammSekt(sekt) + grammJäger(jäger)
print(summe_gramm, "Gramm Alkohol")
#print(int(summe_gramm), "Gramm Alkohol")

