require 'gtk3'

load 'HashiGrid.rb'


class Hypothese  < Gtk::Window

    def initialize(plateau)

        #Creation de la fenêtre
        super()
        set_title "Hypothèse"
		set_resizable(false)
		signal_connect "destroy" do 
			self.destroy
		end 

        set_window_position Gtk::WindowPosition::CENTER

		set_default_size 500, 400
		
        #Reglage du bouton indice
        boutonIndice = Gtk::Button.new()
        boutonIndice.image = Gtk::Image.new(:file => "Ressources/Plateau/hypothese.png")
        boutonIndice.signal_connect('clicked'){
            print("Indice!")
        }

        #Reglage du bouton Undo
        boutonUndo = Gtk::Button.new()
        boutonUndo.image = Gtk::Image.new(:file => "Ressources/Plateau/undo.png")


        #Reglage du bouton Redo
        boutonRedo = Gtk::Button.new()
        boutonRedo.image = Gtk::Image.new(:file => "Ressources/Plateau/redo.png")


        #Reglage du bouton Hypothèse
        boutonHypo = Gtk::Button.new()
        boutonHypo.image = Gtk::Image.new(:file => "Ressources/Plateau/aide.png")
        boutonHypo.signal_connect('clicked'){
            print("Redo!")
            
        }
        

        #Creation de la barre d'outils en haut de la fenêtre
        boxBarre = Gtk::Box.new(:horizontal, 6)
        boxBarre.set_homogeneous(true)
       
        boxBarre.add(boutonIndice)
        boxBarre.add(boutonUndo)
        boxBarre.add(boutonRedo)
        boxBarre.add(boutonHypo)


        boxBarre.set_border_width(5)

        boxBarreFrame = Gtk::Frame.new()
        boxBarreFrame.set_shadow_type(:out)
        boxBarreFrame.add(boxBarre)

        #Creation de la zone de jeu
        boxJeu = Gtk::Box.new(:horizontal, 6)
        boxJeu.set_homogeneous(true)


        boxJeu.set_border_width(10)

        #Initialisation de la grille

        test = plateau.grid.collect(&:dup)
        gri = HashiGrid.new(plateau.grid.nomniv,plateau.grid.lignes, plateau.grid.colonnes  )
        gri.set_column_homogeneous(true)
        gri.set_row_homogeneous(true)
        gri.colonnes = plateau.grid.colonnes
        gri.lignes = plateau.grid.lignes

        test.each do |x| 
            # puts x.to_s
            # HashiGrid.new(test)
        #    puts "Ponts : HAUT #{x.northEdge}, BAS #{x.southEdge},DROITE #{x.eastEdge} GAUCHE #{x.westEdge}"
             ## # Création d'une case 
                #   grille degree colone ligne
            if x.status != 'p'
                btn = Ile.new(gri,x.degreeMax.to_s,x.column,x.row)
                btn.degree = x.degree
                btn.estComplet = x.estComplet
                btn.northEdge = x.northEdge
                btn.southEdge = x.southEdge
                btn.westEdge = x.westEdge
                btn.eastEdge = x.eastEdge
                btn.update
            else 
                btn = Pont.new(gri,x.degreeMax.to_s,x.column,x.row)
                btn.set_typePont( x.get_typePont )
                btn.estDouble = x.estDouble
                btn.set_directionPont ( x.get_directionPont )
                btn.update
            end
                # On attache la référence de la grille
                gri.attach(btn, x.column,x.row, 1,1)
        end
     
        gri.chargeVoisins

        #ajoutGrille(grille)
        boxJeu.add(gri)

        boxJeuFrame = Gtk::Frame.new()
        boxJeuFrame.set_shadow_type(:out)
        boxJeuFrame.add(boxJeu)
        boxJeuFrame.set_border_width(10)

        #Creation et affichage de la fenêtre principale

        #Gestion du temps
        boxPrincipale = Gtk::Box.new(:vertical, 6)

        boxPrincipale.add(boxBarreFrame)
        boxPrincipale.add(boxJeuFrame)
        bt = Gtk::Button.new(:label => "OK")

        bt.signal_connect('clicked'){
            boxJeu.remove(gri)
            plateau.alterGrid(gri)
            self.destroy
        }

        boutonUndo.signal_connect('clicked'){
            gri.undoPrevious
        }

        boutonRedo.signal_connect('clicked'){
            gri.redoPrevious
        }


        boxPrincipale.add(bt)

        add(boxPrincipale)

        

        # gri.connectVoisins() 


        show_all
    end

end