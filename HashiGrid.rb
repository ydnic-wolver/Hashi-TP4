require 'gtk3'
load "Sauvegarde.rb"

# Cette classe représente la grille
# contenant les boutons ( autrement dit les noeuds , et les
#  ponts d'un point de vue graphique )
# Il y  à peu de méthode encore mais ça arrive
class HashiGrid < Gtk::Grid 
    
    attr_accessor :saveManager

    # Nombre de colonnes 
    attr_accessor :colonnes
    
    # Représente le noeud precedemment clique
    attr_accessor :prev 
    
    # Nombre de lignes
    attr_accessor :lignes

    def initialize
        super()
        @prev = []
        @saveManager = Sauvegarde.new 
    end

    def printPrev
        @prev.each do |x|
            p x.to_s
        end
    end

    def notifyClick() 
        if( saveManager.undoStack.length >= 2 )

            p2 = saveManager.undoStack.pop()
            p1 = saveManager.undoStack.pop()
            
            # p "N1: #{n1.to_s} - degree #{n1.degree} :: N2: #{n2.to_s} - degree #{n2.degree}"
            if ajoutValid?(p1,p2) == true
               ajoutPont(p1,p2)
            else 
                # @prev << n1
            end
        end
    end

    def set_lignes(val)
        p val
        @lignes = val
        return
    end

    def get_lignes()
        @self.lignes
    end

    def set_colonnes(val)
        p val
        @colonnes = val
        return
    end

    def get_colonnes()
        @self.colonnes
        
    end

    # Méthode permettant de s'assurer 
    # du bon lien entre la grille et une case 
    def notify(click)
        # p "Message " + click.to_s
        saveManager.saveUserClick(click)
        @prev << click
        notifyClick()
    end


    def ajoutPont(n1,n2)

        # décrémente le nombre de degrés nécessaires des nœuds.
        # n1.dec
        # n2.dec
        n1.inc()
        n2.inc()

        # Noeud Nord
        if n1.northNode == n2 
			n1.northEdge = n1.northEdge + 1
			n2.southEdge = n2.southEdge + 1 
            n1.update
            n2.update
            for y2 in (n1.row-1).downto(0)
                if(self.get_child_at(n1.column,y2) == n2) 
                    break;
				else
                    self.get_child_at(n1.column,y2).set_typePont( self.get_child_at(n1.column,y2).get_typePont + 1)
                    self.get_child_at(n1.column,y2).set_directionPont(2)
                    self.get_child_at(n1.column,y2).set_stable(true)
                    self.get_child_at(n1.column,y2).update
                end
			end 

        elsif n1.eastNode == n2  #Noeud droit
            n1.eastEdge = n1.eastEdge + 1
			n2.westEdge = n2.westEdge + 1
            n1.update
            n2.update

            for x2 in (n1.column+1).upto(self.lignes-1)
                if(self.get_child_at(x2,n1.row) == n2) 
                    break;
				else
                    self.get_child_at(x2,n1.row).set_typePont( self.get_child_at(x2,n1.row).get_typePont + 1)
                    self.get_child_at(x2,n1.row).set_directionPont(1)
                    self.get_child_at(x2,n1.row).set_stable(true)
                    self.get_child_at(x2,n1.row).update
                end
			end
            
        elsif n1.westNode == n2 # Noeud gauche

            n1.westEdge = n1.westEdge + 1 
			n2.eastEdge = n2.eastEdge + 1
            n1.update
            n2.update

            for x2 in (n1.column-1).downto(0)
                if(self.get_child_at(x2,n1.row) == n2) 
                    break;
                else
                    self.get_child_at(x2,n1.row).set_typePont( self.get_child_at(x2,n1.row).get_typePont() + 1)
                    self.get_child_at(x2,n1.row).set_directionPont(1)
                    self.get_child_at(x2,n1.row).set_stable(true)
                    self.get_child_at(x2,n1.row).update
                end
            end

        elsif n1.southNode == n2 # Noeud bas

            n1.southEdge = n1.southEdge + 1
			n2.northEdge = n2.northEdge + 1
            n1.update
            n2.update
            
            #BAS
            for y2 in (n1.row+1).upto(self.colonnes-1)
                if(self.get_child_at(n1.column,y2) == n2) 
                    break;
                else
                    self.get_child_at(n1.column,y2).set_typePont( self.get_child_at(n1.column,y2).get_typePont() + 1)
                    self.get_child_at(n1.column,y2).set_directionPont(2)
                    self.get_child_at(n1.column,y2).set_stable(true)
                    self.get_child_at(n1.column,y2).update
                end
			end
            
        else 
            p "Erreur: n2 n'est pas un noeud valide pour n1"
		end
        
    end

    def supprimePont(n1, n2)
         # incrément le nombre de degrés nécessaires des nœuds.
        #  n1.inc()
        #  n2.inc()
        n1.dec
        n2.dec
        n1.update
        n2.update

        # Mis à jour des pont #Noeud HAUT
        if n1.northNode == n2 
			n1.northEdge = 0
			n2.southEdge = 0

            for y2 in (n1.row-1).downto(0)
                if(self.get_child_at(n1.column,y2) == n2) 
                    break;
				else
                    self.get_child_at(n1.column,y2).set_typePont( 0 )
                    self.get_child_at(n1.column,y2).set_directionPont(0)
                    self.get_child_at(n1.column,y2).update
                end
			end
        elsif n1.eastNode == n2  #Noeud droit
            n1.eastEdge = 0
			n2.westEdge = 0

            for x2 in (n1.column+1).upto(self.lignes-1)
                if(self.get_child_at(x2,n1.row) == n2) 
                    break;
				else
                    self.get_child_at(x2,n1.row).set_typePont( 0 )
                    self.get_child_at(x2,n1.row).set_directionPont(0)
                    self.get_child_at(x2,n1.row).update
                end
			end
        elsif n1.westNode == n2 # Noeud gauche

            n1.westEdge = 0
			n2.eastEdge = 0

            for x2 in (n1.column-1).downto(0)
                if(self.get_child_at(x2,n1.row) == n2) 
                    break;
                else
                    self.get_child_at(x2,n1.row).set_typePont( 0 )
                    self.get_child_at(x2,n1.row).set_directionPont(0)
                    self.get_child_at(x2,n1.row).update
                end
			end

        elsif n1.southNode == n2 # Noeud bas

            n1.southEdge = 0
			n2.northEdge = 0

            for y2 in (n1.row+1).upto(self.colonnes-1)
                if(self.get_child_at(n1.column,y2) == n2) 
                    break;
                else
                    self.get_child_at(n1.column,y2).set_typePont( 0 )
                    self.get_child_at(n1.column,y2).set_directionPont(0)
                    self.get_child_at(n1.column,y2).update
                end
			end
        else 
            p "Erreur: n2 n'est pas un noeud valide pour n1"
		end

    end
    def OLDsupprimePont(n1, n2)
        # incrément le nombre de degrés nécessaires des nœuds.
        n1.dec()
        n2.dec()

       # Mis à jour des pont #Noeud HAUT
       if n1.northNode == n2 
           n1.northEdge = n1.northEdge - 1
           n2.southEdge = n2.southEdge - 1 

           for y2 in (n1.row-1).downto(0)
               if(self.get_child_at(n1.column,y2) == n2) 
                   break;
               else
                   self.get_child_at(n1.column,y2).set_typePont( self.get_child_at(n1.column,y2).get_typePont - 1)
                   if(self.get_child_at(n1.column,y2).get_typePont == 0)
                       self.get_child_at(n1.column,y2).set_directionPont(0)
                   end
                   self.get_child_at(n1.column,y2).update
               end
           end
       elsif n1.eastNode == n2  #Noeud droit
           n1.eastEdge = n1.eastEdge - 1 
           n2.westEdge = n2.westEdge - 1

           for x2 in (n1.column+1).upto(self.lignes-1)
               if(self.get_child_at(x2,n1.row) == n2) 
                   break;
               else
                   self.get_child_at(x2,n1.row).set_typePont( self.get_child_at(x2,n1.row).get_typePont - 1)
                   if(self.get_child_at(x2,n1.row).get_typePont == 0)
                       self.get_child_at(x2,n1.row).set_directionPont(0)
                   end
               end
           end
       elsif n1.westNode == n2 # Noeud gauche

           n1.westEdge = n1.westEdge - 1
           n2.eastEdge = n2.eastEdge - 1

           for x2 in (n1.column-1).downto(0)
               if(self.get_child_at(x2,n1.row) == n2) 
                   break;
               else
                   self.get_child_at(x2,n1.row).set_typePont( self.get_child_at(x2,n1.row).get_typePont - 1)
                   if(self.get_child_at(x2,n1.row).get_typePont == 0)
                       self.get_child_at(x2,n1.row).directset_directionPontionPont(0)
                   end
               end
           end

       elsif n1.southNode == n2 # Noeud bas

           n1.southEdge = n1.southEdge - 1
           n2.northEdge = n2.northEdge - 1

           for y2 in (n1.row+1).downto(self.colonnes-1)
               if(self.get_child_at(n1.column,y2) == n2) 
                   break;
               else
                   self.get_child_at(n1.column,y2).set_typePont( self.get_child_at(n1.column,y2).get_typePont - 1)
                   if(self.get_child_at(n1.column,y2).get_typePont == 0)
                       self.get_child_at(n1.column,y2).set_directionPont(0)
                   end
               end
           end
       else 
           p "Erreur: n2 n'est pas un noeud valide pour n1"
       end

   end
      # Charge les voisins accessibles d'une case en HAUT, BAS, GAUCHE, DROITE
    def loadNeighbours
        for x in 0..(self.lignes-1)
            for y in 0..(self.colonnes-1)
                if (self.get_child_at(x,y).status == 'i')

                    # DROITE
                    for x2 in (x+1).upto(self.lignes-1)
                        if (self.get_child_at(x2, y).status == 'i')
                            self.get_child_at(x, y).eastNode = self.get_child_at(x2,y)
                            break
                        end
                    end

                    #BAS
                    for y2 in (y+1).upto(self.colonnes-1)
                        if (self.get_child_at(x,y2).status == 'i')
                            self.get_child_at(x,y).southNode = self.get_child_at(x,y2)
                            break
                        end
                    end
                    
                    #HAUT
                    for y2 in (y-1).downto(0)
                        if (self.get_child_at(x,y2).status == 'i')
                            self.get_child_at(x,y).northNode = self.get_child_at(x,y2)
                            break
                        end
                    end

                    # Gauche
                    for x2 in (x-1).downto(0)
                        if (self.get_child_at(x2,y).status == 'i')
                            self.get_child_at(x,y).westNode = self.get_child_at(x2,y)
                            break
                        end
                    end
                end
            end        
        end
    end

    def ajoutValid?(n1,n2)
            # if (n1.degree == 0 || n2.degree == 0)
            #     return false
            # end

            if(n1.northNode != n2 && n1.eastNode != n2 && n1.southNode != n2 && n1.westNode != n2)
                return false;
            end
            
            # Voisins NORD
            if(n1.northNode == n2)
                if(n1.northEdge == 2)
                    supprimePont(n1,n2)
                    return false;
                else
                    # renvoie faux s'il existe déjà un croisement d'arêtes entre ces deux nœuds.
                    for y2 in (n1.row-1).downto(0)
                        if(self.get_child_at(n1.column,y2) == n2) 
                            break;
                        else
                            if(self.get_child_at(n1.column,y2).get_directionPont == 1)
                                return false;
                            end
                        end
                    end
                end
            end
        
            # Voisins DROIT
            if(n1.eastNode == n2)
                if(n1.eastEdge == 2)
                    supprimePont(n1,n2)
                    return false;
                else
                    # renvoie faux s'il existe déjà un croisement d'arêtes entre ces deux nœuds.
                    for x2 in (n1.column+1).upto(self.lignes-1)
                        if(self.get_child_at(x2,n1.row) == n2) 
                            break;
                        else
                            if(self.get_child_at(x2,n1.row).get_directionPont == 2)
                                return false;
                            end
                        end
                    end
                end
            end
            
            # Voisins BAS
            if(n1.southNode == n2)
              
                if(n1.southEdge == 2)
                    supprimePont(n1,n2)
                    return false;
                else
                    # renvoie faux s'il existe déjà un croisement d'arêtes entre ces deux nœuds.
                    for y2 in (n1.row+1).upto(self.colonnes-1)
                        if(self.get_child_at(n1.column,y2) == n2)
                            break;
                        else
                            if(self.get_child_at(n1.column,y2).get_directionPont == 1)
                                return false;
                            end
                        end
                    end
                end
               
            end
             # Voisins GAUCHE
             if(n1.westNode == n2)
                if(n1.westEdge == 2)
                    supprimePont(n1,n2)
                    return false;
                else
                    # renvoie faux s'il existe déjà un croisement d'arêtes entre ces deux nœuds.
                    for x2 in (n1.column-1).downto(0)
                        if(self.get_child_at(x2,n1.row) == n2) 
                            break;
                        else
                            if( self.get_child_at(x2,n1.row).get_directionPont == 2)
                                return false;
                            end
                        end
                    end
                end
            end
        return true
    end

     # Chargement d'une grille
     def loadGrid()
        data = []
        File.foreach('file.txt').with_index do |line, line_no|
            data << line.chomp
        end
        # Slice permet de récupérer la taille de la matrice 
        # tel que 7:7
        num = data.slice!(0)
        self.colonnes = num[0].to_i
        self.lignes = num[2].to_i

        # Parcours des données récupérés afin de charger
        # les boutons
        for i in 0..(data.length() - 1) 
            data[i].split(':').each_with_index do | ch, index| 
                # # Création d'une case 

                if ch != '0'
                    btn = Noeud.new(self, ch,index,i)
                else 
                    btn = Pont.new(self, ch, index, i)
                end

                # On attache la référence de la grille
                btn.hover
                # if( ch != '0')
                #     grid.attachNode(btn)
                # end
                self.attach(btn, index,i, 1,1)
            end
        end
    end

end