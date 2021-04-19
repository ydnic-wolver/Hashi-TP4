require 'gtk3'

##
# Représentation du Menu Pause
##
class Pause

    # $window     -> variable globale contenant la fenetre du plateau

    # Constructeur du Menu Pause 
    def initialize()
       
        file_import = "./Ressources/Glade/menu_pause.glade"
        builder = Gtk::Builder.new
        builder.add_from_file(file_import)

        
        menu_pause = builder.get_object('menu_pause')

        menu_pause.signal_connect "destroy" do
            $window.getPlateau().set_sensitive(true)
            menu_pause.destroy
        end

        menu_pause.set_window_position Gtk::WindowPosition::CENTER

       
        boutonReprendre = builder.get_object('boutonReprendre')
        boutonReprendre.signal_connect('clicked'){
            $window.getPlateau().set_sensitive(true)
            menu_pause.destroy
            $window.lancerChrono
        }

        boutonRecommencer = builder.get_object('boutonRecommencer')
        boutonRecommencer.signal_connect('clicked'){
            $window.getPlateau().set_sensitive(true)
            menu_pause.destroy
            $window.resetPlateau()
        }
        
        boutonQuitter = builder.get_object('boutonQuitter')
	    boutonQuitter.signal_connect('clicked'){
            menu_pause.destroy
            $window.getPlateau().destroy
            MainMenu.new
            Gtk.main
	    }

        css_file = Gtk::CssProvider.new
        css_file.load(data: <<-CSS)
             @import url("css/style.css");
                CSS
        
        menu_pause.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonReprendre.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonRecommencer.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonQuitter.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)

        menu_pause.show_all
    end
end