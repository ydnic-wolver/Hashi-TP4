require 'gtk3'


# Cette classe représente la grille
# contenant les boutons ( autrement dit les noeuds , et les
#  ponts d'un point de vue graphique )
# Il y  à peu de méthode encore mais ça arrive
class HashiGrid < Gtk::Grid 
    
    # Nombre de colonnes 
    attr_accessor :colonnes
    
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

    # Méthode permettant de s'assurer 
    # du bon lien entre la grille et une case 
    def notify(message)
        @prev << message
        notifyClick()
       
    end


end