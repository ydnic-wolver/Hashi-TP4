require 'gtk3'

load "Ile.rb"

class Pont < Ile

    # Représente les différents types de pont. (0 = aucun bord, 1 = un pont, 2 = deux pont)
    attr_accessor :typePont

    # Représente la direction du pont. (0 = pas de pont, 1 = horizontal, 2 = vertical)
    attr_accessor :directionPont

    attr_accessor :stable

    attr_accessor :estDouble 

    # début du pont
    attr_accessor :debut

    # fin du pont
    attr_accessor :fin

    def initialize(grid, degree, col, lig ) 
        super(grid, degree, col, lig )
        @typePont = 0
        @estDouble = false
        @directionPont = 0
        self.set_sensitive(false)  # Un pont n'est pas cliquable par défaut
        self.status = 'p'
    end

    def get_directionPont
        return @directionPont
    end

    def set_typePont(val)
        if val >= 0
            @typePont = val
        end
    end
    
    def get_typePont
        return typePont
    end

    def set_directionPont(val)
        @directionPont = val
    end

    #  Méthode mettant à jour un noeud
    # Il faudrait pouvoir factoriser
    # En fonction du type de ponts des images différentes sont charger
    #  stable serait potentielle utiliser pour le survol ( mais pas sûr  c'est très chiant à implémenter comme feature )
    # d
    def update()
    #    p "Type du pont: " + @typePont.to_s # DEBUG
        if @typePont == 0 && @directionPont == 0
            self.image.from_file= "image/noeuds/0.png"
        elsif @typePont == 1
            # Si le pont == 1 alors il est horizontal
            # Sinon il est vertical 
            if @directionPont == 1
                 self.image.from_file= "image/noeuds/h_simple.png"
            else
                self.image.from_file= "image/noeuds/v_simple.png"
            end
        elsif @typePont == 2 
            if @directionPont == 1
                self.image.from_file= "image/noeuds/h_double.png"
            else
                self.image.from_file= "image/noeuds/v_double.png"
               
            end
        end
    end


end

