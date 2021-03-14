require ('gtk3')

class Noeud < Gtk::Button

    # Remplace le label du GTK::Button
    # Identifie une case comme étant un pont 'p'
    # ou une ile 'i'
    attr_accessor :status

    # Ligne de la case
    attr_accessor :row

    # Colonne de la case
    attr_accessor :column

    attr_accessor :debutPont

    

    ##
    # Représente les nœuds auxquels ce nœud peut être connecté
    attr_accessor :northNode, :eastNode, :southNode, :westNode
    
    # Représente le statut d'une arête entre deux noeuds. 0 = pas d'arête, 1 = simple, 2 = double
    attr_accessor :northEdge, :eastEdge, :southEdge, :westEdge;

    # Représente le degrée max autorisé sur le noeuf 
    attr_reader :degreeMax

    # Représente le nombre de degrée restant à connecter avant d'atteindre le degree max
    attr_accessor :degree

    attr_accessor :pontList


    def initialize(grid, degree, col, lig )
        super()
        @degreeMax = degree.to_i
        @row = lig
        @gridRef = grid
        @column = col
        @pontList = Array.[]
        # self.label = degree
        @degree = 0
        
        self.status = 'i'
        @northEdge = 0;
		@eastEdge = 0;
		@southEdge = 0;
		@westEdge = 0;

        self.image = Gtk::Image.new(:file => "image/noeuds/"+degree+".png") 
        self.set_relief(Gtk::ReliefStyle::NONE)
        self.always_show_image = false
        self.signal_connect('clicked') { self.click() }
    end
    

    def dec
        @degree = 0
    end

    def inc
        @degree += 1
    end

    def update 
        puts "degree => " + @degree.to_s
        if @degree > @degreeMax
           
            self.image.from_file = "image/noeuds/#{degreeMax}_r.png"
        elsif @degree == @degreeMax
            p "DEGREE =="
            self.image.from_file = "image/noeuds/#{degreeMax}_v.png"
        else
            self.image.from_file = "image/noeuds/#{degreeMax}.png"
        end
    end

    

    # Charge les voisins accessibles d'une case en HAUT, BAS, GAUCHE, DROITE
  
    # Affiche la ligne et la colonne 
    def to_s
        return "[#{@row}-#{@column}]"
    end

    # Attache une référence sur la grille
    def attach(grid)
       @gridRef = grid
    end
    
    def hover 
        # Evenement pour le survol 
        self.signal_connect('enter-notify-event') do 
        end
        # Evenement pour la sortie de survol 
        self.signal_connect('leave-notify-event') do 
        end
    end
    
    # Méthode de test afin de s'assurer du bon fonctionnement des clics
    def click()
        @gridRef.notify(self)
        
    end

end
