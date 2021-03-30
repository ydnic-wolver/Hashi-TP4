require 'gtk3'
##
# Représentation d'un Bouton qui fait le lien entre le menu de sélection et chaque plateau qui hérite de la classe Button de Gtk
##
# * +facile+ Variable qui permet de savoir si le bouton renvoit vers un niveau facile
# * +moyen+ Variable qui permet de savoir si le bouton renvoit vers un niveau moyen
# * +hard+ Variable qui permet de savoir si le bouton renvoit vers un niveau difficile
# * +niveau+ Variable qui correspond au PATH vers le niveau que redirige le bouton
# * +x+ Coordonnée X du plateau qui correspond au niveau renvoyer par le plateau
# * +y+ Coordonnée Y du plateau qui correspond au niveau renvoyer par le plateau
class BoutonChoix < Gtk::Button
    attr_reader :niveau
    attr_reader :x
    attr_reader :y
    attr_reader :indice
    #Constructeur du bouton
    def initialize(facile,moyen,hard,niv,x,y)
        super()
        @facile=facile  
        @moyen=moyen
        @hard=hard 
        @niveau=niv
        @x=x
        @y=y
        if(self.isFacile?)
            self.set_label("Niveau facile : "+@x.to_s+"x"+@y.to_s)
        elsif(self.isMoyen?)
            self.set_label("Niveau Moyen : "+@x.to_s+"x"+@y.to_s)
        else
            self.set_label("Niveau Difficile : "+@x.to_s+"x"+@y.to_s)
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
    #Getter De la Coordonnée X de la grille du plateau
    def getX
        return @x
    end
    #Getter De la Coordonnée Y de la grille du plateau
    def getY 
        return @y
    end

end