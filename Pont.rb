require 'gtk3'

load "Ile.rb"

class Pont < Ile

    # Représente les différents types de pont. (0 = aucun bord, 1 = un pont, 2 = deux pont)
    attr_accessor :typePont

    # Représente la direction du pont. (0 = pas de pont, 1 = horizontal, 2 = vertical)
    attr_accessor :directionPont

    attr_accessor :stable

    # début du pont
    attr_accessor :debut

    # fin du pont
    attr_accessor :fin

    def initialize(grid, degree, col, lig ) 
        super(grid, degree, col, lig )
        @typePont = 0
        @directionPont = 0
        @suivant = -1
        @debut = -1
        @stable = false
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

    def set_stable(val)
        if !self.stable 
            self.stable = val
        end
    end

    #  Méthode mettant à jour un noeud
    # Il faudrait pouvoir factoriser
    def update()
       p "Type du pont: " + @typePont.to_s

        if @typePont == 0 && @directionPont == 0
            self.image.from_file= "image/noeuds/0.png"
        elsif @typePont == 1
            p "Direction du pont: " + @directionPont.to_s
            if @directionPont == 1
                if @stable 
                    self.image.from_file= "image/noeuds/h_simple.png"
                else
                    self.image.from_file= "image/noeuds/h_simple_v.png"
                end
            else
                if @stable 
                    self.image.from_file= "image/noeuds/v_simple.png"
                else
                    self.image.from_file= "image/noeuds/v_simple_v.png"
                end
                
            end
        elsif @typePont == 2 
            if @directionPont == 1
                if @stable 
                    self.image.from_file= "image/noeuds/h_double.png"
                else
                    self.image.from_file= "image/noeuds/h_double_v.png"
                end
            else
                if @stable
                    self.image.from_file= "image/noeuds/v_double.png"
                else
                    self.image.from_file= "image/noeuds/v_double_v.png"
                end
            end
        end
    end


end

