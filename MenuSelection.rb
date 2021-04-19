require 'gtk3'
load "MenuLayout.rb"

##
# Représentation du Menu de Selection de Niveau qui hérite de la classe MenuLayout
# Le Menu de Selection implémente la logique permettant d'accéder à une grille spécifique
##
class MenuSelection < MenuLayout

    # @menu       -> Variable contenant le menu, initialisé dans MenuLayout
    # @builder    -> Variable contenant les propriétés d'affichage, initialisé dans MenuLayout
    # $window     -> variable globale contenant la fenetre du plateau

    # Constructeur du Menu de selection 
    def initialize
        super("ListeNiveau","Menu Selection")
       
        image = @builder.get_object('logo-menu')
        image.from_file = "css/logo-selection.png"

        #Lien entre Menu Selection et chaque plateau
        tableauBtn.each_index{|x| tableauBtn[x].signal_connect('clicked'){
              
                @menu.set_sensitive(false)
                main_window_res = "./Ressources/Glade/menu_chargement.glade"
                builder = Gtk::Builder.new
                builder.add_from_file(main_window_res)
          
                window = builder.get_object('main_window')
                window.style_context.add_provider(css_file,  Gtk::StyleProvider::PRIORITY_USER)
                window.signal_connect "destroy" do 
                    @menu.set_sensitive(true)
                    window.destroy
                end
                window.set_window_position Gtk::WindowPosition::CENTER

                btnLancer = builder.get_object('btnLancer')
                btnSave = builder.get_object('btnSave')
                #Recuperer la difficulté en variable
                if(tableauBtn[x].isFacile?)
                	diff = "Facile"
                elsif(tableauBtn[x].isMoyen?)
                	diff = "Moyen"
                else
                	diff = "Hard"
                end
                titre = tableauBtn[x].getNiveau.match(/[^\/]*.txt/)
                if ((!(File.file?("./Sauvegarde/#{diff}/save#{titre}"))) || File.zero?("./Sauvegarde/#{diff}/save#{titre}"))
                	btnSave.sensitive = false
                end
                btnSave.signal_connect('clicked'){
                    chargement=1
                   
                    window.destroy
                    @menu.destroy
                    $window = Plateau.new(tableauBtn[x].getNiveau,tableauBtn[x].getY,tableauBtn[x].getX, diff,chargement)
                    Gtk.main
                }
                btnLancer.signal_connect('clicked'){
                    chargement =0
                    window.destroy
                    @menu.destroy
                    $window = Plateau.new(tableauBtn[x].getNiveau,tableauBtn[x].getY,tableauBtn[x].getX, diff,chargement)
                    Gtk.main
                }
                btnRetourcharg =  builder.get_object('btnRetourcharg')
                btnRetourcharg.signal_connect('clicked'){
                    @menu.set_sensitive(true)
                    window.destroy
                }

                #---- Création du style CSS ----
                btn_css = Gtk::CssProvider.new
                btn_css.load(data: <<-CSS)
                @import url("css/style.css");
                  CSS

                #---- Affectation du style  CSS ----
                btnLancer.style_context.add_provider(btn_css, Gtk::StyleProvider::PRIORITY_USER)
                btnSave.style_context.add_provider(btn_css, Gtk::StyleProvider::PRIORITY_USER)
                btnRetourcharg.style_context.add_provider(btn_css, Gtk::StyleProvider::PRIORITY_USER)
           

                window.show_all
            }   
        
        }
        
        
        @menu.show
    end
end
