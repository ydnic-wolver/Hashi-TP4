require 'gtk3'

class BoutonChoix < Gtk::Button

    def initialize(facile,moyen,hard,compteur)
        super()
        @facile=facile  
        @moyen=moyen
        @hard=hard 
        @titre=compteur
        self.set_label("Niveau "+@titre.to_s)
    end

    def isFacile? 
        return @facile
    end

    def isMoyen? 
        return @moyen
    end

    def isHard?
        return @hard
    end



end