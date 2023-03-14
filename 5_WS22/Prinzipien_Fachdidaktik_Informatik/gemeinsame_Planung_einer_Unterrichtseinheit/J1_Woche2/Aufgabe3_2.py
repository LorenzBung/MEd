bier = int(input("Flaschen Bier: "))
wein = int(input("Gläser Wein: "))
sekt = int(input("Gläser Sekt: "))
jäger= int(input("Shots Jägermeister: "))

def grammBier(anzahl):
    return anzahl * 20

def grammWein(anzahl):
    return anzahl * 16

def grammSekt(anzahl):
    return anzahl * 8.4

def grammJäger(anzahl):
    return anzahl * 5.6

summe_gramm = grammBier(bier) + grammWein(wein) + grammSekt(sekt) + grammJäger(jäger)
#print(summe_gramm, "Gramm Alkohol")

#-------------------------------------------------------------------------------

def promilleRechnerMann(gramm, gewicht):
    return gramm / (gewicht * 0.7)

def promilleRechnerFrau(gramm, gewicht):
    return gramm / (gewicht * 0.6)

#print(promilleRechnerMann (summe_gramm, 80), "Promille")

#ergebnis_gerundet = round(promilleRechnerMann (summe_gramm, 80), 1)
#print(ergebnis_gerundet, "Promille")

#-Verallgemeinerung--------------------------------------------------------------------------

def promilleRechner(gramm, gewicht, reduktionsfaktor):
    return gramm / (gewicht * reduktionsfaktor)

ergebnis_weiblich = round(promilleRechner (summe_gramm, 70, 0.6), 1)
ergebnis_männlich = round(promilleRechner (summe_gramm, 70, 0.7), 1)
print("Ein weiblicher Körper hätte", ergebnis_weiblich, "Promille")
print("Ein männlicher Körper hätte", ergebnis_männlich, "Promille")