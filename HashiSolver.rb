require "matrix"

class HashiSolver

    attr_accessor :nodes 

    def initialize(game)
        @hashiGame = game
        creerTableau
        @nbNoeuds = @nodes.length()
        estResolu = false

        n = 1 
        # while( !estResolu )
        #     if resoudre 
        #        estResolu = true 
        #     end
        # end
        puts "JEU FINI "
    end

    def resoudre

        # si les noeuds sont les mêmes ont retournes faux
        # if( n1 == n2 )
        #     return false
        # end

        # Renvoi vrai si le jeux est fini 
        if @hashiGame.getPlateau().grilleFini?
            return true
        end


    end

    def creerTableau
        count = 0
        plateau = @hashiGame.getPlateau()
        for x in 0..(plateau.lignes-1)
            for y in 0..(plateau.colonnes-1)
                if plateau.get_child_at(x,y).status == 'i'
                    count +=1
                end
            end
        end

        @nodes = Array.[]
        num = 0
        for x in 0..(plateau.lignes-1)
            for y in 0..(plateau.colonnes-1)
                if plateau.get_child_at(x,y).status == 'i'
                    @nodes[num] =  plateau.get_child_at(x,y)
                    num +=1
                end
            end
        end

        # @nodes.each do |x|
        #     puts x.to_s
        # end

        if estHamilton?
            puts "OK"
        else 
            puts "nOTOKS"
        end
    end

end