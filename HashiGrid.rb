require 'gtk3'


# Cette classe représente la grille
# contenant les boutons ( autrement dit les noeuds , et les
#  ponts d'un point de vue graphique )
# Il y  à peu de méthode encore mais ça arrive
class HashiGrid < Gtk::Grid 
    
    # Nombre de colonnes 
    attr_accessor :colonnes
    
    # Représente le noeud precedemment clique
    attr_accessor :prev 
    
    # Nombre de lignes
    attr_accessor :lignes

    def initialize
        super()
        @prev = []
    end

    def notifyClick() 



        if( @prev.length == 2)
            prev = @prev.slice!(0)
            nex = @prev.slice!(0)
            nex.update(prev)
                # @observers.each{ |_observer| _observer.update( prev ) }
        end
    end

    def set_lignes(val)
        p val
        @lignes = val
        return
    end

    def get_lignes()
        @self.lignes
    end

    def set_colonnes(val)
        p val
        @colonnes = val
        return
    end

    def get_colonnes()
        @self.colonnes
        
    end

    # Méthode permettant de s'assurer 
    # du bon lien entre la grille et une case 
    def notify(message)

        if ( @prev.last.column != message.column  &&  @prev.last.lignes != message.lignes )
            p "PAS VOISIN"
        end



        @prev << message
        notifyClick()
       
    end

      # Charge les voisins accessibles d'une case en HAUT, BAS, GAUCHE, DROITE
      
        # k = self.column + 1 # DROITE
        # while k <= 6
        #     newCase = @gridRef.get_child_at(k,self.row)
        #     if newCase.status == 'i' && newCase.column != @column
        #         @eastNode = newCase
        #         break;
        #     end
        #     k +=1
        # end

        # k = self.row + 1  #BAS
        # while k <= 6 
        #     newCase = @gridRef.get_child_at(self.column,k)
        #     if newCase.status == 'i' && newCase.row != @row
        #         @southNode = newCase
        #         break;
        #     end
        #     k +=1
        # end

        # k = self.row - 1  #HAUT
        # while k >= 0
        #     newCase = @gridRef.get_child_at(self.column,k)
        #     if newCase.status == 'i' && newCase.row != @row
        #         @northNode = newCase

        #         break;
        #     end
        #     k -=1
        # end

        # k = self.column - 1  #GAUCHE
        # while k >= 0
        #     newCase = @gridRef.get_child_at(k,self.row)
        #     if newCase.status == 'i' && newCase.column != @column
        #         @westNode = newCase
        #         break;
        #     end
        #     k -=1
        # end

    # end

    def get_child(ligne, colonne)
        return self.get_child_at(colonne, ligne)
    end
    

end