require 'gtk3'

load "Noeud.rb"

class Pont < Noeud

    # Représente les différents types de pont. (0 = aucun bord, 1 = un pont, 2 = deux pont)
    attr_accessor :typePont

    # Représente la direction du pont. (0 = pas de pont, 1 = horizontal, 2 = vertical)
    attr_accessor :directionPont

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
        self.set_sensitive(false)  # Un pont n'est pas cliquable par défaut
        self.status = 'p'

    end


    def get_directionPont
        return @directionPont
    end

    def set_typePont(val)
        
        @typePont = val
    end
    
    def get_typePont
        return typePont
    end

    def set_directionPont(val)
        @directionPont = val
    end

    def update()
       p "Type du pont: " + @typePont.to_s

        if @typePont == 0 && @directionPont == 0
            self.image.from_file= "image/noeuds/0.png"
        elsif @typePont == 1
            p "Direction du pont: " + @directionPont.to_s
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

    def affecter(suite)
        if @debut != -1
            p suite
            @suivant = suite
        elsif 
            @debut = suite
            p @debut
        end
    end

    def afficher()
		puts "#{@valeur}"
		if suivant != -1
			@suivant.afficher()
		end
	end

    # Ajoute un pont
    def ajoutePont(c1, c2)


    end

    # Supprime un pont
    def supprimePont
        
    end

    

end

