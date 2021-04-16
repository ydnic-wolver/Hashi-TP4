
##
# Cette classe est responsable de la sauvegarde
# Elle gère celle du classement et également de la grille
##
class Sauvegarde  

    # Création d'une sauvegarde
    def initialize(nomniv,dif)
        @nomniv=nomniv
        @dif=dif
        titre = nomniv.match(/[^\/]*.txt/)
        @path = "./Sauvegarde/#{dif}/save#{titre}"
    end
    
    # Sauvegarde de l'etat de la grille 
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
        f.write($tempsFin)
        f.close
    end

    # Sauvegarde des informations du joueur pour le classement
    def Sauvegarde.saveTime(nomGrille,difficulte,chrono, nom)
        titre = nomGrille.match(/[^\/]*.txt/)
        puts "CHRONO" + chrono.to_s
        file = File.open("./Classement/#{difficulte}/#{titre}", 'a')
        file.write("#{chrono}:#{nom}\n")
        file.close
    end

    # Chargement d'une sauvegarde
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
        puts saveTab[grille.lignes][0]
        $tempsPause = saveTab[grille.lignes][0]
    end

end