require 'gtk3'

load "HashiGrid.rb"
load "Ile.rb"
load "Pont.rb"
load "Hypothese.rb"
load "Sauvegarde.rb"
load "Aide.rb"

##
# Cette classe représente le plateau du plateau du jeu 
##
class Plateau 

    # @nomniv         -> Nom du niveau lancé
    # @x              -> Nombre de colonnes
    # @y              -> Nombre de lignes
    # @diff           -> Difficulté du niveau lancé
    # @chargement     -> Variable indiquand si le niveau créé est un nouveau niveau ou un niveau chargé
    # @grid           -> Variable contenant la grille du niveau
    # @plateau        -> Variable contenant la fenetre du jeu
    # @t              -> Variable contenant le thread pour faire fonctionner le chronomètre
    # @label_aide     -> Variable contenant le texte affiché quand on demande de l'aide
    # @aide           -> Variable contenant une instance du système d'aide
    # $temps          -> Variable contenant l'affichage du chronomètre dans la fenêtre
    # @boxJeu         -> Variable contenant le style de la grille de jeu
    # $tempssec       -> Variable contenant le temps écoulé pendant la partie, incrémenté dans le thread
    # @boxPrincipale  -> Variable contenant le style de la fenètre de jeu


    # Référence sur la grille
    attr_accessor :grid

    # Constructeur du plateau 
    # * +nomniv+ nom du niveau lancé
    # * +x+ nombre de colonnes
    # * +y+ nombre de lignes
    # * +diff+ difficulté du niveau lancé
    # * +chargement+ variable indiquand si le niveau créé est un nouveau niveau ou un niveau chargé

    def initialize(nomniv, x, y, diff, chargement)
        @nomniv=nomniv
        @x=x
        @y=y
        @diff = diff
        @chargement=chargement #0 ou 1 si 1 ils s'agit d'un chargement

        # Initialisation de la grille
        @grid = HashiGrid.new(@nomniv, @diff, @x,@y)
       
         #Creation de la fenêtre
        main_window_res = "./Ressources/Glade/plateau.glade"
        builder = Gtk::Builder.new
        builder.add_from_file(main_window_res)

        @plateau = builder.get_object('plateau')
        @plateau.set_title "Hashi Game"
        @plateau.signal_connect "destroy" do 
            Thread.kill(@t)
            Gtk.main_quit 
        end

        @plateau.set_window_position Gtk::WindowPosition::CENTER
        css_file = Gtk::CssProvider.new
        css_file.load(data: <<-CSS)
            @import url("css/plateau_style.css");
        CSS

        #Reglage bouton pause
        boutonPause = builder.get_object('boutonPause')
        boutonPause.signal_connect('clicked'){
            @plateau.set_sensitive(false)
            Thread.kill(@t)
            pause = Pause.new()
        }
        @plateau.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        @label_aide = builder.get_object('label_aide')
        @label_aide.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        

        @aide = Aide.new(@grid)
        @label_aide.set_label("")
      

        # #Reglage du bouton indice
        boutonIndice = builder.get_object('boutonIndice')
        boutonIndice.signal_connect('clicked'){
            @label_aide.set_label(@aide.getMessageAide)
            @boxPrincipale.show_all
        }

        # #Reglage du bouton Undo
        boutonUndo = builder.get_object('boutonUndo')
       
        # #Reglage du bouton Redo
        boutonRedo = builder.get_object('boutonRedo')

        # #Reglage du bouton Hypothèse
        boutonHypo = builder.get_object('boutonHypo')
        boutonHypo.signal_connect('clicked'){
            @plateau.set_sensitive(false)
            Hypothese.new(self)
        }
        
        boutonPause.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonIndice.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonRedo.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonUndo.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonHypo.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        # #Creation de la barre d'outils en haut de la fenêtre
    
        $temps = builder.get_object('temps')
        

        @boxJeu = builder.get_object('boxJeu')
        @boxJeu.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        
        # @boxJeu.set_border_width(10)
        $temps = builder.get_object('temps')
       
        #  Chargement de la grille
        @grid.chargeGrille()
        @grid.chargeVoisins

        $tempssec = 0

        if(@chargement==1)
           $tempssec = Sauvegarde.charge(@grid,nomniv,diff)
        end

        $temps.set_text($tempssec.to_s)

        @grid.expand = true 
        @grid.halign =  Gtk::Align::CENTER
        @grid.valign =  Gtk::Align::CENTER
        @grid.set_row_homogeneous(true)
        @grid.set_column_homogeneous(true)
      

        boutonUndo.signal_connect('clicked'){
           @grid.undoPrevious
        }

        boutonRedo.signal_connect('clicked'){
            @grid.redoPrevious
        }

        # ajoutGrille(grid)
        @boxJeu.add(@grid)
        @boxJeu.show_all

        #Creation et affichage de la fenêtre principale
        @boxPrincipale = builder.get_object('boxPrincipale')
        @boxPrincipale.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        
        #Gestion du temps
        
        @chargement = 0

        @plateau.show

        #Thread chronomètre
        lancerChrono
    end

    # Retourne le plateau de jeu
    def getPlateau()
        return @plateau
    end

    # Méthode responsable de la gestion d'une parti fini 
    def partiFini

        if(@grid.grilleFini?)
        
            sleep(0.5) # on attend 0.5 sec afin de voir le coup qu'on a effectuer avant l'affichage #
            Thread.kill(@t)
            @plateau.set_sensitive(false)
        
            main_window_res = "./Ressources/Glade/menu_win.glade"
            builder = Gtk::Builder.new
            builder.add_from_file(main_window_res)

            window = builder.get_object('menu_gain')
            window.set_title "VICTOIRE"
            window.set_window_position Gtk::WindowPosition::CENTER
            window.signal_connect "destroy" do 
                Gtk.main_quit 
            end

            css_file = Gtk::CssProvider.new
            css_file.load(data: <<-CSS)
                @import url("css/menu_pause.css");
            CSS

            window.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
         
            #Affichage du temps
            texteTemps = builder.get_object('texteTemps')
            texteTemps.set_markup("<span font_desc = \"Toledo 15\">Votre temps : " +  $tempssec.to_s + " secondes.</span>\n")
            texteTemps.set_justify(Gtk::Justification::CENTER)
            
            saveBox = builder.get_object('saveBox')
    
            # #Zone de texte pour entrer son pseudo
            zonetexte= builder.get_object('zonetexte')
            zonetexte.set_placeholder_text("Votre pseudo")

            # #Bouton pour sauvegarder            
            btnSauvegarder = builder.get_object('btnSauvegarder')
            textLabel = builder.get_object("textLabel")

            btnSauvegarder.signal_connect('clicked'){
                label = zonetexte.text + "<span font_desc = \"Calibri 10\"> sauvegardé.</span>\n"
                Sauvegarde.saveTime(@nomniv, @diff, $tempssec.to_s, zonetexte.text)
                textLabel.set_markup(label)
                btnSauvegarder.hide()
               
            }

            # #Bouton pour recommencer la partie
            btnRecommencer = builder.get_object('btnRecommencer')
            btnRecommencer.signal_connect('clicked'){
                self.getPlateau().set_sensitive(true)
                window.destroy
                self.resetPlateau()
                Gtk.main
            }
    
            # #Bouton pour retourner au menu principal
            btnRetour =  builder.get_object('btnRetour')
            btnRetour.signal_connect('clicked'){
                window.destroy
                @plateau.destroy
                MainMenu.new
                Gtk.main
            }
            
            btnRecommencer.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
            btnRetour.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
            btnSauvegarder.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)

            Sauvegarde.saveDelete(@nomniv, @diff)
         

            window.show_all
        end
        
    end

    # Cette méthode permet de gérer tous les traitements 
    # lors de la validation de l'hypothèse
    # Elle supprime l'ancienne grille et met en place la nouvelle
    # * +newGrid+ la grille du mode hypothèse qui va remplacer la grille actuelle
    def hypotheseValider(newGrid)
        
        @boxJeu.remove(@grid)
        @grid = newGrid
        @grid.expand = true 
        @grid.halign =  Gtk::Align::CENTER
        @grid.valign =  Gtk::Align::CENTER
        @grid.set_row_homogeneous(true)
        @grid.set_column_homogeneous(true)
        if(@grid.grilleFini? )
            self.partiFini
        end 
        
        @grid.undoRedo.cleanAll()
        @boxJeu.add(@grid)

        return self
    end

    #Lance un thread pour le chronometre
    def lancerChrono()
        @t = Thread.new{
            loop{
                
                sleep(1)
                $tempssec += 1
                $temps.set_text($tempssec.to_s)
            }

            Thread.exit
        }

        return self
    end


    # Mis à jour du niveau
    # Dans notre cas on reset le plateau
    def resetPlateau()


        Thread.kill(@t)

        @plateau.destroy

        $window = Plateau.new(@nomniv,@y,@x, @diff,@chargement)
        Gtk.main

        return self
    end 
end
