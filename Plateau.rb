require 'gtk3'

load "HashiGrid.rb"
load "Ile.rb"
load "Pont.rb"
load "Hypothese.rb"

$timerStop = 0
$partieStop = 0

class Plateau < Gtk::Window

    attr_accessor :grid

    def initialize(nomniv, x, y, diff,chargement)
        @nomniv=nomniv
        @x=x
        @y=y
        @diff = diff
        @chargement=chargement #0 ou 1 si 1 ils s'agit d'un chargement

        $partieStop = 0
        $timerStop = 0

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
            self.set_sensitive(false)
            $timerStop = 1
            pause = Pause.new()
        }


        #Reglage du bouton indice
        boutonIndice = Gtk::Button.new()
        boutonIndice.image = Gtk::Image.new(:file => "Ressources/Plateau/aide.png")
        boutonIndice.signal_connect('clicked'){
            print("Indice!")
            butt = Gtk::Button.new(:label => "INDICe")
            @boxPrincipale.add(butt)
            @boxPrincipale.show_all
        }

        #Reglage du bouton Undo
        boutonUndo = Gtk::Button.new()
        boutonUndo.image = Gtk::Image.new(:file => "Ressources/Plateau/undo.png")


        #Reglage du bouton Redo
        boutonRedo = Gtk::Button.new()
        boutonRedo.image = Gtk::Image.new(:file => "Ressources/Plateau/redo.png")


        #Reglage du bouton Hypothèse
        boutonHypo = Gtk::Button.new()
        boutonHypo.image = Gtk::Image.new(:file => "Ressources/Plateau/hypothese.png")
        boutonHypo.signal_connect('clicked'){
            print("Hypo!")
            self.set_sensitive(false)
            Hypothese.new(self)
        }
        

        #Creation de la barre d'outils en haut de la fenêtre
        boxBarre = Gtk::Box.new(:horizontal, 6)
        boxBarre.set_homogeneous(true)
       
        boxBarre.add(boutonPause)

        @temps = Gtk::Label.new()
        boxBarre.add(@temps)

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
        # creerGrid()
        @grid = HashiGrid.new(@nomniv,@x,@y,@diff)
        @grid.set_column_homogeneous(true)
        @grid.set_row_homogeneous(true)
        #  Chargement de la grille
        @grid.chargeGrille()
        @grid.chargeVoisins
        if(@chargement==1)
            @grid.chargeSauvegarde(nomniv,diff)
        end

        boutonUndo.signal_connect('clicked'){
           @grid.undoPrevious
        }

        boutonRedo.signal_connect('clicked'){
            @grid.redoPrevious
        }

        #ajoutGrille(grille)
        @boxJeu.add(@grid)

        @boxJeuFrame = Gtk::Frame.new()
        @boxJeuFrame .set_shadow_type(:out)
        @boxJeuFrame .add(@boxJeu)
        @boxJeuFrame .set_border_width(10)

        #Creation et affichage de la fenêtre principale
        @boxPrincipale = Gtk::Box.new(:vertical, 6)

        @boxPrincipale.add(boxBarreFrame)
        @boxPrincipale.add(@boxJeuFrame)

        add(@boxPrincipale)

        #Gestion du temps
        
        @temps.set_text("0")

        if(@chargement != 1)
            $tempsPause = 0
        end

        if(@chargement == 1)
            puts $tempsPause
        end

        $tempsFin = 0
        show_all

        #Thread chronomètre
        t = Thread.new{
            while $partieStop == 0 do
                @tempsDebut = Time.now
                if( @grid.grilleFini?)
                    puts "GAGNER"
                end
                while $timerStop == 0 and $partieStop == 0 do #pause pas active ou niveau pas fini
                    
                    @temps.set_text( (Time.now - @tempsDebut + $tempsPause.to_f ).round(0).to_s)
                    $tempsFin = (Time.now - @tempsDebut + $tempsPause.to_f ).round(0)
                    sleep(1)
                end

                $tempsPause = $tempsPause + (Time.now - @tempsDebut ).round(0)

                while $timerStop == 1 do
                    sleep(0.1)
                end
            end
        }
    end

    def partiFini

        if(@grid.grilleFini?)
        
            sleep(0.5) # on attend 0.5 sec afin de voir le coup qu'on a effectuer avant l'affichage #
            $window.set_sensitive(false)
            window=Gtk::Window.new()
            window.set_title "VICTOIRE"
            window.set_resizable(true)
        
            window.set_default_size 300, 400
            window.set_window_position Gtk::WindowPosition::CENTER
            pVBox = Gtk::Box.new(:vertical, 25)
    
            #Titre de la fenetre
            title = "<span font_desc = \"Verdana 40\">VICTOIRE</span>\n"
            textTitle = Gtk::Label.new()
            textTitle.set_markup(title)
            textTitle.set_justify(Gtk::Justification::CENTER)

            #Affichage du temps
            texteTemps = Gtk::Label.new()
            texteTemps.set_markup("<span font_desc = \"Calibri 10\">Votre temps : </span>\n" +  $tempsFin.to_s + "<span font_desc = \"Calibri 10\"> secondes.</span>\n")
            texteTemps.set_justify(Gtk::Justification::CENTER)
            
            #Affichage du message changeant
            label = "<span font_desc = \"Calibri 10\">Vous etes vraiment trop fort ! </span>\n"
            textlabel = Gtk::Label.new()
            textlabel.set_markup(label)
            textlabel.set_justify(Gtk::Justification::CENTER)

            partiSaveBox = Gtk::Box.new(:vertical, 20)

            saveBox = Gtk::Box.new(:horizontal, 20)
    
            #Zone de texte pour entrer son pseudo
            zonetexte=Gtk::Entry.new()
            zonetexte.set_placeholder_text("Votre pseudo")

            #Bouton validant le pseudo, sauvegardant et affichant un message de confirmation
            btnEntrerPseudo= Gtk::Button.new(:label => 'Entrer')
            btnEntrerPseudo.signal_connect('clicked'){
                label = zonetexte.text + "<span font_desc = \"Calibri 10\"> sauvegardé.</span>\n"
                textlabel.set_markup(label)

                SaveTime.new(@nomniv, @diff, $tempsFin.to_s, zonetexte.text)

                partiSaveBox.hide()
            }

            saveBox.add(zonetexte)
            saveBox.add(btnEntrerPseudo)
            saveBox.set_homogeneous(true)

            #Bouton pour sauvegarder            
            btnSauvegarder = Gtk::Button.new(:label => 'Sauvegarder')
            btnSauvegarder.signal_connect('clicked'){
                saveBox.show()
                label = "<span font_desc = \"Calibri 10\">Entrez un nom pour sauvegarder.</span>\n"
                textlabel.set_markup(label)
            }
            $timerStop=1

            #Bouton pour recommencer la partie
            btnRecommencer = Gtk::Button.new(:label => 'Recommencer')
            btnRecommencer.signal_connect('clicked'){
                $window.set_sensitive(true)
                $window.resetPlateau()
                window.destroy
            }
    
            #Bouton pour retourner au menu principal
            btnRetour = Gtk::Button.new(:label => 'Menu Principal')
            btnRetour.signal_connect('clicked'){
                window.destroy
                destroy
                MainMenu.new
                Gtk.main
            }
    

            pVBox.add(textTitle)
            pVBox.add(texteTemps)
            pVBox.add(textlabel)
            #pVBox.add(btnSauvegarder)

            partiSaveBox.add(btnSauvegarder)
            partiSaveBox.add(saveBox)
            pVBox.add(partiSaveBox)

            pVBox.add(btnRecommencer)
            pVBox.add(btnRetour)
            window.add(pVBox)
            window.show_all
            saveBox.hide()
        end
        
    end

    # Alteration de la grille

    def hypotheseValider(newGrid)
        @boxJeu.remove(@grid)
        @grid = newGrid

        if(@grid.grilleFini? )
            self.partiFini
        end 

        @grid.saveManager.cleanAll()
        @boxJeu.add(@grid)
    end


    # Mis à jour du niveau
    # Dans notre cas on reset le plateau
    def resetPlateau()

        @tempsDebut = Time.now
        $tempsPause = 0
        @temps.set_text("O")
        $timerStop = 0
        $partieStop = 0
        @boxJeu.remove(@grid)
        #  Chargement de la grille
        gri = HashiGrid.new(@grid.nomniv,@grid.lignes, @grid.colonnes  , @grid.diff)
        #creer un fichier de sauvegarde vide
        titre = @grid.nomniv.match(/[^\/]*.txt/)
        f=File.open("./Sauvegarde/#{@grid.diff}/save#{titre}", 'w')
        f.close()
        @grid = gri

        gri.colonnes =@grid.colonnes
        gri.lignes = @grid.lignes
        gri.set_column_homogeneous(true)
        gri.set_row_homogeneous(true)
        gri.chargeGrille()
        gri.chargeVoisins()

        @boxJeu.add(@grid)
        @boxJeu.show_all

    end 
end
