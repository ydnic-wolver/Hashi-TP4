require ('gtk3')

class Ile < Gtk::Button

    # Remplace le label du GTK::Button
    # Identifie une case comme étant un pont 'p'
    # ou une ile 'i'
    attr_accessor :status

    # Ligne de la case
    attr_accessor :row

    # Colonne de la case
    attr_accessor :column

    attr_accessor :debutPont
    
    attr_accessor :estComplet 

    attr_accessor :gridRef

    ##
    # Représente les nœuds auxquels ce nœud peut être connecté
    attr_accessor :northNode, :eastNode, :southNode, :westNode
    
    # Représente le statut d'une arête entre deux noeuds. 0 = pas d'arête, 1 = simple, 2 = double
    attr_accessor :northEdge, :eastEdge, :southEdge, :westEdge;

    # Représente le degrée max autorisé sur le noeuf 
    attr_reader :degreeMax

    # Représente le nombre de degrée restant à connecter avant d'atteindre le degree max
    attr_accessor :degree



    def compterVoisins() 
        liste = self.getVoisins()
        compteur = 0
        liste.each do |voisin|
            if voisin != nil
                compteur += 1
            end
        end
        # puts self.to_s + " VOISINS => " + compteur.to_s
        return compteur
    end


    def initialize(grid, degree, col, lig )
        super()
        @gridRef = grid
        
        @degreeMax = degree.to_i
        @degree = 0
        
        @row = lig

        @estComplet = false
        @column = col

        # Noeuds voisins permet de conserver la reference sur les voisins
        @northNode = nil
        @southNode = nil
        @eastNode = nil
        @westNode = nil

        # Permet de représenter le statut d'une arête entre chaque voisin
        @northEdge = 0;
		@eastEdge = 0;
		@southEdge = 0;
		@westEdge = 0;

        # Status représente une ile 
        self.status = 'i'
        
        # Charge une image correspondants au noeud
        self.image = Gtk::Image.new(:file => "Ressources/Ile/"+degree+".png") 
        #  Retire les contours
        self.set_relief(Gtk::ReliefStyle::NONE)
        self.always_show_image = false
        self.signal_connect('clicked') { self.click() }
    end


    # Calcule le nombres de ponts restants sur une ile
    def pontRestants
        compteur = 0
        compteur += @northEdge
        compteur += @eastEdge
        compteur += @southEdge
        compteur += @westEdge

        return compteur
    end

    def pontAvecVoisins
        liste = self.getVoisins()
        cmpPontRestants = self.pontRestants()
        
       return cmpPontRestants >= liste.size
    end


    
    def getVoisins
        arr = Array.new 
        if( @northNode != nil )
            arr.push(@northNode)
        end
        if( @eastNode != nil )
            arr.push(@eastNode)
        end
        if( @southNode != nil )
            arr.push(@southNode)
        end
        if( @westNode != nil )
            arr.push(@westNode)
        end
        return arr
    end

    # Retourne la liste des voisins non complets
    def voisinsNonComplets()
        liste = self.getVoisins()
        array = Array.new()

        liste.each do |voisin|
            if voisin.pontRestants() != 0
                array.push(voisin)
            end
        end
        return array
    end

    def compterVoisinsNonComplets
        return self.voisinsNonComplets().size
    end
    
    #  Décrémente le nombre de pont sur la case
    def dec
        @degree -= 1
        # puts @degree
    end

    def set_degree val
        # puts "Degres restant " + val.to_s
        @degree = val
    end

    #  Incrément le nombre de pont sur la case
    def inc
        @degree += 1
    end

    # Met à jour le noeud
    # - Si le noeud à un nombre de pont supérieur a son degree max, il est affiché en rouge
    # - Si le noeud comporte le bon nombre il s'affiche en vert
    # - Sinon il est blanc par défaut 
    def update 
        if @degree > @degreeMax
            self.estComplet = false
            self.image.from_file = "Ressources/Ile/#{degreeMax}_r.png"
        elsif @degree == @degreeMax
            self.estComplet = true
            self.image.from_file = "Ressources/Ile/#{degreeMax}_v.png"
        else
            self.image.from_file = "Ressources/Ile/#{degreeMax}.png"
            self.estComplet = false
        end
    end


    # Affiche la ligne et la colonne 
    def to_s
        return "[#{@row}-#{@column}]"
    end

    # Méthode de test afin de s'assurer du bon fonctionnement des clics
    def click()
        @gridRef.notify(self)
        
        self.pontAvecVoisins
        # puts "H #{@northNode} B #{@southNode} D #{@eastNode} G #{@westNode}"
    end

end
