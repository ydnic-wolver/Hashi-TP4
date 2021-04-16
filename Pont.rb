require 'gtk3'

load "Ile.rb"

##
# Représentation des ponts du jeu 
##
class Pont < Ile

    # Représente les différents types de pont. (0 = aucun bord, 1 = un pont, 2 = deux pont)
    attr_accessor :typePont

    # Représente la direction du pont. (0 = pas de pont, 1 = horizontal, 2 = vertical)
    attr_accessor :directionPont

    # Attribut permettant de savoir si un pont est double ou non 
    attr_accessor :estDouble 

    # Constructeur d'un pont 
    # * +grid+ Référence sur la grille
    # * +col+ Référence sur la grille
    # * +lig+ Référence sur la grille
    def initialize(grid, col, lig ) 
        super(grid, '0', col, lig )
        @typePont = 0
        @estDouble = false
        @directionPont = 0

        self.set_name('pont')
        css_file = Gtk::CssProvider.new
        css_file.load(data: <<-CSS)
                @import url("css/plateau_style.css");
                CSS
        self.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        self.set_sensitive(false)  # Un pont n'est pas cliquable par défaut
        self.status = 'p'
    end

    # Retourne la direction du pont
    def get_directionPont
        return @directionPont
    end

     # Modifie la direction du pont
    def set_directionPont(val)
        @directionPont = val
    end

    # Modifie le type du pont
    def set_typePont(val)
        if val >= 0
            @typePont = val
        else 
            @typePont = 0
        end
    end
    
     # Retourne le type du pont
    def get_typePont
        return @typePont
    end

   
    #  Méthode responsable de la mise à jour d'un pont.
    def update()
        
        if @typePont == 0 && @directionPont == 0
            self.image.from_file= "Ressources/Pont/0.png"
        elsif @typePont == 1
            # Si le pont == 1 alors il est horizontal
            # Sinon il est vertical 
            if @directionPont == 1
                 self.image.from_file= "Ressources/Pont/h_simple.png"
            else
                self.image.from_file= "Ressources/Pont/v_simple.png"
            end
        elsif @typePont == 2 
            if @directionPont == 1
                self.image.from_file= "Ressources/Pont/h_double.png"
            else
                self.image.from_file= "Ressources/Pont/v_double.png"
               
            end
        end
    end


end

