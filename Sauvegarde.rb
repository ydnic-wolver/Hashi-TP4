


class Sauvegarde  

    attr_accessor :undoStack

    attr_accessor :redoStack 


    def cleanAll
        @undoStack.clear
        @redoStack.clear
    end
    def initialize
        @undoStack = Array.[]
        @redoStack = Array.[]
    end

    def saveUserClick(action)
        @undoStack << action
    end

    def showUndoStack
        @undoStack.each do |el| 
            puts el.to_s
        end
    end

    def undoUserAction(action)
        @undoStack.pop!()
    end

    def undoEmpty?
        return @undoStack.empty? 
    end

    def sauvegarder(grille)
        f = File.open("save.txt", "w")
        puts "Sauvegarde en cours!"
        
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
    def chargeSauvegarde(grille)
        puts "chargement en cours..."

        #sauvegarde devient un tableau
        saveTab = File.readlines("save.txt").map { |str| str.split(":") }

        for x in 0..(grille.lignes-1)
            for y in 0..(grille.colonnes-1)
                noeud = grille.get_child_at(y,x)
                if ( noeud.status == 'i')
                    if(noeud.eastNode != nil)
                        if (saveTab[x][y+1] == '-')
                            ajoutPont(noeud, noeud.eastNode)
                        elsif (saveTab[x][y+1] == '=')
                            ajoutPont(noeud, noeud.eastNode)
                            ajoutPont(noeud, noeud.eastNode)
                        end
                    end
                    if(noeud.southNode != nil)
                        if (saveTab[x+1][y] == "I")
                            ajoutPont(noeud, noeud.southNode)
                        elsif (saveTab[x+1][y] == 'H')
                            ajoutPont(noeud, noeud.southNode)
                            ajoutPont(noeud, noeud.southNode)
                        end
                    end
                end
            end      
        end
        return saveTab[lignes][0]

    end
end