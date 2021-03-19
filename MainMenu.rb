require 'gtk3'

class MainMenu < Gtk::Window
    def initialize
        super

  provider = Gtk::CssProvider.new
  provider.load(data: <<-CSS)
  
window {
  background-color: #5c5c5d;
}

button {
	background-color: #383838;
	background-image: none;
	border-color:#383838;
  font-family: Brush Script MT, Brush Script Std, cursive;
  font-size: 23px;
}


label {
  color: #FFFFFF;
}

  CSS
  Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,
                                            provider,
                                            Gtk::StyleProvider::PRIORITY_APPLICATION)

		set_title "Hashi Game"
		set_resizable(true)
		signal_connect "destroy" do 
			Gtk.main_quit 
		end

		set_default_size 500, 400

		set_window_position Gtk::WindowPosition::CENTER
		
		texte = "<span font_desc = \"Brush Script MT, Brush Script Std, cursive 60\">Hashi Game</span>\n"

		boxMenu = Gtk::Table.new(15,3,true)	
		
		textTitle = Gtk::Label.new("Hashi Game")
		textTitle.set_markup(texte)
		btnSelection = Gtk::Button.new(:label => 'Selection du niveau')
		btnSelection.signal_connect('clicked'){
		
			MenuSelection.new
			self.destroy
			Gtk.main
		}
		btnTuto = Gtk::Button.new(:label => 'Tutoriel')
		btnTuto.signal_connect('clicked'){
			Tuto.new
			self.destroy
			Gtk.main
		}
		btnClassement = Gtk::Button.new(:label => 'Classement')
		btnClassement.signal_connect('clicked'){
		
			Classement.new
			self.destroy
			Gtk.main

		}
		btnAPropos = Gtk::Button.new(:label => 'A propos')
		btnAPropos.signal_connect('clicked'){
		
			APropos.new
			self.destroy
			Gtk.main
		}

		btnQuitter = Gtk::Button.new(:label => 'Quitter')
		btnQuitter.signal_connect('clicked'){Gtk.main_quit}
		

		boxMenu.attach(textTitle, 0,3,1,4)
		boxMenu.attach(btnSelection, 1,2,4,5)

		boxMenu.attach(btnTuto, 1,2,6,7)

		boxMenu.attach(btnClassement, 1,2,8,9)

		boxMenu.attach(btnAPropos, 1,2,10,11)

		boxMenu.attach(btnQuitter, 1,2,12,13)
		


		add(boxMenu)

		show_all
    end
end
