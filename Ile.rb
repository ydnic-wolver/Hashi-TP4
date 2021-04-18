require ('gtk3')


##
# Cette classe représente les îles
class Ile < Gtk::Button

    # @gridRef     -> Référence sur la grille 
    # @degreeMax   -> Représente le degrée max autorisé sur le noeud
    # @degree      -> Représente le nombre de degrée restant à connecter avant d'atteindre le degree max
    # @row         -> Numéro de ligne
    # @estComplet  -> Attribut permettant de savoir si l'ile est complète ou non
    # @column      -> Numéro de colonne
    # @northNode   -> Noeud voisin au nord
    # @eastNode    -> Noeud voisin à l'est
    # @southNode   -> Noeud voisin au sud
    # @westNode    -> Noeud voisin à l'ouest
    # @northEdge   -> Statut de l'arête nord entre deux noeuds
    # @eastEdge    -> Statut de l'arête est entre deux noeuds
    # @southEdge   -> Statut de l'arête sud entre deux noeuds
    # @westEdge    -> Statut de l'arête ouest entre deux noeuds

    # Remplace le label du GTK::Button
    # Identifie une case comme étant un pont 'p'
    # ou une ile 'i'
    attr_accessor :status

    # Numéro de ligne
    attr_accessor :row

    # Numéro de colonne
    attr_accessor :column

    # Attribut permettant de savoir si l'ile est complète ou non
    attr_accessor :estComplet 

    # Référence sur la grille 
    attr_accessor :gridRef
    
    # Représente les nœuds auxquels ce nœud peut être connecté
    attr_accessor :northNode, :eastNode, :southNode, :westNode
    
    # Représente le statut d'une arête entre deux noeuds. 0 = pas d'arête, 1 = simple, 2 = double
    attr_accessor :northEdge, :eastEdge, :southEdge, :westEdge;

    # Représente le degrée max autorisé sur le noeud
    attr_reader :degreeMax

    # Représente le nombre de degrée restant à connecter avant d'atteindre le degree max
    attr_accessor :degree

    # Construction d'une île
    # * +grid+ Référence sur la grille
    # * +degreeMax+ Degree maximum de l'ile ( nombres de ponts attendus )
    # * +col+ Numéro de colonne 
    # * +lig+ Numéro de ligne 
    def initialize(grid, degreeMax, col, lig )
        super()
        @gridRef = grid
        @degreeMax = degreeMax.to_i
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

        self.style_context.add_class('ile') 
        self.set_name("ile")
        # Status représente une ile 
        self.status = 'i'
        css_file = Gtk::CssProvider.new
        css_file.load(data: <<-CSS)
             @import url("css/plateau_style.css");
                CSS
        self.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        # Charge une image correspondants au noeud
        self.image = Gtk::Image.new(:file => "Ressources/Ile/"+degreeMax+".png") 
       
        #  Retire les contours
        self.set_relief(Gtk::ReliefStyle::NONE)
        self.always_show_image = false
        self.signal_connect('clicked') { self.click() }
    end

    # Calcule le nombres de ponts restants sur une ile
    def pontRestants
        compteur = 0
       
        if( @northNode != nil )
            compteur += @northEdge
        end
        if( @eastNode != nil )
            compteur += @eastEdge
        end
        if( @southNode != nil )
            compteur += @southEdge
        end
        if( @westNode != nil )
            compteur += @westEdge
        end
        return compteur
    end

    # Renvoi vrai si l'ile est relie a
    # chacun de ses voisins 
    # sinon faux
    def pontAvecVoisins
       return self.pontRestants() >= self.compterVoisins()
    end

    # Retourne le nombre de voisins
    def compterVoisins() 
        return self.getVoisins().size
    end

    # Retourne le nombre de connexions restantes avant 
    # que l'île soit complète.
    # Si le nombre est négatif - il y à trop de pont 
    # Si le nombre est positif - Nombre de ponts manquants
    # Si le nombre == 0 - Le pont est complet
    def connexionRestantes 
        return @degreeMax - self.pontRestants()
    end

    # Retourne un tableau contenant les voisins d'une ile
    # Un noeud à nil équivaut à une absence de voisin dans cette
    # direction
    # On ne retourne donc que les voisins valides 
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
    # d'une ile
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

    # Renvoi le nombre de voisins non complets
    def compterVoisinsNonComplets
        return self.voisinsNonComplets().size
    end
    
    #  Décrémente le nombre de pont sur la case
    def dec
        @degree -= 1
    end

    # Modifie le nombre de ponts relie à l'ile 
    def set_degree val
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
            self.style_context.remove_class('complet')
            self.style_context.remove_class('incorrect')
        end
    end

    # Affiche les voisins auxquelles l'île peut-être relié 
    def choixPossible()
		voisins = self.getVoisins
		for voisin in voisins
			if voisin != nil
				if voisin.estComplet == false 
                    voisin.style_context.add_class('possibles')
					voisin.image.from_file = "Ressources/Ile/#{voisin.degreeMax}_s.png"
				end
			end      
		end
	end
	
    # Supprime l'affichage des voisins possibles 
	def enleverChoixPossible()
		voisins = self.getVoisins
		for voisin in voisins
			if voisin != nil
				if voisin.estComplet == false
                    voisin.style_context.remove_class('possibles')
                    if voisin.degree > voisin.degreeMax
                        voisin.image.from_file = "Ressources/Ile/#{voisin.degreeMax}_r.png"
                    else
                        voisin.image.from_file = "Ressources/Ile/#{voisin.degreeMax}.png"
                    end
				end
			end
		end
	end
	

    # Affiche la ligne et la colonne 
    def to_s
        return "[#{@row}-#{@column}]"
    end

    # Méthode de test afin de s'assurer du bon fonctionnement des clics
    def click()
        @gridRef.notify(self)
    end

end
