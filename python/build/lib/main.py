import csv

from postgre import Postgre

if __name__ == '__main__':

    # Lecture des attributs
    file = open(file="attributs.txt")
    attributs = file.read().splitlines()
    file.close()
    # On nettoie les remplaces les espaces pour éviter les problèmes de création lors du passage en sql
    for idx, line in enumerate(attributs):
        attributs[idx] = line.replace(" ", "_")

    # Chargement des données
    data = csv.reader(open("../MetObjects.csv"))

    db = Postgre()
    reponse = input("Creer la table initiales ?(y/n)")
    if 'y' == reponse or 'Y' == reponse:
        db.createTable(attributs)

    db.closeConnection()
