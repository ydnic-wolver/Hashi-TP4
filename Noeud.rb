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

    def updateNode 
        if @degree == 0
            self.image.from_file = 'image/noeuds/1_v.png'
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

    def update(subject)
        
        puts "Prececent : " + subject.to_s + " Actuel: " + self.to_s
        arr = []
    
    
        # je regarde si le noeud cliquer fait parti de mes voisins 
        # si oui je dessine un pont si non vtf
        if subject == @eastNode  # voisin de droite
    
            p "VOISIN DROITE"
            i = @column + 1
                while i <= subject.column-1
                  pont = @gridRef.get_child_at(i, self.row )
                  p pont.to_s 
                #   arr << pont 
                  i += 1
             end
    
            # if( @pontList.include?(arr) &&  @eastNode.include?(arr))
            #     # subject.pontList.each { |x| x.each { 
            #     #     | y |  y.image.from_file= "image/noeuds/h_simple.png"
            #     #     } }
            #     p "PARTAGE"
            #     # subject.pontList[0].each{| y |  y.image.from_file= "image/noeuds/0.png"}
            #     # subject.pontList.delete_at(0)
            #     # @pontList.delete_at(0)
            # elsif @eastNode.include?(arr) ||  @pontList.include?(arr)
            #     p "ONE"
            # else 
            #     p "NONE"
            #     @pontList << arr 
            #     @eastNode.pontList << arr
            #     @eastNode.pontList[0].each{| y |  y.image.from_file= "image/noeuds/h_simple.png"}
            # end
            
        elsif subject == @westNode # voisin de gauche
            p "VOISIN GAUCHE"
    
            # i = @column - 1  #GAUCHE
            # while i > subject.column
            #     pont = @gridRef.get_child_at(i,self.row)
            #     p pont.to_s 
            #     i -=1
            # end
    
            # i = @column + 1
            #     while i <= subject.column-1
            #       pont = @gridRef.get_child_at(i, self.row )
            #       arr << pont 
            #       i += 1
            #     end
            #         # if pont.image.visible? 
            #         #     pont.image.from_file= "image/noeuds/h_simple.png";
            #         #     pont.image.show
            #         # else 
            #         #     p "nON VISIBLE"
            #         #     pont.image.from_file= "image/noeuds/0.png";
            #         #     pont.image.hide
            #         # end
            #         # pont.set_sensitive(true)
              
            # if( @pontList.include?(arr) &&  @westNode.include?(arr))
            #     # subject.pontList.each { |x| x.each { 
            #     #     | y |  y.image.from_file= "image/noeuds/h_simple.png"
            #     #     } }
            #     p "PARTAGE"
            #     # subject.pontList[0].each{| y |  y.image.from_file= "image/noeuds/0.png"}
            #     # subject.pontList.delete_at(0)
            #     # @pontList.delete_at(0)
            
            # elsif @westNode.include?(arr) ||  @pontList.include?(arr)
            #     p "ONE"
            # else 
            #     p "NONE"
            #     @pontList << arr 
            #     @westNode.pontList << arr
            #     # subject.pontList << arr
            #     @westNode.pontList[0].each{| y |  y.image.from_file= "image/noeuds/h_simple.png"}
            # end
    
           
    
        elsif subject == @northNode # voisin de haut
            p "VOISIN HAUT"
        elsif subject == @southNode # voisin de bas
            p "VOISIN BAS"
        end
    
    
       
       
    
    # for i in (@column+1).downto(subject.column-1) do    end
    
    subject.degree += 1
    self.degree += 1
    
    if subject.degreeMax == subject.degree
        subject.image.from_file = 'image/noeuds/1_v.png'
    end
    
    end
    

end
