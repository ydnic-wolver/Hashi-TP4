require 'gtk3'

load "HashiGrid.rb"
load "Ile.rb"
load "Pont.rb"

$timerStop = 0
$partieStop = 0

class Plateau < Gtk::Window
    def initialize()

        #Creation de la fenêtre
        super()
        set_title "Hashi Game"

        signal_connect "destroy" do 
            #self.destroy
            $partieStop = 1
            Gtk.main_quit 
        end

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
        boutonHypo.signal_connect('clicked'){
            print("Hypo!")
        }

        

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
        grid = HashiGrid.new 
        grid.set_column_homogeneous(true)
        grid.set_row_homogeneous(true)

        #  Chargement de la grille
        grid.chargeGrille()

        grid.chargeVoisins

        boutonUndo.signal_connect('clicked'){
            # print("Undo!")
            grid.undoPrevious
        }

        boutonRedo.signal_connect('clicked'){
            # print("Redo!")
            grid.redoPrevious
        }

        #ajoutGrille(grille)
        boxJeu.add(grid)

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
        show_all

        #Thread chronomètre
        t = Thread.new{
            while $partieStop == 0 do
                tempsDebut = Time.now

                while $timerStop == 0 and $partieStop == 0 do #pause pas acitve ou niveau pas fini
                    temps.set_text( (Time.now - tempsDebut + tempsPause ).round(0).to_s)
                    sleep(1)
                end

                tempsPause = tempsPause + (Time.now - tempsDebut ).round(0)

                while $timerStop == 1 do
                    sleep(0.1)
                end
            end
        }
    end

    #Main provisoire
    #$window = Plateau.new()

    #Gtk.main

end
