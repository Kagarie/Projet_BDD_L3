import psycopg2


class Postgre:

    def __init__(self):
        # On fait le point de connection à la db
        self.db = psycopg2.connect(database=input("database="), user=input("user="), password=input("password="),
                                   host="localhost", port=5432)
        # On récupère la connection
        self.cur = self.db.cursor()
        # Si tout ce passe bien on affiche la version de PostrgreSQL
        self.cur.execute("SELECT version();")
        record = self.cur.fetchone()
        print("You are connected into the - ", record, "\n")

    # Créatrion de la table initiale celle qui du début de projet
    def createTable(self, attributs):
        tmp = ''
        tmp2 = ''
        for i in range(10, 30):
            tmp += attributs[i] + ''' VARCHAR ,'''

        for i in range(31, 53):
            tmp2 += attributs[i] + ''' VARCHAR ,'''

        try:
            requete = '''CREATE TABLE tableInitiale''' + '''(''' + attributs[0] + ''' VARCHAR ,''' + attributs[
                1] + ''' VARCHAR ,''' + attributs[2] + '''  VARCHAR ,''' + attributs[3] + '''  VARCHAR ,''' + attributs[
                          4] + '''  VARCHAR ,''' + attributs[5] + '''  VARCHAR ,''' + attributs[6] + '''  VARCHAR ,''' + \
                      attributs[7] + '''  VARCHAR ,''' + attributs[8] + ''' VARCHAR ,''' + attributs[
                          9] + '''  VARCHAR ,''' + tmp + ''' ''' + attributs[30] + ''' VARCHAR ,''' + tmp2 + attributs[
                          53] + ''' VARCHAR );'''
            print(requete)
            self.cur.execute(requete)
            self.db.commit()
            print('Création de la table réussie')
        except:
            print("Echec de la création de la table")

    # Fermeture de la connection
    def closeConnection(self):
        self.db.close()
