# Ia01, TP2 - Harry Potter et les reliques de la mort, partie 3
Ce fichier a pour objectif de mieux comprendre comment lancer les fonctions du TP. A noter qu'aucun accent n'est présent sur le fichier source Lisp pour éviter les problèmes de conversions en fonction des IDE.

## Le fichier
Au sein de l'archive "TP2_Deseure_Manyri_Groupe2.zip" l'ensemble des fonctions utiles se situent dans le fichier "TP2.lisp". Le rapport PDF porte le nom "TP2_Deseure_Manyri_Rapport.pdf"
## Les fonctions
Toutes les fonctions du fichier source disposent de jeux de test mis en paramètre afin de pouvoir tout charger en mémoire (CTRL+a et CTRL+e) au début et ainsi ne plus s'y préoccuper ensuite. Quand au trois fonctions principales permettant de résoudre  les exercices : "Recherche en profondeur pour la recherche de Harry Potter", "Lord Voldemort part à la recherche des Horcruxes" et "Créativité", vous trouverez le détail ci-dessous. A noter que chacune d'elles disposent de paramètres optionnels que l'utilisateur ne doit pas rentrer pour obtenir le résultat attendu. De plus, si l'utilisateur entre des paramètres ne respectant pas les critères décrient ci-dessous, les programmes pourraient renvoyer des erreurs inattendues.
### exploreprofondeur :
Cette fonction permet de résoudre l'exercice "Recherche en profondeur pour la recherche de Harry Potter".
Pour lancer la fonction appliquer cette syntaxe :
-> (exploreprofondeur  carte horcruxesDescription horcruxesMap armesMap profondeurMax pointdepart)
avec :
 * carte : la carte associée au programme selon le format de la variable carte définie en haut du fichier Lisp (le format doit respecter l'ordre pour les successeurs : haut, droite, bas puis gauche.
 * horcruxesDescription : Liste de listes dont chaque sous-liste contient le nom de l'Horcruxe en premier élément et une sous-liste en 2ème élément elle-même composée  de methodeDestruction en premier élément et le nom de l'arme en second élément. (Cf.  variable horcruxesDescription définie en haut du fichier Lisp).
 * horcruxesMap : Contient la liste des sous listes des positions et de l'Horcruxe associé. (Cf. variable définie en haut du Lisp).
 * armesMap : Contient la liste des sous listes des positions et de l'arme associée. (Cf. variable définie en haut du Lisp).
 * profondeurMax : Entier contenant la profondeur max de la recherche en profondeur de Harry (par défaut 7, si inférieur à 0 cela revient à une recherche de profondeur infinie).
 * pointdepart : Entier correspondant à la valeur initiale d'Harry Potter dans le labyrinthe. Cette entier doit être une case valide sinon le résultat ne sera pas celui attendu.

### exploreprofondeurVoldemort:
Cette fonction permet de résoudre l'exercice "Lord Voldemort part à la recherche des Horcruxes".
Pour lancer la fonction appliquer cette syntaxe :
-> (exploreprofondeur  carte horcruxesDescription horcruxesMap armesMap profondeurMax pointdepartHarry pointdepartVdm)
avec :
 * carte : la carte associée au programme selon le format de la variable carte définie en haut du fichier Lisp (le format doit respecter l'ordre pour les successeurs : haut, droite, bas puis gauche.
 * horcruxesDescription : Liste de listes dont chaque sous-liste contient le nom de l'Horcruxe en premier élément et une sous-liste en 2ème élément elle-même composée  de methodeDestruction en premier élément et le nom de l'arme en second élément. (Cf.  variable horcruxesDescription définie en haut du fichier Lisp).
 * horcruxesMap : Contient la liste des sous listes des positions et de l'Horcruxe associé. (Cf. variable définie en haut du Lisp).
 * armesMap : Contient la liste des sous listes des positions et de l'arme associée. (Cf. variable définie en haut du Lisp).
 * profondeurMax : Entier contenant la profondeur max de la recherche en profondeur de Harry (par défaut 7, si inférieur à 0 cela revient à une recherche de profondeur infinie).
 * pointdepartHarry : Entier correspondant à la valeur initiale d'Harry Potter dans le labyrinthe. Cette entier doit être une case valide sinon le résultat ne sera pas celui attendu.
 * pointdepartVdm : Entier correspondant à la valeur initiale de Voldemort dans le labyrinthe. Cette entier doit être une case valide sinon le résultat ne sera pas celui attendu.

### exploration-main:
Cette fonction permet de résoudre l'exercice "Créativité".
Pour lancer la fonction appliquer cette syntaxe :
-> (exploration-main carte horcruxesDescription horcruxesMap armesMap reliquesMap profondeurMax posHarry posVdm nombredetraqueurs)
avec :
 * carte : la carte associée au programme selon le format de la variable carte définie en haut du fichier Lisp (le format doit respecter l'ordre pour les successeurs : haut, droite, bas puis gauche.
 * horcruxesDescription : Liste de listes dont chaque sous-liste contient le nom de l'Horcruxe en premier élément et une sous-liste en 2ème élément elle-même composée  de methodeDestruction en premier élément et le nom de l'arme en second élément. (Cf.  variable horcruxesDescription définie en haut du fichier Lisp).
 * horcruxesMap : Contient la liste des sous listes des positions et de l'Horcruxe associé. (Cf. variable définie en haut du Lisp).
 * armesMap : Contient la liste des sous listes des positions et de l'arme associée. (Cf. variable définie en haut du Lisp).
 * reliquesMap : Contient la liste des sous listes des positions et de la relique associée. (Cf. variable définie en haut du Lisp).
 * profondeurMax : Entier contenant la profondeur max de la recherche en profondeur de Harry (par défaut 7, si inférieur à 0 cela revient à une recherche de profondeur infinie).
 * posHarry : Entier correspondant à la valeur initiale d'Harry Potter dans le labyrinthe. Cette entier doit être une case valide sinon le résultat ne sera pas celui attendu.
 * posVdm : Entier correspondant à la valeur initiale de Voldemort dans le labyrinthe. Cette entier doit être une case valide sinon le résultat ne sera pas celui attendu.
 * nombredetraqueurs : Entier >= 0 correspondant au nombre de détraqueurs qui apparaisent initialement sur la carte.
