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
        @degree = @degreeMax
        
        self.status = 'i'
        @northEdge = 0;
		@eastEdge = 0;
		@southEdge = 0;
		@westEdge = 0;

        self.image = Gtk::Image.new(:file => "image/noeuds/"+degree+".png") 
        self.set_relief(Gtk::ReliefStyle::NONE)
        self.always_show_image = false
        # self.image.show
       
        self.signal_connect('clicked') { self.click() }
    end
    

    def dec
        if @degree > 0
            @degree -= 1
           
        end
    end

    def update 
        if @degree == 0
            self.image.from_file = "image/noeuds/#{degreeMax}_v.png"
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
            @gridRef.afficheGauche(self, @westNode, false) 
            @gridRef.afficheDroit(self, @eastNode, false) 
            @gridRef.afficheHaut(self, @northNode, false) 
            @gridRef.afficheBas(self, @southNode, false) 
        end
        # Evenement pour la sortie de survol 
        self.signal_connect('leave-notify-event') do 
            @gridRef.supprimeGauche(self, @westNode) 
            @gridRef.supprimeDroit(self, @eastNode) 
            @gridRef.supprimeHaut(self, @northNode) 
            @gridRef.supprimeBas(self, @southNode) 
        end
    end
    
    # Méthode de test afin de s'assurer du bon fonctionnement des clics
    def click()
        # @gridRef.notifyNodes("Case #{@row}- #{@column}")
        @gridRef.notify(self)

        # if self.status == 'p'
        #     k = self.column
        #     s = self.row
        #     node = @gridRef.get_child_at(k,s)
        #     while node.status == 'p'
        #         node.image.hide()
        #         node.set_sensitive(false)
        #         k += 1
        #         node = @gridRef.get_child_at(k,s)
        #     end
        # end
        # p  "#{self.to_s} - degree = #{@degree}"

        puts " Haut: #{@northNode} - Gauche: #{@westNode} - Droit: #{@eastNode} -  Bas:#{@southNode} "
        
    end

    # Ajoute un pont entre un noeuf ( self ) et un autre 
    def addEdge(n2)

    end

    # Méthode permettant de s'assurer que le placement du pont est 
    # autorisé
    def isValidAdd(n1, n2)

        # if n1.getDegree() == 0 || n2.getDegree() == 0
        #     return false
        # end

        # if (n1.getNorthNode() != n2 && n1.getEastNode() != n2 && n1.getSouthNode() != n2 && n1.getWestNode() != n2) {
		# 	return false;
		# }
        
    end

end
