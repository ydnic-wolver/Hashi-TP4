require 'gtk3'


##
# Cette classe représente le menu Principal du jeu HASHI
class MainMenu 

	# Constructeur du menu principal
    def initialize
		
		
		main_window_res = "./Ressources/Glade/menu_principal.glade"
		builder = Gtk::Builder.new
		builder.add_from_file(main_window_res)

		main_menu = builder.get_object('main_window')
		main_menu.set_title "Menu principal"
		main_menu.signal_connect "destroy" do 
			Gtk.main_quit 
		end

		main_menu.set_window_position Gtk::WindowPosition::CENTER
		main_menu_CSS = Gtk::CssProvider.new
        main_menu_CSS.load(data: <<-CSS)
			@import url("css/style.css");
        CSS

		main_menu.set_title "Hashi Game"
		main_menu.style_context.add_provider(main_menu_CSS, Gtk::StyleProvider::PRIORITY_USER)

		
		btnSelection = builder.get_object('btn-selection-menu')
		btnSelection.signal_connect('clicked'){
		
			MenuSelection.new
			main_menu.destroy
			Gtk.main
		}

		btnTuto = builder.get_object('btn-tutoriel')
		btnTuto.signal_connect('clicked'){
			Tuto.new
			main_menu.destroy
			Gtk.main
		}

		btnClassement = builder.get_object('btn-classement')
		btnClassement.signal_connect('clicked'){
			Classement.new
			main_menu.destroy
			Gtk.main
		}

		btnAPropos =builder.get_object('btn-about')
		btnAPropos.signal_connect('clicked'){
			APropos.new
		}
		

		btnQuitter = builder.get_object('btn-quitter')
		btnQuitter.signal_connect('clicked'){Gtk.main_quit}

		bouton_css = Gtk::CssProvider.new
		bouton_css.load(data: <<-CSS)
			@import url("css/style.css");
        CSS
		btnSelection.style_context.add_provider(bouton_css, Gtk::StyleProvider::PRIORITY_USER)
		btnTuto.style_context.add_provider(bouton_css, Gtk::StyleProvider::PRIORITY_USER)
		btnClassement.style_context.add_provider(bouton_css, Gtk::StyleProvider::PRIORITY_USER)
		btnQuitter.style_context.add_provider(bouton_css, Gtk::StyleProvider::PRIORITY_USER)
		btnAPropos.style_context.add_provider(bouton_css, Gtk::StyleProvider::PRIORITY_USER)

		main_menu.show_all
    end
  
end

