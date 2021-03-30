require 'gtk3'


class APropos < Gtk::Window
    def initialize
        super

	set_title "A Propos"
	set_resizable(true)
	signal_connect "destroy" do 
		self.destroy
	end

	set_default_size 500, 400

	set_window_position Gtk::WindowPosition::CENTER
	
	title = "<span font_desc = \"Verdana 40\">A Propos</span>\n"
	
	texte = "<span font_desc = \"Calibri 10\">Créé par les plus beaux : \n Aaron Amani \n Axel Jourry  \n Clement Janvier  \n Cindy Calvados  \n Collins Soares  \n Florian Dreux  \n Rayyan Lajnef  \n Thomas Malabry  \n Willhem Liban </span>\n"
	
	boxMenu = Gtk::Table.new(15,3,true)
	
	textTitle = Gtk::Label.new("A Propos")
	textTitle.set_markup(title)
	textTitle.set_justify(Gtk::JUSTIFY_CENTER)
	
	textepro = Gtk::Label.new()
	textepro.set_markup(texte)
	textepro.set_justify(Gtk::JUSTIFY_CENTER)

	btnRetour = Gtk::Button.new(:label => 'Retour')
	btnRetour.signal_connect('clicked'){
		
		self.destroy
		MainMenu.new	
	}
	boxMenu.attach(textTitle, 0,3,1,4)
	boxMenu.attach(textepro, 1,2,4,10)
	boxMenu.attach(btnRetour,1,2,13,14)
	

	add(boxMenu)

	show_all
    end
end
