; TP2  Harry Potter et les reliques de la mort ; 
; Manyri Colin et Alexis Deseure
;<CTRL+a> et <CTRL+e> pour charger toutes les vriables/fonctions

; TP2  Harry Potter et les reliques de la mort ; 

;Livrables attendus : un fichier lisp + un rapport presentant et argumentant les reponses aux questions
;Format attendu : une archive nommee TP2_NomBinome1_NomBinome2_GroupeX.zip/rar
;Date de remise : 20 novembre 2023 18.00


;Chaque Horcruxe peut etre detruit par une methode de destruction unique. Voici la description des Horcruxes et des methodes de destruction associees :

;Journal intime de Tom Jedusor.               Methode de destruction : Crochet de Basilic
;Medaillon de Salazar Serpentard.             Methode de destruction : Epee de Gryffondor
;Bague de Gaunt.                              Methode de destruction : Epee de Gryffondor
;Coupe de Helga Poufsouffle.                  Methode de destruction : Crochet de Basilic
;Nagini.                                      Methode de destruction : Epee de Gryffondor
;Diademe de Rowena Serdaigle.                 Methode de destruction : Feudeymon
;Harry Potter.                                Methode de destruction : Sortilege de la Mort

;Les Horcruxes sont caches dans les cases suivantes :

;Journal intime de Tom Jedusor.       8
;Medaillon de Salazar Serpentard.    12
;Bague de Gaunt.                     15
;Coupe de Helga Poufsouffle.         22
;Nagini.                             26
;Diademe de Rowena Serdaigle.        29

;Une methode de destruction peut detruire plusieurs Horcruxes. Quatre methodes de destruction sont cachees dans les cases suivantes :

;Crochet de Basilic                  3
;Sortilege de la Mort               20
;Epee de Gryffondor                 25
;Feudeymon                          32




;============== Definition des elements du probleme ==============




(setq carte '((1 12 2)(2 1 3)(3 2 4)(4 3 5)(5 4 8 6)(6 5 7)(7 8 6)(8 7 5)(12 13 1)
            (13 24 12)(15 22)(20 21 29)(21 22 20)(22 27 21 15)(24 25 13)
            (25 36 26 24)(26 25 27)(27 26 22)(29 32 20)(32 29)(36 25)))


(setq horcruxesDescription '(("Journal intime de Tom Jedusor" 
                                (methodeDestruction "Crochet de Basilic"))
                             ("Medaillon de Salazar Serpentard" 
                                (methodeDestruction "Epee de Gryffondor"))
                             ("Bague de Gaunt" 
                                (methodeDestruction "Epee de Gryffondor"))
                             ("Coupe de Helga Poufsouffle" 
                                (methodeDestruction "Crochet de Basilic"))
                             ("Nagini" 
                                (methodeDestruction "Epee de Gryffondor"))
                             ("Diademe de Rowena Serdaigle" 
                                (methodeDestruction "Feudeymon"))))

(setq horcruxesMap '((8 "Journal intime de Tom Jedusor")
                     (12 "Medaillon de Salazar Serpentard")
                     (15 "Bague de Gaunt")
                     (22 "Coupe de Helga Poufsouffle")
                     (26 "Nagini")
                     (29 "Diademe de Rowena Serdaigle")))

(setq armesMap '((3 "Crochet de Basilic")
                 (32 "Feudeymon")
                 (25 "Epee de Gryffondor")
                 (20 "Sortilege de la Mort")))

(setq reliqueMap '((6 "Baguette de sureau")
		   (36 "Cape d'invisibilite")
	           (15 "Pierre de resurrection")))



;============== Fonctions de service =============



(defun successeurs-valides (point carte chemin)
	(if (and (listp carte) (listp chemin)) ;evite une erreur si les arguments ne sont pas corrects

		(let ((valides) (listesuccesseurs (assoc point carte))) ;initialisation d'une liste vide

			(reverse (dolist (successeur (cdr listesuccesseurs) valides) ; pour tout les successeurs du point dans carte
                                (if (not (member successeur chemin)) ; si on n'est pas deja passe par ce point (presence dans chemin)
						(push successeur valides) ; on ajoute ce point dans la liste valides
				)
			)) ;on utilise le reverse pour correspondre à la consigne "il (Harry) ne pourra se déplacer que sur des cases contiguës (en haut, à droite, en bas ou à gauche)"
	   )
	   (format t "Erreur dans carte ou dans chemin ~%")
	)
)


;Jeu de testes : 

