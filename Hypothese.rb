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
        # Copie des noeuds contenus dans la grille
        copy_grille = plateau.grid.collect(&:dup)
        # Création d'une nouvelle grille
        hypoGrille = HashiGrid.new(plateau.grid.nomniv,plateau.grid.lignes, plateau.grid.colonnes  )
        hypoGrille.set_column_homogeneous(true)
        hypoGrille.set_row_homogeneous(true)
        hypoGrille.colonnes = plateau.grid.colonnes
        hypoGrille.lignes = plateau.grid.lignes

        # On parcours le tableau des iles/ponts copies
        copy_grille.each do |x| 
            # Si c'est une ile 
            # On copie les attributs de l'ile
            if x.status != 'p'
                btn = Ile.new(hypoGrille,x.degreeMax.to_s,x.column,x.row)
                btn.degree = x.degree
                btn.estComplet = x.estComplet
                btn.northEdge = x.northEdge
                btn.southEdge = x.southEdge
                btn.westEdge = x.westEdge
                btn.eastEdge = x.eastEdge
                btn.update
            else 
                # Si c'est un pont on copie les attributs 
                # et on met à jour le pont 
                btn = Pont.new(hypoGrille,x.degreeMax.to_s,x.column,x.row)
                btn.set_typePont( x.get_typePont )
                btn.estDouble = x.estDouble
                btn.set_directionPont ( x.get_directionPont )
                btn.update
            end
                # On attache la référence de la grille
                hypoGrille.attach(btn, x.column,x.row, 1,1)
        end
        # Chargement des voisins
        hypoGrille.chargeVoisins

        #ajoutGrille(grille)
        boxJeu.add(hypoGrille)

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
            boxJeu.remove(hypoGrille)
            plateau.hypotheseValider(hypoGrille)
            self.destroy
        }

        boutonUndo.signal_connect('clicked'){
            hypoGrille.undoPrevious
        }

        boutonRedo.signal_connect('clicked'){
            hypoGrille.redoPrevious
        }

        boxPrincipale.add(bt)
        add(boxPrincipale)

        show_all
    end

end