#load 'HashiGrid.rb'
class Save
    #creer des noms de fichier contenant le nom du tableau(ex niveau_facile/save10x10.txt)
    def initialize
        nom_fic = new("save.txt","w")
    end

    #Methode ecrivant l'etat du tableau dans un fichier de sauvegarde
    def sauvegarder
        f = File.open("save.txt", "w")
        puts "Sauvegarde en cours!"
        for x in 0..(self.colonnes-1)
            for y in 0..(self.lignes-1)
                noeud = self.get_child_at(y,x)
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
                if(!(y==colonnes-1))
                    f.write(":")
                end
            end
            f.write("\n")
        end
        f.close
    end
end

#sauvegarde chrono a ajouter, ecraser la sauvegarde a chaque coup
#getTableau (in hashigame) pour separer la sauvegarde de hashi grid