;(successeurs-valides 1 carte nil)
;(successeurs-valides 22 carte nil)
;(successeurs-valides 22 carte '(27 21))
;(successeurs-valides 23 carte nil)
;(successeurs-valides 1 34 nil)
;(successeurs-valides 1 carte 4)



;methodeDestruction( char list(list)) -> char 

(defun methodeDestruction (horcruxe listedescriptions)
	(let ((description_horcruxe (assoc horcruxe listedescriptions :test #'string=))) ;trouver la description du bon Horcruxe avec assoc
		(if description_horcruxe ;si cette description existe 
	 		(cadr (assoc 'methodeDestruction (cdr description_horcruxe))) ;On fait un autre assoc pour determiner la methode de destruction de l'horcuxe
	 		(format t "Pas d'information sur l'Horcruxe : ~a dans ~a !~%" horcruxe listedescriptions) ;sinon il n'y a pas d'information sur l'horcruxe 
		)
	)
)

;Jeu de testes : 

;(methodeDestruction "Nagini" horcruxesDescription)
;(methodeDestruction "Journal intime de Tom Jedusor" horcruxesDescription)
;(methodeDestruction "Hocruxeinconnu" horcruxesDescription)



;hasBonneArme (char list list(list)) -> bool
;teste si les armespossedees permettent de detruire l'horcruxe d'apres la descrition. 
;exemple : (hasBonneArme "Nagini" '("Epee de Gryffondor") horcruxesDescription) renvoie True 

(defun hasBonneArme (horcruxe armespossedees description)
	(if (and (listp armespossedees) (member (methodeDestruction horcruxe description) armespossedees :test #'string=))
		T ;teste si armespossedees est bien une liste et si la methode de destruction necessaire est presente dans armespossedees 
	)
)

;Jeu de testes :

;(hasBonneArme "Nagini" '("Epee de Gryffondor") horcruxesDescription)
;(hasBonneArme "Nagini" '("Epee de Gryffondor" "Coupe de Helga Poufsouffle") horcruxesDescription)
;(hasBonneArme "Nagini" '("Coupe de Helga Poufsouffle") horcruxesDescription)
;(hasBonneArme "Horcruxeinconnu" '("Epee de Gryffondor" "Coupe de Helga Poufsouffle") horcruxesDescription)



;============== Recherche en profondeur pour la recherche de Harry Potter =============

(defun exploreprofondeur (carte horcruxesDescription horcruxesMap armesMap profondeurMax pointdepart &optional chemin horcruxedetruit armespossedees)

	(setq chemin (append chemin (list pointdepart))) ;ajout du point aux chemins
	(format t "Harry Potter est sur la case ~a, il a parcouru le chemin : ~a~%" pointdepart chemin)
  

        (let ((arme (cadr (assoc pointdepart armesMap))))
		(if arme ;si il y a une arme sur la case alors (cadr (assoc pointdepart armesMap)) est different de nil et vaut l'arme en question
		 	(progn 
		 		(push arme armespossedees); on ajoute l'arme aux armes recontrees
		 		(format t "Harry Potter a recupere l'arme ~a ! Il a maintenant en sa possession ~a~%" arme armespossedees)
		 	)
		)
	)


	 (let ((horcruxe (cadr (assoc pointdepart horcruxesMap)))) ;on regarde si il y a un horcruxe
             (if horcruxe
	 	(if (hasBonneArme horcruxe armespossedees horcruxesDescription) ;si on a la bonne arme
	 		(progn 
	 			(push horcruxe horcruxedetruit) ;on ajoute l'horcruxe aux horcruxe detruits 
	 			(format t "Harry Potter detruit l'horcruxe ~a avec ~a !~%" horcruxe (methodeDestruction horcruxe horcruxesDescription)) ;on affiche la destruction de l'horcruxe 
	 		)
	 		(format t "Il y a un horcruxe ici : ~a ! Mais... on ne peux pas le detruire~%" horcruxe) ;sinon on ne peux pas detruire l'horcruxe 
	 	)  
             )
	   )
        (let (brancheActuelle (successeurs (successeurs-valides pointdepart carte chemin))) ;appel recursif sur les successeurs   
          (if (= profondeurMax 0) 
                    (format t "La profondeur maximale a ete atteinte, on remonte !~%")
                    (if successeurs
			(dolist (succ successeurs)
                                (if (member succ (successeurs-valides pointdepart carte chemin)) ; on verifie que le successeur valide en est toujours un, car dans le cas ou deux branches se recroisent il se peut que le parcourt de la premiere branche avance dans la seconde et donc que etant deja  parcouruent, les successeurs ne soient plus correctes alors qui l'etaient avant le do-list 
                                    (progn
				          (setq brancheActuelle (exploreprofondeur carte horcruxesDescription horcruxesMap armesMap (- profondeurMax 1) succ chemin horcruxedetruit armespossedees))
                                          (format t "Harry retourne sur la case ~a, il ne peut donc plus interagir avec s'il restait un Horcruxe...~%" pointdepart)
                                          (setq horcruxedetruit (cadr (assoc 'horcruxes brancheActuelle)))
                                          (setq armespossedees (cadr (assoc 'armes brancheActuelle)))
                                          (setq chemin (append (cadr (assoc 'chemin brancheActuelle)) (list pointdepart))) ;on affiche la case actuel a la fin du chemin pour mieux visualiser l'itineraire pris par Harry
                                    ) 
                                )
                        )
                    )
            )
          (format t "Le chemin parcouru par Harry Potter est ~a~%Harry Potter a obtenu les armes ~a et a detruit les horcruxes ~a ~%" chemin armespossedees horcruxedetruit)
          (list (list 'horcruxes horcruxedetruit) (list 'armes armespossedees) (list 'chemin chemin)) ; on retourne ce qui est demande
        )	
)

;Jeu de teste : (exploreprofondeur carte description_horcruxes carte_horcruxe carte_arme profondeur_max point_depart)
;(EXPLOREPROFONDEUR carte horcruxesDescription horcruxesMap armesMap 7 1)
;(EXPLOREPROFONDEUR carte horcruxesDescription horcruxesMap armesMap 7 36)
;(EXPLOREPROFONDEUR carte horcruxesDescription horcruxesMap armesMap 11 1) ;notre programme permet aussi de changer la profondeur maximale 
;(EXPLOREPROFONDEUR carte horcruxesDescription horcruxesMap armesMap 7 22)



;============== Lord Voldemort part à la recherche des Horcruxes =============



(defun exploreprofondeurVoldemort (carte horcruxesDescription horcruxesMap armesMap profondeurMax pointdepartHarry pointdepartVdm &optional cheminHarry cheminVdm horcruxedetruitHarry horcruxedetruitVdm armespossedeesHarry armespossedeesVdm)
	

    (setq cheminHarry (append cheminHarry (list pointdepartHarry))) ;ajout du point aux chemins
    (setq cheminVdm (append cheminVdm (list pointdepartVdm))) ;ajout du point aux chemins
    (format t "Harry Potter est sur la case ~a, il a donc parcouru le chemin : ~a~%" pointdepartHarry cheminHarry)
    (format t "Voldemort est sur la case ~a, il a donc parcouru le chemin : ~a~%" pointdepartVdm cheminVdm)
    
    (let ((armeHarry (cadr (assoc pointdepartHarry armesMap))) (armeVdm (cadr (assoc pointdepartVdm armesMap))))
		(if (and armeHarry (not (member armeHarry armespossedeesHarry :test #'string=)) (not (member armeHarry armespossedeesVdm :test #'string=)));si il y a une arme sur la case alors armeHarry est different de nil et vaut l'arme en question
		 	(progn 
		 		(push armeHarry armespossedeesHarry); on ajoute l'arme aux armes recontrees
		 		(format t "Harry Potter a recupere l'arme ~a ! Il a maintenant en sa possession ~a~%" armeHarry armespossedeesHarry)
		 	)
		)
	        (if (and armeVdm (not (member pointdepartVdm (cdr (reverse cheminVdm)))) (not (member armeVdm armespossedeesHarry :test #'string=)) (not (member armeVdm armespossedeesVdm :test #'string=))) ;si il y a une arme sur la case alors armeVdm est different de nil et vaut l'arme en question
		 	(progn 
		 		(push armeVdm armespossedeesVdm); on ajoute l'arme aux armes recontrees
		 		(format t "Voldemort a recupere l'arme ~a ! Il a maintenant en sa possession ~a~%" armeVdm armespossedeesVdm)
		 	)
		)
    )
    (if (and (= pointdepartVdm pointdepartHarry) (member "Sortilege de la Mort" armespossedeesVdm :test #'string=) ) ; si harry et voldemort sont sur la meme case et voldemort a le sortilege de la mort
        (progn
          (push "Harry Potter" horcruxedetruitVdm)
          (format t "Harry et Voldemort sont sur la meme case et Voldemort possede le sortilege mortel... Harry s'est donc fait tue, et l'Horcruxe est detruit... ~%")
          (format t "Le chemin parcouru par Harry Potter est ~a~%Harry Potter a obtenu les armes ~a et a detruit les horcruxes ~a ~%" cheminHarry armespossedeesHarry horcruxedetruitHarry)
          (format t "Le chemin parcouru par Voldemort est ~a~%Voldemort a obtenu les armes ~a et a detruit les horcruxes ~a ~%" cheminVdm armespossedeesVdm horcruxedetruitVdm)
          nil ; on renvoie nil pour arreter le processus recursif
         )
      
       (progn

	 (let ((horcruxeHarry (cadr (assoc pointdepartHarry horcruxesMap))) (horcruxeVdm (cadr (assoc pointdepartVdm horcruxesMap)))) ;on regarde si il y a un horcruxe
            (if (and horcruxeHarry (not (member horcruxeHarry horcruxedetruitHarry :test #'string=)) (not (member horcruxeHarry horcruxedetruitVdm :test #'string=)))
	 	(if (hasBonneArme horcruxeHarry armespossedeesHarry horcruxesDescription) ;si on a la bonne arme
	 		(progn 
	 			(push horcruxeHarry horcruxedetruitHarry) ;on ajoute l'horcruxe aux horcruxe detruits 
	 			(format t "Harry Potter a detruit l'horcruxe ~a avec ~a !~%" horcruxeHarry (methodeDestruction horcruxeHarry horcruxesDescription)) ;on affiche la destruction de l'horcruxe 
	 		)
	 		(format t "Il y a un horcruxe ici : ~a ! Mais... Harry Potter ne peux pas le detruire~%" horcruxeHarry) ;sinon on ne peux pas detruire l'horcruxe 
	 	)  
             )
            (if (and horcruxeVdm (not (member pointdepartVdm (cdr (reverse cheminVdm)))) (not (member horcruxeVdm horcruxedetruitHarry :test #'string=)) (not (member horcruxeVdm horcruxedetruitVdm :test #'string=)))
	 	(if (and (hasBonneArme horcruxeVdm armespossedeesVdm horcruxesDescription) (not (member pointdepartVdm cheminVdm))) ;si on a la bonne arme et que vdm est pour la 1ere fois ici
	 		(progn 
	 			(push horcruxeVdm horcruxedetruitVdm) ;on ajoute l'horcruxe aux horcruxe detruits 
	 			(format t "Voldemort a detruit l'horcruxe ~a avec ~a !~%" horcruxeVdm (methodeDestruction horcruxeVdm horcruxesDescription)) ;on affiche la destruction de l'horcruxe 
	 		)
	 		(format t "Il y a un horcruxe ici : ~a ! Mais... Voldemort ne peux pas le detruire~%" horcruxeVdm) ;sinon on ne peux pas detruire l'horcruxe 
	 	)  
             )
	  )
  
        (let (brancheActuelle caseVdm (successeursVdm (successeurs-valides pointdepartVdm carte nil)) (successeursHarry (successeurs-valides pointdepartHarry carte cheminHarry))) ;appel recursif sur les successeurs   
          (if (= profondeurMax 0) 
                    (format t "La profondeur maximale d'Harry a ete atteinte, on remonte !~%")
                    (if successeursHarry
			(dolist (succ successeursHarry)
                                (if (member succ (successeurs-valides pointdepartHarry carte cheminHarry)) ; on verifie que le successeur valide en est toujours un, car dans le cas ou deux branches se recroisent il se peut que le parcourt de la premiere branche avance dans la seconde et donc que etant deja  parcouruent, les successeurs ne soient plus correctes alors qui l'etaient avant le do-list 
                                    (progn
                                          (format t "Entrer la prochaine case de Voldemort parmis ~a (si invalide le premier sera choisi) :" successeursVdm)
                                          (setq caseVdm (read))
                                          (if (or (not (numberp caseVdm)) (not (member caseVdm successeursVdm)))
                                              (setq caseVdm (car successeursVdm)))
				          (setq brancheActuelle (exploreprofondeurVoldemort carte horcruxesDescription horcruxesMap armesMap (- profondeurMax 1) succ caseVdm cheminHarry cheminVdm horcruxedetruitHarry horcruxedetruitVdm armespossedeesHarry armespossedeesVdm))
                                          (if (eq brancheActuelle nil); si Harry a ete tue dans la branche
                                              (progn 
                                                (setq brancheActuelle 0); on defini branche actuelle comme un nombre pour revoyer nil si Harry est mort au lieu de la liste habituele a la fin de la fonction
                                                (return-from nil nil)))
                                          (format t "Harry retourne sur la case ~a, il ne peut donc plus interagir avec s'il restait un Horcruxe...~%" pointdepartHarry)
                                          (setq horcruxedetruitHarry (cadr (assoc 'horcruxesHarry brancheActuelle)))
                                          (setq armespossedeesHarry (cadr (assoc 'armesHarry brancheActuelle)))
                                          (setq cheminHarry (append (cadr (assoc 'cheminHarry brancheActuelle)) (list pointdepartHarry)))
                                          (setq horcruxedetruitVdm (cadr (assoc 'horcruxesVdm brancheActuelle)))
                                          (setq armespossedeesVdm (cadr (assoc 'armesVdm brancheActuelle)))
                                          (setq cheminVdm (cadr (assoc 'cheminVdm brancheActuelle)))
                                          (setq successeursVdm (successeurs-valides (car (last cheminVdm)) carte nil)); on met a nouveau a jour les successeurs de la position de Vdm caar il a change de case apres le passage dans la branche de Harry
                                    ) 
                                )
                        )
                    )
            )
          (format t "Le chemin parcouru par Harry Potter est ~a~%Harry Potter a obtenu les armes ~a et a detruit les horcruxes ~a ~%" cheminHarry armespossedeesHarry horcruxedetruitHarry)
          (format t "Le chemin parcouru par Voldemort est ~a~%Voldemort a obtenu les armes ~a et a detruit les horcruxes ~a ~%" cheminVdm armespossedeesVdm horcruxedetruitVdm)
          (if (numberp brancheActuelle)
              nil
              (list (list 'horcruxesHarry horcruxedetruitHarry) (list 'armesHarry armespossedeesHarry) (list 'cheminHarry cheminHarry) (list 'horcruxesVdm horcruxedetruitVdm) (list 'armesVdm armespossedeesVdm) (list 'cheminVdm cheminVdm)) ; on retourne ce qui est demande    
          )
          
        )	
      )  
   )
)

;Jeu de testes : (exploreprofondeurVoldemort carte description_horcruxes carte_horcruxe carte_armes profondeur_max depart_harry depart_Voldemort)

;(exploreprofondeurVoldemort carte horcruxesDescription horcruxesMap armesMap 7 1 32)
;(exploreprofondeurVoldemort carte horcruxesDescription horcruxesMap armesMap 11 1 32)
;(exploreprofondeurVoldemort carte horcruxesDescription horcruxesMap armesMap 7 22 32) ;verification de l'utilisation de sortilege de la mort par Voldemort



;============== Version creative =============

;Cette version permet de rendre la premiere version plus en adequation avec l'oeuvre de J.K. Rowling.
;Par consequent, Voldemort n'a plus l'objectif de detruire les horcruxes, les reliques de la mort ont ete rajoutees
;et des detraqueurs sont desormais presents. L'explication de cette nouvelle version seront detaillees dans le rapport.
;De plus, cette version utilise davantage de fonctions intermediaires pour faciliter la lecture et la comprehension. 

;============== Version creative - Fonctions Intermediaires =============


; estici (int list(list)) -> list
; renvoie la liste des element present sur la case d'apres la descrition Mapdescrition donnee
; exemple : (3 armesMap) renvoie ("Crochet de Basilic")

(defun estici (point Mapdescription)
	(cdr (assoc point Mapdescription)) ; attention c'est une liste 
)

;Jeu de testes
;(estici 8 horcruxesMap)
;(estici 25 armesMap)
;(estici 6 armesMap) ;pas d'arme sur la case 6. Dans ce cas renvoie NIL 




;nondejarecup (char list list) -> bool
;renvoie T si l'objet n'est pas dans les listes ListeObjetPerso1 ListeObjetPerso2 et nil sinon.
;exemple : ("Journal de Tom Jedusor" hocruxeHarry horcruxeVdm

(defun nondejarecup (Objet ListeObjetPerso1 ListeObjetPerso2)
	(if (and (not (member Objet ListeObjetPerso1 :test #'string=)) (not (member Objet ListeObjetPerso2 :test #'string=))) 
		T
		nil
	)
)

;Jeu de testes
;(nondejarecup (quote "Journal intime de Tom Jedusor") '("Nagini") '("Coupe de Helga Poufsouffle"))
;(nondejarecup (quote "Journal intime de Tom Jedusor") '("Journal intime de Tom Jedusor" "Nagini") '("Coupe de Helga Poufsouffle"))
;(nondejarecup (quote "Journal intime de Tom Jedusor") '("Nagini") '("Coupe de Helga Poufsouffle" "Journal intime de Tom Jedusor"))



;testearme (int, list, list, list(list) bool) -> list
; renvoie la liste des armes possede par un personnage ArmePersoActif apres qu'il ai recupere si possible les armes sur la case point.
; /!\ cette fonction prend en argument la liste des armes possede par le personnage actif : ArmePersoActif et par l'autre personnage ArmePersoAutre. 
;exemple : testearme (25 nil nil armesMap) renvoie ("Epee de Gryffondor")

(defun testearme(point ArmePersoActif ArmePersoAutre armesMap perso) ;perso = 0 :Harry et 1 (ou nombre diff de 0) :Vdm
	(let ((listearme (estici point armesMap)))
		(if listearme ;si la liste des armes est non vide 
			(dolist (arme listearme)
				(if (nondejarecup arme ArmePersoActif ArmePersoAutre)
				        (if (= perso 0) ;si c'est Harry, il peut recuperer toutes les armes
                                            (progn 
					           (format t "Harry a trouve l'arme : ~a ! ~%" arme)
					           (setq ArmePersoActif (append (list arme) ArmePersoActif)) ;si la/les armes sont encore sur la case, on ajoute.
					    )
                                            (if (string= arme "Sortilege de la Mort") ; si c'est Voldemort, il ne peut recuperer que "Sortilege de la Mort"
                                                (progn 
					           (format t "Voldemort a trouve l'arme : ~a ! ~%" arme)
					           (setq ArmePersoActif (append (list arme) ArmePersoActif)) ;si la/les armes sont encore sur la case, on ajoute.
					        )
                                                (format t "Voldemort est passe a cote de l'arme ~a mais ne sait pas qu'elle permet de detruire ses Horcruxes. ~%Harry pourra donc toujours la recuperer!~%" arme)
                                            )
                                        )
				)
			)
		  (format t "Il n'y a pas d'arme sur la case : ~a . ~%" point)
                 )
	)
	(format t "~a a en sa possession les armes : ~a . ~%" (if (= perso 0) "Harry" "Voldemort") ArmePersoActif)
	ArmePersoActif ;dans tout les cas on renvoie la liste des armes possedees
)

;Jeu de testes
;(testearme 25 '("Crochet de Basilic" ) '("Sortilege de la Mort") armesMap 0)
;(testearme 25 '("Sortilege de la Mort") '("Crochet de Basilic" ) armesMap 1)
;(testearme 25 '("Crochet de Basilic" ) '("Sortilege de la Mort" "Epee de Gryffondor") armesMap 0)
;(testearme 25 '("Crochet de Basilic" "Epee de Gryffondor") '("Sortilege de la Mort") armesMap 0)
;(testearme 6 '("Crochet de Basilic" ) '("Sortilege de la Mort") armesMap 0)
;(testearme 25 nil '("Sortilege de la Mort") armesMap 0)
;(testearme 20 nil nil armesMap 1)



;testehorcruxe (int, list, list, list, list, list(list), bool) -> list
;renvoie la liste des hocruxedetruit en rajoutant les horcruxes necessaires.
;Les prints necessaires sont deja inclus dans la fonction 

(defun testehorcruxe (point armespossedees horcruxedetruit_p1 horcruxedetruit_p2 chemin horcruxesMap perso); perso = 0 :Harry et 1 :Vdm (1 mais fonctionne aussi si nombre !=0)
	(let ((horcruxe (estici point horcruxesMap)))
		(if horcruxe
			(dolist (h horcruxe)
				(if (nondejarecup h horcruxedetruit_p1 horcruxedetruit_p2)
					(progn 
					    (format t "Il y a l'Horcruxe ~a sur cette case ! ~%" h)
                                            (if (= perso 0)   ;si c'est harry on test s'il peut detruire les horcruxes
						(if (and (hasBonneArme h armespossedees horcruxesDescription) (not (member point chemin)))
							(progn 
								(setq horcruxedetruit_p1 (append horcruxedetruit_p1 (list h)))
								(format t "Harry a detruit l'Horcruxe ~a ! ~%" h)
							)
							(format t "Mais Harry ne peut pas detruire l'Horcruxe ~a ... ~%" h)
						)
                                                (if (not (member point chemin)) ; cas ou c'est Voldemort (Pas besoin d'armes il recupere juste l'horcuxe pour eviter qu'il se fasse detruire par Harry)
							(progn 
								(setq horcruxedetruit_p1 (append horcruxedetruit_p1 (list h)))
								(format t "Voldemort a recupere l'Horcruxe ~a ! ~%" h)
							)
							(format t "Mais... Voldemort est deja passe par le !~%" )
						)
                                            )
					)
				)
			)
		)
	)
	(format t "Pour l'instant, ~a a ~a les horcruxes : ~a . ~%" (if (= perso 0) "Harry" "Voldemort") (if (= perso 0) "detruit" "recupere") horcruxedetruit_p1)
	horcruxedetruit_p1
)

;Jeu de testes
;(testehorcruxe 12 '("Epee de Gryffondor") nil nil '() horcruxesMap 0) ;destruction par Harry de Medaillon de Salazar Serpentard
;(testehorcruxe 12 '("Crochet de Basilic") nil nil '(1 3 7) horcruxesMap 0) ;pas la bonne arme pour detruire Medaillon de Salazar Serpentard
;(testehorcruxe 12 '("Epee de Gryffondor") '("Medaillon de Salazar Serpentard") nil '(1 3 7) horcruxesMap 1) ;Medaillon de Salazar Serpentard deja  recupere par Voldemort
;(testehorcruxe 12 '("Epee de Gryffondor")  nil '("Medaillon de Salazar Serpentard") '(1 3 7) horcruxesMap 1) ;Medaillon de Salazar Serpentard deja  detruit par Harry
;(testehorcruxe 12 '("Epee de Gryffondor") nil nil '(1 3 7 12) horcruxesMap 1) ;Medaillon de Salazar Serpentard ne peut etre dedruit car Voldemort est deja passe par la . 



;testerelique (int list list(list) int)
;teste en fonction du choix du personnage : 0: Harry et 1: Voldemort, les reliques recuperable par le personnage sur la case point.  
;renvoie alors les reliques possedees par le personnage avec ajout eventuel de reliques. 

(defun testerelique (point reliquespossedees reliqueMap perso) ;0 :Harry et 1 :Vdm
	(let ((reliques (estici point reliqueMap)))
		(if reliques
			(dolist (r reliques)
				(if (and (or (and (string= r "Pierre de resurrection") (nondejarecup "Pierre de resurrection" reliquespossedees nil)) (and (string= r "Cape d'invisibilite") (nondejarecup "Cape d'invisibilite" reliquespossedees nil)))  (eql perso 0)) 
					;teste de la cape et de la pierre de resurrection uniquement pour Harry Potter
					(progn 
						(format t "Harry Potter a trouve la relique : ~a ! ~%" r)
						(setq  reliquespossedees (append (list r) reliquespossedees))
						(format t "Harry a en sa possession les reliques : ~a . ~%" reliquespossedees)
					) 
				)
				(if (and (string= r "Baguette de sureau") (nondejarecup "Baguette de sureau" reliquespossedees nil) (eql perso 1)) ;La baguette, uniquement pour Voldemort
					(progn 
						(format t "Voldemort a trouve la relique : ~a ! ~%" r)
						(setq  reliquespossedees (append (list r) reliquespossedees))
						(format t "Voldemort a en sa possession les reliques : ~a . ~%" reliquespossedees)
					)
				)	
			)
		)
	)
	 
	(if (not (or (eql perso 0) (eql perso 1))) ;ligne d'erreur
		(format t "Argument perso invalide. Choisir 0 pour Harry ou 1 pour Voldemort")
		reliquespossedees ;si pas d'erreur on renvoie la liste des armes possedees
	)
)

;Jeu de testes :
;Pour rappel, la cape d'invisibilite est sur la case 36 et la baguette de sureau sur la case 6.

;(testerelique 6 nil reliqueMap 0)
;(testerelique 6 nil reliqueMap 1)
;(testerelique 6 '("Baguette de sureau") reliqueMap 1)

;(testerelique 36 '("Pierre de ressurrection") reliqueMap 0)
;(testerelique 36 nil reliqueMap 1)
;(testerelique 36 '("Cape d'invisibilite") reliqueMap 0)

;(testerelique 36 '("Cape d'invisibilite") reliqueMap 56)




;interaction_Harry_Vdm (int int list list list) -> bool
;renvoie nil si il ne ce passe rien
;renvoie T si Harry Potter est tue par Voldemort avec "Sortilege de la Mort"
;renvoie T si Voldemort est tue par la baguette de sureau apres avoir utilise "Sortilege de Mort"
;ainsi la partie continue si Voldemort ou Harry ne sont pas morts, c'est-a -dire si la fonction renvoie nil. Et s'arrete si la fonction renvoie T. 


(defun interaction_Harry_Vdm (posHarry posVdm reliqueHarry reliqueVdm armeVdm)
	(if (eql posHarry posVdm) ;est ce que Vdm et Harry se rencontre ? 
		(progn 
			(format t "Harry Potter et Voldemort se rencontre !!! ~%")

			(if (member (quote "Cape d'invisibilite") reliqueHarry :test #'string=) ;si Harry a la cape d'invisibilitee, il n'est pas visible par Vdm
				(progn 
					(format t "Harry se cache avec sa cape d'invisiblite ! ~%")
					nil ;il n'y a pas de mort, on renvoie nil
				 )
                                
				(if (member (quote "Sortilege de la Mort") armeVdm :test #'string=) ;sinon si Voldemort a le sortilege de mort 
					(progn 
						(format t "Avada Kedavra ! Voldemort lance sortilege de mort sur Harry Potter ! ~%") ;Il l'utilise sur Harry !
						(if (member (quote "Baguette de sureau") reliqueVdm :test #'string=) 
							(progn 
								(format t "La baguette de sureau retourne le sortilege de mort contre Voldemort ! ~%Voldemort est tres affaibli et est arrete pour etre jete dans la prison d'Azkaban. ~%La partie prend alors fin, dans un sentiment d'incertitude chez les sorciers, la crainte qu'un jour Voldemort parvienne a s'echapper de la prison et reprenne de sa puissance. ~%")
								T ;On return true pour arreter pouvoir arreter le programme. 
							)
							(progn 
								(format t "La lueure verte du sort traverse Harry Potter ! ~%Harry est tue par le sortilege et la partie prend fin. ~%")
								T
							)	
						)
					)
					(progn 
						(format t "Voldemort n'a pas recupere le sortilege de mort. Harry Potter s'enfuit ! ~%")
						nil
					)
				)
			)
		)
		nil ;si Harry et Vdm ne sont pas au meme point il n'y a pas de rencontre.
	)
)

;jeu de testes 
;(interaction_Harry_Vdm 2 3 nil nil nil) ;si Harry et Vdm ne sont pas sur la meme case
;(interaction_Harry_Vdm 3 3 '("Cape d'invisibilite") nil nil) ;si Harry a la cape d'invisibilite 
;(interaction_Harry_Vdm 3 3 nil nil '("Sortilege de Mort")) ;si Vdm a le sortilege de mort et pas la baguette de sureau
;(interaction_Harry_Vdm 3 3 nil '("Baguette de sureau") '("Sortilege de Mort")) ;si Vdm a le sortilege de mort et la baguette.
;(interaction_Harry_Vdm 3 3 nil '("Baguette de sureau") nil) 




;genere la position aleatoire d'un nombre donne de detraqueurs sur la carte. Ce nombre doit etre plus ffaible que le nombre de case libres sur la carte
;Si Harry rencontre un detraqueurs, il perd un tour le temps de lancer le sort de Patronus. 
;Voldemort n'est pas affecte par les detraqueurs car il ne ressent aucune emotion positive.
;Voldemort ne peut probablement pas lancer le sort de Patronus.

;initialisedetraqueurs(int list(list)) -> list
;renvoie une liste de la position d'un nombre donne de detraqueur, nombre doit etre inferieurs au nombre de case valide de la carte.
;les postions de chaques detraqueurs sont aleatoires et toutes differentes. 

(defun initialisedetraqueurs (nombre carte) 
     (if (and (numberp nombre) (listp carte))
	(let ((listeptslibres nil) (listedetraqueurs nil))
		(progn 
			(dolist (listepoint carte) ;recupere tout les points visitables avec 1 seule occurence.
				(dolist (point carte)				
						(setq listeptslibres (append point listeptslibres))
				)
			)
			(setq listeptslibres (remove-duplicates listeptslibres :test #'eql)) 
			(if (<= nombre (length listeptslibres))
				(dotimes (i nombre)
					(progn 
						(setq listedetraqueurs (append (list (elt listeptslibres (random (length listeptslibres)))) listedetraqueurs)) ;selection un element de listeptslibres et l'ajoute a listedetraqueurs
						(delete (car listedetraqueurs) listeptslibres :test #'eql) ;suprime l'element selectionne pour eviter de le tirer 2 fois. 
					)
				)
				(format t "~%Erreur : Le nombre de detraqueurs est plus grand que le nombre de case visitable. Veuillez choisir un nombre plus petit que ~a . ~%" (length listeptslibres))
			)
			listedetraqueurs
		)

	  ) ;recuperer la liste des points libres de la carte.
       (format t "~%Erreur dans un type d'entree"))
)

;jeu de testes

;(initialisedetraqueurs 5 carte)
;(initialisedetraqueurs 5 carte) ;c'est bien aleatoire
;(initialisedetraqueurs 10 carte) ;on peut selectioner un certain nombre
;(initialisedetraqueurs 50 carte) ;si il y a plus de detraqueurs que le nombre de case valides




;detraqueurici (int list) -> bool
;renvoie True si il y a un detraqueur sur la case point d'apres la liste des points sur lequels il y a des detraqueurs.
;exemple : (detraqueurici 10 (10 5 7)) renvoie True 

(defun detraqueurici (point detraqueursMap) 
	(if (member point detraqueursMap)
		(progn 
			(format t "Harry rencontre des detraqueurs !!! Il passe son tour pour lancer un sort de patronus~%")
			T
		)
		nil
	)
)

;jeu de testes
;(detraqueurici 25 '(25 29 21 27 7 12 3 2 22 32))
;(detraqueurici 0 '(25 29 21 27 7 12 3 2 22 32)) 


;============== Version creative - Fonction Principale =============

(defun exploration-main (carte horcruxesDescription horcruxesMap armesMap reliquesMap profondeurMax posHarry posVdm nombredetraqueurs &optional cheminHarry cheminVdm horcruxeHarry horcruxeVdm armesHarry armesVdm reliquesHarry reliquesVdm)
    
    ;intialisation ou deplacement aleatoire des detraqueurs initialisedetraqueurs (nombre carte)
    (format t "Les detraqueurs se deplacent aleatoirement sur la carte.~%")
    (let* ((emplacementDetraqueurs (initialisedetraqueurs nombredetraqueurs carte)) (detraqueurSurHarry (detraqueurici posHarry emplacementDetraqueurs)))
        (format t "En effet, les detraqueurs ont pris les positions ~a~%" emplacementDetraqueurs)
        (if (not detraqueurSurHarry)
            (progn 
                (setq cheminHarry (append cheminHarry (list posHarry))) ;ajout du point aux chemins
                (format t "Harry Potter est sur la case ~a, il a donc parcouru le chemin : ~a~%" posHarry cheminHarry)
            )
            (format t "Harry Potter est sur la case ~a, il a donc parcouru le chemin : ~a~%" posHarry (append cheminHarry (list posHarry))) ; on affiche le chemin sans le mettre e jour pour eviter les doublons lors du prochain appel recursif ou la position sera la meme
        )
        (setq cheminVdm (append cheminVdm (list posVdm))) ;ajout du point aux chemins
        (format t "Voldemort est sur la case ~a, il a donc parcouru le chemin : ~a~%" posVdm cheminVdm)
      
        ;recuperation arme testearme(point ArmePersoActif ArmePersoAutre armesMap)
        (if (not detraqueurSurHarry)
            (setq armesHarry (testearme posHarry armesHarry armesVdm armesMap 0))
        )
        (setq armesVdm (testearme posVdm armesVdm armesHarry armesMap 1))

        ;interaction Harry Vdm interaction_Harry_Vdm (posHarry posVdm reliqueHarry reliqueVdm armeVdm)

        (if (interaction_Harry_Vdm posHarry posVdm reliquesHarry reliquesVdm armesVdm) ;si mort (interaction_Harry_Vdm return T)
            (progn  ;fin du programme renvoyer 
                (format t "Le chemin parcouru par Harry Potter est ~a~%Harry Potter a obtenu les armes ~a et a detruit les horcruxes ~a ~%" (if detraqueurSurHarry (append cheminHarry (list posHarry)) cheminHarry) armesHarry horcruxeHarry)
                (format t "Le chemin parcouru par Voldemort est ~a~%Voldemort a cache les armes ~a et a recupere ses horcruxes ~a ~%" cheminVdm armesVdm horcruxeVdm)
                nil
            )
            (let (brancheActuelle caseVdm (successeursVdm (successeurs-valides posVdm carte nil)) (successeursHarry (if detraqueurSurHarry (list posHarry) (successeurs-valides posHarry carte cheminHarry)))); definition variable locale pour l'appel recursif
                ;recuperation reliques testerelique (point reliquespossedees reliquesMap perso) ;0 :Harry et 1 :Vdm
                (if (not detraqueurSurHarry)
                    (setq reliquesHarry (testerelique posHarry reliquesHarry reliquesMap 0))
                  )

                (setq reliquesVdm (testerelique posVdm reliquesVdm reliquesMap 1))

                ;recuperation horcurxe testehorcruxe (point armespossedees horcruxedetruit_p1 horcruxedetruit_p2 chemin horcruxesMap)
                
                (if (not detraqueurSurHarry)
                    (setq horcruxeHarry (testehorcruxe posHarry armesHarry horcruxeHarry horcruxeVdm cheminharry horcruxesMap 0))
                )
                (setq horcruxeVdm (testehorcruxe posVdm armesVdm horcruxeVdm horcruxeHarry (cdr (reverse cheminVdm)) horcruxesMap 1))
                ;effet de la relique "pierre de resurection"
                (if (and (not detraqueurSurHarry) (member "Pierre de resurrection" reliquesHarry :test #'string=))
                ; si Harry a la pierre de resurection il prend conseil des morts pour connaitres instantanemment l'emplacement d'un horcruxe au hasard qu'il peut detruire s'il detient l'arme necessaire et si ce dernier n'a pas deja ete detruit ou recupere avant.
                ; l'avantage est qu'il peur le faire e chaque tour et que le fait qu'il soit deja passe sur la case n'est pas pris en compte (s'il est passe sur une case avec un Horcruxes qu'il ne pouvait pas detruire sur le moment, il le pourra par la suite grece e la pierre et avec un peu de chance)
                ; le desavantage est que s'il n'a pas de chance il tombera sur des Horcruxes deja detruits ou recuperes
                    (let ((case (car (elt horcruxesMap (random (length horcruxesMap))))))
                        (format t "Harry utilise sa Pierre de Resurection !~%")
                        (format t "Les defuns lui indique qu'il y aurait possiblement quelque chose sur la case ~a !~%Harry s'y transplane instantanement pour verifier.~%" case)
                        (setq horcruxeHarry (testehorcruxe posHarry armesHarry horcruxeHarry horcruxeVdm nil horcruxesMap 0)) ; on ne met pas son chemin ici car il peut y retourner sans contrainte de cette maniere (il sait qu'il y a quelque chose donc il cherche alors qu'en temps normal il ne verifie plus)
                        (format t "Harry retourne sur sa case initiale pour continuer sa recherche~%")
                    )
                )
                (format t "Le chemin parcouru par Harry Potter est ~a~%Harry Potter a obtenu les armes ~a et a detruit les horcruxes ~a ~%" (if detraqueurSurHarry (append cheminHarry (list posHarry)) cheminHarry) armesHarry horcruxeHarry)
                (format t "Le chemin parcouru par Voldemort est ~a~%Voldemort a obtenu les armes ~a et a mis en securite les horcruxes ~a ~%" cheminVdm armesVdm horcruxeVdm)
                (if (and (not detraqueurSurHarry) (= profondeurMax 0))
                    (format t "La profondeur maximale d'Harry a ete atteinte, on remonte !~%")
                    (if successeursHarry
                        (dolist (succ successeursHarry)
                            (if (or detraqueurSurHarry (member succ (successeurs-valides posHarry carte cheminHarry))) ; on verifie que le successeur valide en est toujours un, car dans le cas ou deux branches se recroisent il se peut que le parcourt de la premiere branche avance dans la seconde et donc que etant deja parcouruent, les successeurs ne soient plus correctes alors qui l'etaient avant le do-list 
                                (progn
                                    (format t "Entrer la prochaine case de Voldemort parmis ~a (si invalide le premier sera choisi) :" successeursVdm)
                                    (setq caseVdm (read))
                                    (if (or (not (numberp caseVdm)) (not (member caseVdm successeursVdm)))
                                        (setq caseVdm (car successeursVdm)))
                                    (setq brancheActuelle (exploration-main carte horcruxesDescription horcruxesMap armesMap reliquesMap (if detraqueurSurHarry profondeurMax (- profondeurMax 1)) succ caseVdm (if detraqueurSurHarry (- nombredetraqueurs 1) nombredetraqueurs) cheminHarry cheminVdm horcruxeHarry horcruxeVdm armesHarry armesVdm reliquesHarry reliquesVdm))
                                    (if (eq brancheActuelle nil); si la partie s'est termine dans la branche
                                        (progn 
                                            (setq brancheActuelle 0); on defini branche actuelle comme un nombre pour revoyer nil si la partie est finie au lieu de la liste habituele e la fin de la fonction
                                            (return-from nil nil) ; on quitte le dolist car la partie est finie
                                        )
                                    )
                                    (if (not detraqueurSurHarry)
                                        (progn
                                            (format t "Harry retourne sur la case ~a, il ne peut donc plus interagir avec s'il restait un Horcruxe...~%" posHarry)
                                            (setq cheminHarry (append (cadr (assoc 'cheminHarry brancheActuelle)) (list posHarry)))
                                        )
                                        (setq cheminVdm (cadr (assoc 'cheminHarry brancheActuelle)))
                                    )
                                    (setq horcruxeHarry (cadr (assoc 'horcruxesHarry brancheActuelle)))
                                    (setq armesHarry (cadr (assoc 'armesHarry brancheActuelle)))
                                    (setq reliquesHarry (cadr (assoc 'reliquesHarry brancheActuelle)))
                                    (setq horcruxeVdm (cadr (assoc 'horcruxesVdm brancheActuelle)))
                                    (setq armesVdm (cadr (assoc 'armesVdm brancheActuelle)))
                                    (setq reliquesVdm (cadr (assoc 'reliquesVdm brancheActuelle)))
                                    (setq cheminVdm (cadr (assoc 'cheminVdm brancheActuelle)))
                                    (setq successeursVdm (successeurs-valides (car (last cheminVdm)) carte nil)); on met e nouveau e jour les successeurs de la position de Vdm car il a change de case apres le passage dans la branche de Harry
                                ) 
                            )
                        )
                    )
                )
                (if (numberp brancheActuelle)
                    nil
                    (list (list 'horcruxesHarry horcruxeHarry) (list 'armesHarry armesHarry) (list 'reliquesHarry reliquesHarry) (list 'cheminHarry cheminHarry) (list 'horcruxesVdm horcruxeVdm) (list 'armesVdm armesVdm) (list 'reliquesVdm reliquesVdm) (list 'cheminVdm cheminVdm)) ; on retourne ce qui est demande
                )    
            )
        )
    )
)


;(exploration-main carte horcruxesDescription horcruxesMap armesMap reliqueMap 7 1 32 5)
;(exploration-main carte horcruxesDescription horcruxesMap armesMap reliqueMap 7 36 32 5)

    








