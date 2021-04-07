


class Sauvegarde  

    attr_accessor :undoStack

    attr_accessor :redoStack 


    def cleanAll
        @undoStack.clear
        @redoStack.clear
    end
    def initialize(nomniv,dif)
        @undoStack = Array.[]
        @redoStack = Array.[]
        @nomniv=nomniv
        @dif=dif
        titre = nomniv.match(/[^\/]*.txt/)
        @path = "./Sauvegarde/#{dif}/save#{titre}"
        File.open(@path, 'w')
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
        puts "Sauvegarde en cours!"

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

end