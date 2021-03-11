require 'gtk3'

class Pont < Gtk::Button

    # Représente les différents types de pont. (0 = aucun bord, 1 = un pont, 2 = deux pont)
    attr_accessor :typePont

    # Représente la direction du pont. (0 = pas de pont, 1 = horizontal, 2 = vertical)
    attr_accessor :directionPont

    # début du pont
    attr_accessor :debut

    # fin du pont
    attr_accessor :fin

    def initialize() 
        @typePont = 0
        @directionPont = 0
        
        self.set_sensitive(false)  # Un pont n'est pas cliquable par défaut
        self.status = 'p'

    end

    # Ajoute un pont
    def ajoutePont(c1, c2)


    end

    # Supprime un pont
    def supprimePont
        
    end

end