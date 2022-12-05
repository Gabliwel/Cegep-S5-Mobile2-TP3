## TP3 ##
### DÉVELOPPEMENT MOBILE ET OBJETS CONNECTÉS groupe 0002 ### 

Réalisé par Gabriel Bertrand & Keven Champagne

##### Récits utilisateur choisi:
- Bleu/Orange
    - 11 (*Voir les commentaires d'une station*)
    - 12 (*Ajouter un commentaire à une station*)
    - 13 (*Être informé du nombre de commentaires*)
- Rouge
    - 7 (*Rechercher des stations par nom*)

##### Bogue(s) connu(s):
- Pour lancer l'app, suite a la génération de l'APK sur le second poste, le premier poste a du changer dans 
 android/app/build.gradle, à la ligne 66 __storeFile file(keystoreProperties['storeFile'])__ pour __storeFile file("key.jks")__ afin de run le projet

##### Informations
- Pour faire rouler les tests d'intégrations, il faut s'assurer de se déconnecter de l'application avant de la fermer sinon, les tests ne fonctionneront pas.

