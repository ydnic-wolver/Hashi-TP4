require 'gtk3'


# Cette classe représente la grille
# contenant les boutons ( autrement dit les noeuds , et les
#  ponts d'un point de vue graphique )
# Il y  à peu de méthode encore mais ça arrive
class HashiGrid < Gtk::Grid 
    
    # Nombre de colonnes 
    attr_accessor :colonnes
    
    # Nombre de lignes
    attr_accessor :lignes

    def initialize
        super()
    end


end