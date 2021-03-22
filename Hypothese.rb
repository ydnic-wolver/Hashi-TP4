require 'gtk3'

load 'HashiGrid.rb'


class Hypothese  < Gtk::Window

    def initialize(grid)

        super()
        set_default_size 500, 300
        
        set_window_position Gtk::WindowPosition::CENTER

        #Reglage bouton pause
        pauseImage = Gtk::CssProvider.new
        pauseImage.load(data: <<-CSS)
            button{
                background-image: url("Ressources/pause1.png");
                border: unset;
                background-repeat: no-repeat;
                background-position: center;
            }
        CSS

        boutonPause = Gtk::Button.new()
        boutonPause.style_context.add_provider(pauseImage, Gtk::StyleProvider::PRIORITY_USER)
        boutonPause.set_size_request(30, 30)
        boutonPause.signal_connect('clicked'){

            self.set_sensitive(FALSE)
            $timerStop = 1
            pause = Pause.new
            
        }

        #Reglage du bouton indice
        indiceImage = Gtk::CssProvider.new
        indiceImage.load(data: <<-CSS)
            button{
                background-image: url("Ressources/1.png");
                border: unset;
                background-repeat: no-repeat;
                background-position: center;
            }
        CSS

        boutonIndice = Gtk::Button.new()
        boutonIndice.style_context.add_provider(indiceImage, Gtk::StyleProvider::PRIORITY_USER)
        boutonIndice.set_size_request(30, 30)
        boutonIndice.signal_connect('clicked'){
            print("Indice!")
        }

        #Reglage du bouton Undo
        undoImage = Gtk::CssProvider.new
        undoImage.load(data: <<-CSS)
            button{
                background-image: url("Ressources/traitV.png");
                border: unset;
                background-repeat: no-repeat;
                background-position: center;
            }
        CSS

        boutonUndo = Gtk::Button.new()
        boutonUndo.style_context.add_provider(undoImage, Gtk::StyleProvider::PRIORITY_USER)
        boutonUndo.set_size_request(30, 30)
       

        #Reglage du bouton Redo
        redoImage = Gtk::CssProvider.new
        redoImage.load(data: <<-CSS)
            button{
                background-image: url("Ressources/traitV.png");
                border: unset;
                background-repeat: no-repeat;
                background-position: center;
            }
        CSS

        boutonRedo = Gtk::Button.new()
        boutonRedo.style_context.add_provider(redoImage, Gtk::StyleProvider::PRIORITY_USER)
        boutonRedo.set_size_request(30, 30)
       

        #Reglage du bouton Hypothèse
        hypoImage = Gtk::CssProvider.new
        hypoImage.load(data: <<-CSS)
            button{
                background-image: url("Ressources/traitV.png");
                border: unset;
                background-repeat: no-repeat;
                background-position: center;
            }
        CSS

        boutonHypo = Gtk::Button.new()
        boutonHypo.style_context.add_provider(hypoImage, Gtk::StyleProvider::PRIORITY_USER)
        boutonHypo.set_size_request(30, 30)
        

        #Creation de la barre d'outils en haut de la fenêtre
        boxBarre = Gtk::Box.new(:horizontal, 6)
        boxBarre.set_homogeneous(true)
       
        boxBarre.add(boutonPause)

        temps = Gtk::Label.new()
        boxBarre.add(temps)

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
        @grid = HashiGrid.new 
        @grid.set_column_homogeneous(true)
        @grid.set_row_homogeneous(true)

        #  Chargement de la grille
        @grid.chargeGrille()

        @grid.chargeVoisins

        
        boutonHypo.signal_connect('clicked'){
            print("Hypo!")
            Hypothese.new(@grid)
        }


        boutonUndo.signal_connect('clicked'){
            # print("Undo!")
            grid.undoPrevious
        }

        boutonRedo.signal_connect('clicked'){
            # print("Redo!")
            grid.redoPrevious
        }

        #ajoutGrille(grille)
        boxJeu.add(@grid)

        boxJeuFrame = Gtk::Frame.new()
        boxJeuFrame.set_shadow_type(:out)
        boxJeuFrame.add(boxJeu)
        boxJeuFrame.set_border_width(10)

        #Creation et affichage de la fenêtre principale

        #Gestion du temps
        boxPrincipale = Gtk::Box.new(:vertical, 6)

        boxPrincipale.add(boxBarreFrame)
        boxPrincipale.add(boxJeuFrame)

        add(boxPrincipale)

        #Gestion du temps
        
        temps.set_text( "O")
        tempsPause = 0

        test = grid.collect(&:dup)
        gri = HashiGrid.new 
        gri.colonnes = grid.colonnes
        gri.lignes = grid.lignes
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
        gri.chargeVoisins()

        # gri.connectVoisins() 

		set_title "Hypothèse"
		set_resizable(true)
		signal_connect "destroy" do 
			self.destroy
            puts "CLOSE"
		end 

		set_default_size 500, 400
		set_window_position Gtk::WindowPosition::CENTER
        
        add(gri)

        show_all
    end

end