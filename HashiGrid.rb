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

    # Méthode permettant de s'assurer 
    # du bon lien entre la grille et une case 
    def notify(message)
        puts message
    end

end