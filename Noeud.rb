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

    ##
    # Représente les nœuds auxquels ce nœud peut être connecté
    attr_accessor :northNode, :eastNode, :southNode, :westNode
    
    # Représente le statut d'une arête entre deux noeuds. 0 = pas d'arête, 1 = simple, 2 = double
    attr_accessor :northEdge, :eastEdge, :southEdge, :westEdge;

    # Représente le degrée max autorisé sur le noeuf 
    attr_reader :degreeMax

    # Représente le nombre de degrée restant à connecter avant d'atteindre le degree max
    attr_accessor :degree


    def initialize(grid, degree, col, lig )
        super()
        @degreeMax = degree.to_i
        @row = lig
        @gridRef = grid
        @column = col
        # self.label = degree
        @degree = 0
        if( degree == '0')
            self.set_sensitive(false)
            self.status = 'p'
        else
            self.status = 'i'
        end

        self.image = Gtk::Image.new(:file => "image/noeuds/"+degree+".png") 
        self.set_relief(Gtk::ReliefStyle::NONE)
        self.always_show_image = true
        self.image.show
       
        self.signal_connect('clicked') { self.click() }
    end

    

    # Charge les voisins accessibles d'une case en HAUT, BAS, GAUCHE, DROITE
    def loadNeighbours
        
        # DROITE
        for x2 in (@column+1).upto(@gridRef.lignes-1)
            if (@gridRef.get_child_at(x2, self.row).status == 'i')
                @eastNode = @gridRef.get_child_at(x2,self.row)
                break
            end
        end

        #BAS
        for y2 in (@row+1).upto(@gridRef.colonnes-1)
            if (@gridRef.get_child_at(self.column,y2).status == 'i')
                @southNode = @gridRef.get_child_at(self.column,y2)
                break
            end
        end
        
        #HAUT
        for y2 in (@row-1).downto(0)
            if (@gridRef.get_child_at(self.column,y2).status == 'i')
                @northNode = @gridRef.get_child_at(self.column,y2)
                break
            end
        end

        # Gauche
        for x2 in (@column-1).downto(0)
            if (@gridRef.get_child_at(x2,self.row).status == 'i')
                @westNode = @gridRef.get_child_at(x2,self.row)
                break
            end
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
        p  "#{self.to_s} - degree = #{@degree}"

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

    def update(subject)
        
        puts "Prececent : " + subject.to_s + " Actuel: " + self.to_s
        # je regarde si le noeud cliquer fait parti de mes voisins 
        # si oui je dessine un pont si non vtf
        if subject == @eastNode  # voisin de droite

           
            for i in (@column+1)..(subject.column-1) do
                @gridRef.get_child_at(i, self.row ).image.from_file= "image/noeuds/h_simple.png";
                @gridRef.get_child_at(i, self.row).image.show 
                @gridRef.get_child_at(i, self.row ).set_sensitive(true)
            end

            subject.degree += 1
            self.degree += 1

            if subject.degreeMax == subject.degree
                subject.image.from_file = 'image/noeuds/1_v.png'
            end

            
        elsif subject == @westNode # voisin de gauche
 
        elsif subject == @northNode # voisin de haut

        elsif subject == @southNode # voisin de bas

        end



    end

end
