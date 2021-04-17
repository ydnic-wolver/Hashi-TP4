
##
# Cette classe est responsable de la sauvegarde
# Elle gère celle du classement et également de la grille
##
class Sauvegarde  

    # @nomniv      -> Le nom du niveau pour enregistrer le fichier de sauvegarde
    # @dif         -> La difficulté du niveau pour savoir ou sauvegarder le fichier
    # @path        -> Le chemin d'accès pour sauvegarder



    # Création d'une sauvegarde
    # * +nomniv+ le nom du niveau pour enregistrer le fichier de sauvegarde
    # * +dif+ la difficulté du niveau pour savoir ou sauvegarder le fichier
    def initialize(nomniv,dif)
        @nomniv=nomniv
        @dif=dif
        titre = nomniv.match(/[^\/]*.txt/)
        @path = "./Sauvegarde/#{dif}/save#{titre}"
    end
    
    # Sauvegarde de l'etat de la grille 
    # * +grille+ la grille a sauvegarder
    def sauvegarder(grille)

        f=File.open(@path, 'w')
        
        for x in 0..(grille.colonnes-1)
            for y in 0..(grille.lignes-1)
                noeud = grille.get_child_at(y,x)
                if (noeud.status == "i")
                    f.write(noeud.degreeMax)
                elsif (noeud.status == "p")
                    if (noeud.typePont == 1 && noeud.directionPont == 1)
                        f.write("-")
                    elsif (noeud.typePont == 1 && noeud.directionPont == 2)
                        f.write("I")
                    elsif (noeud.typePont == 2 && noeud.directionPont == 1)
                        f.write("=")
                    elsif(noeud.typePont == 2 && noeud.directionPont == 2)
                        f.write("H")
                    else
                        f.write("0")
                    end
                end
                f.write(":")
                
            end
            f.write("\n")
        end
        f.write($tempssec)
        f.close
    end

    # Sauvegarde des informations du joueur pour le classement
    # * +nomGrille+ le nom du niveau pour savoir comment appeler le fichier
    # * +difficulte+ la difficulté du niveau pour savoir ou sauvegarder le fichier
    # * +chrono+ le chrono de l'utilisateur
    # * +nom+ le nom de l'utilisateur
    def Sauvegarde.saveTime(nomGrille,difficulte,chrono, nom)
        titre = nomGrille.match(/[^\/]*.txt/)
        file = File.open("./Classement/#{difficulte}/#{titre}", 'a')
        file.write("#{chrono}:#{nom}\n")
        file.close
    end

    # Chargement d'une sauvegarde
    # * +grille+ la grille du niveau pour l'initialiser avec le contenu du fichier
    # * +dif+ le nom du niveau pour savoir quel fichier charger
    # * +dif+ la difficulté du niveau pour savoir ou charger le fichier
    def Sauvegarde.charge(grille, nomniv,dif)
        titre = nomniv.match(/[^\/]*.txt/)
        #sauvegarde devient un tableau
        saveTab = File.readlines("./Sauvegarde/#{dif}/save#{titre}").map { |str| str.split(":") }
        
        for x in 0..(grille.lignes-1)
            for y in 0..(grille.colonnes-1)
                noeud = grille.get_child_at(y,x)
                if ( noeud.status == 'i')
                    if(noeud.eastNode != nil)
                        if (saveTab[x][y+1] == '-')
                            grille.ajoutPont(noeud, noeud.eastNode)
                        elsif (saveTab[x][y+1] == '=')
                            grille.ajoutPont(noeud, noeud.eastNode)
                            grille.ajoutPont(noeud, noeud.eastNode)
                        end
                    end
                    if(noeud.southNode != nil)
                        if (saveTab[x+1][y] == "I")
                            grille.ajoutPont(noeud, noeud.southNode)
                        elsif (saveTab[x+1][y] == 'H')
                            grille.ajoutPont(noeud, noeud.southNode)
                            grille.ajoutPont(noeud, noeud.southNode)
                        end
                    end
                end
            end
        end
        saveTab[grille.lignes][0].to_i
    end

end