require 'gtk3'

load "HashiGrid.rb"
load "Ile.rb"
load "Pont.rb"
load "Hypothese.rb"

$timerStop = 0
$partieStop = 0

class Plateau < Gtk::Window

    attr_accessor :grid

    def initialize(nomniv,x,y)
        @nomniv=nomniv
        @x=x
        @y=y

        #Creation de la fenêtre
        super()
        set_title "Hashi Game"

        signal_connect "destroy" do 
            $partieStop = 1
            Gtk.main_quit 
        end

        set_default_size 500, 300
        
        set_window_position Gtk::WindowPosition::CENTER

        #Reglage bouton pause
        boutonPause = Gtk::Button.new()
        boutonPause.image =  Gtk::Image.new(:file => "Ressources/Plateau/pause.png") 
        boutonPause.signal_connect('clicked'){

            self.set_sensitive(FALSE)
            $timerStop = 1
            pause = Pause.new
            
        }

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
            print("Hypo!")
            Hypothese.new(self)
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
        @boxJeu = Gtk::Box.new(:horizontal, 6)
        @boxJeu.set_homogeneous(true)

        @boxJeu.set_border_width(10)

        #Initialisation de la grille
        @grid = HashiGrid.new(@nomniv,@x,@y)
        @grid.set_column_homogeneous(true)
        @grid.set_row_homogeneous(true)

        #  Chargement de la grille
        @grid.chargeGrille()

        @grid.chargeVoisins


        boutonUndo.signal_connect('clicked'){
            grid.undoPrevious
        }

        boutonRedo.signal_connect('clicked'){
            grid.redoPrevious
        }

        #ajoutGrille(grille)
        @boxJeu.add(@grid)

        boxJeuFrame = Gtk::Frame.new()
        boxJeuFrame.set_shadow_type(:out)
        boxJeuFrame.add(@boxJeu)
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

    def alterGrid(newGrid)
        @boxJeu.remove(@grid)
        @grid = newGrid
        @boxJeu.add(@grid)
    end

end
