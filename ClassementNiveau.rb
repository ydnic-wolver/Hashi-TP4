require 'gtk3'

class ClassementNiveau < Gtk::Window
    def initialize
        super
	set_title "Classement Niveau " " "
	set_resizable(true)
	signal_connect "destroy" do 
		self.destroy 
	end

	set_default_size 500, 400

	set_window_position Gtk::WindowPosition::CENTER
	
	texte = "<span font_desc = \"Verdana 20\">Resultats du Niveau :</span>\n"

	boxMenu = Gtk::Table.new(16,4,true)
	
	textTitle = Gtk::Label.new()
	textTitle.set_markup(texte)
	
    btnQuitter = Gtk::Button.new(:label => 'Retour')
	btnQuitter.signal_connect('clicked'){self.destroy}
	

	boxMenu.attach(textTitle, 0,4,1,4)
	
	


	boxMenu.attach(btnQuitter, 1,3,12,13)

	add(boxMenu)

	show_all
    end
end
