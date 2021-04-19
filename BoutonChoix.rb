require 'gtk3'


##
# Représentation d'un Bouton qui fait le lien entre le menu de sélection et chaque plateau qui hérite de la classe Button de Gtk
##
class BoutonChoix < Gtk::Button

    # @facile     -> Variable qui permet de savoir si le bouton renvoit vers un niveau facile
    # @moyen      -> Variable qui permet de savoir si le bouton renvoit vers un niveau moyen
    # @hard       -> Variable qui permet de savoir si le bouton renvoit vers un niveau hard
    # @niveau     -> Variable qui correspond au PATH vers le niveau que redirige le bouton
    # @x          -> Coordonnée X du plateau qui correspond au niveau renvoyer par le plateau
    # @y          -> Coordonnée Y du plateau qui correspond au niveau renvoyer par le plateau
    # @path       -> Variable contenant le path complet du bouton

  
    #  Variable qui correspond au PATH vers le niveau que redirige le bouton
    attr_reader :niveau

    # Coordonnée X du plateau qui correspond au niveau renvoyer par le plateau
    attr_reader :x

    # Coordonnée Y du plateau qui correspond au niveau renvoyer par le plateau
    attr_reader :y

    # Variable contenant le path complet du bouton 
    attr_accessor :path 

    # Constructeur du bouton
    # * +facile+ Variable qui permet de savoir si le bouton renvoit vers un niveau facile
    # * +moyen+ Variable qui permet de savoir si le bouton renvoit vers un niveau moyen
    # * +hard+ Variable qui permet de savoir si le bouton renvoit vers un niveau difficile
    # * +niv+ Variable qui correspond au PATH vers le niveau que redirige le bouton
    # * +x+ Coordonnée X du plateau qui correspond au niveau renvoyer par le plateau
    # * +y+ Coordonnée Y du plateau qui correspond au niveau renvoyer par le plateau
    def initialize(facile,moyen,hard,niv,x,y)
        super()
        # Charge une image correspondants au noeud
        self.image = Gtk::Image.new(:file => "./Ressources/MenuSelection/btn_grille.png") 
        #  Retire les contours
        self.set_relief(Gtk::ReliefStyle::NONE)
        self.always_show_image = true
         
       @facile=facile  
       @moyen=moyen
       @hard=hard 
       @niveau=niv
       @x=x
       @y=y
       if(self.isFacile?)
           self.set_label(@x.to_s+"x"+@y.to_s)
       elsif(self.isMoyen?)
           self.set_label(@x.to_s+"x"+@y.to_s)
       else
           self.set_label(@x.to_s+"x"+@y.to_s)
       end
    end

    #Permet au bouton de savoir si le niveau qu'il renvoit est facile
    def isFacile? 
        return @facile
    end
    #Permet au bouton de savoir si le niveau qu'il renvoit est Moyen
    def isMoyen? 
        return @moyen
    end
    #Permet au bouton de savoir si le niveau qu'il renvoit est difficile
    def isHard?
        return @hard
    end
    #Getter du niveau du plateau
    def getNiveau
        return @niveau
    end
    #Getter de la coordonnée X de la grille du plateau
    def getX
        return @x
    end
    #Getter de la coordonnée Y de la grille du plateau
    def getY 
        return @y
    end

    # Méthode permettant de modifier le path d'un bouton
     # * +path+ le nouveau path du bouton
    def set_path(path)
        @path = path
        return self
    end
end