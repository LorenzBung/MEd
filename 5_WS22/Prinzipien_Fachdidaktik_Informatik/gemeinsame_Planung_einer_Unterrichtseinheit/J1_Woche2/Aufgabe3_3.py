bier = int(input("Flaschen Bier: "))
wein = int(input("Gläser Wein: "))
sekt = int(input("Gläser Sekt: "))
jäger = int(input("Shots Jägermeister: "))
gewicht = int(input("Gewicht in kg: "))
reduktion = float(input("Reduktionsfaktor: 0.6 oder 0.7? "))

def grammBier(anzahl):
    return anzahl * 20

def grammWein(anzahl):
    return anzahl * 16

def grammSekt(anzahl):
    return anzahl * 8.4

def grammJäger(anzahl):
    return anzahl * 5.6

summe_gramm = grammBier(bier) + grammWein(wein) + grammSekt(sekt) + grammJäger(jäger)

def promilleRechner(gramm, gewicht, reduktionsfaktor):
    return gramm / (gewicht * reduktionsfaktor)

ergebnis_promille = round(promilleRechner(summe_gramm, gewicht, reduktion),1)
print(ergebnis_promille, "Promille")

#----------------------------------------------------------------------------------

def alkoholAbbau(promille):
    return promille / 0.15

abbauzeit = round(alkoholAbbau(ergebnis_promille), 1)
print("In frühestens", abbauzeit, "Stunden sind Sie wieder nüchtern")