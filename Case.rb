require ('gtk3')

class Case < Gtk::Button

    # Remplace le label du GTK::Button
    # Identifie une case comme étant un pont 'p'
    # ou une ile 'i'
    attr_accessor :status

    # Ligne de la case
    attr_accessor :row

    # Colonne de la case
    attr_accessor :column

    ##
    # Représente les nœuds auxquels ce nœud peut être connecté
    attr_accessor :northNode, :eastNode, :southNode, :westNode
    
    # Représente le statut d'une arête entre deux noeuds. 0 = pas d'arête, 1 = simple, 2 = double
    attr_accessor :northEdge, :eastEdge, :southEdge, :westEdge;

    # Représente le degrée max autorisé sur le noeuf 
    attr_reader :degreeMax

    # Représente le nombre de degrée restant à connecter avant d'atteindre le degree max
    attr_reader :degree


    def initialize(degree, col, lig )
        super()
        @degreeMax = degree.to_i
        @row = lig
        @column = col
        # self.label = degree
        self.status = 'p'
        self.image = Gtk::Image.new(:file => "image/noeuds/"+degree+".png") 
        self.set_relief(Gtk::ReliefStyle::NONE)
        self.always_show_image = true
       
        self.signal_connect('clicked') { self.click() }
    end

    # Charge les voisins accessibles d'une case en HAUT, BAS, GAUCHE, DROITE
    def loadNeighbours
        
        k = self.column + 1 # DROITE
        while k <= 6
            newCase = @gridRef.get_child_at(k,self.row)
            if newCase.status == 'r'
                @eastNode = newCase
                break;
            end
            k +=1
        end

        k = self.row + 1  #BAS
        while k <= 6 
            newCase = @gridRef.get_child_at(self.column,k)
            if newCase.status == 'r'
                @southNode = newCase
                break;
            end
            k +=1
        end

        k = self.row - 1  #HAUT
        while k >= 0
            newCase = @gridRef.get_child_at(self.column,k)
            if newCase.status == 'r'
                @northNode = newCase
                break;
            end
            k -=1
        end

        k = self.row - 1  #GAUCHE
        while k >= 0
            newCase = @gridRef.get_child_at(k,self.row)
            if newCase.status == 'r'
                @westNode = newCase
                break;
            end
            k -=1
        end

    end

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
        @gridRef.notify("Case #{@row}- #{@column}")
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
