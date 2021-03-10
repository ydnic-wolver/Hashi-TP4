require 'gtk3'

class ClassementNiveau < Gtk::Window
    def initialize
        super
	set_title "Classement Par Niveau"
	set_resizable(true)

	set_default_size 500, 400

	set_window_position Gtk::WindowPosition::CENTER
	
	texte = "<span font_desc = \"Verdana 20\">Classement par Niveau:</span>\n"

	boxMenu = Gtk::Table.new(13,9,true)
	
	textTitle = Gtk::Label.new()
	textTitle.set_markup(texte)
	btnNiveau1 = Gtk::Button.new(:label => 'Niveau 1')
	btnNiveau2 = Gtk::Button.new(:label => 'Niveau 2')
	btnNiveau3 = Gtk::Button.new(:label => 'Niveau 3')
	btnNiveau4 = Gtk::Button.new(:label => 'Niveau 4')
	btnNiveau5 = Gtk::Button.new(:label => 'Niveau 5')
	btnNiveau6 = Gtk::Button.new(:label => 'Niveau 6')
	btnNiveau7 = Gtk::Button.new(:label => 'Niveau 7')
	btnNiveau8 = Gtk::Button.new(:label => 'Niveau 8')
	btnQuitter = Gtk::Button.new(:label => 'Retour')

	btnQuitter.signal_connect('clicked'){
		self.destroy
		Classement.new
	}
	

	boxMenu.attach(textTitle, 0,9,0,4)
	boxMenu.attach(btnNiveau1, 1,4,4,5)

	boxMenu.attach(btnNiveau2, 1,4,6,7)

	boxMenu.attach(btnNiveau3, 1,4,8,9)
	
	boxMenu.attach(btnNiveau4, 1,4,10,11)

	boxMenu.attach(btnNiveau5, 5,8,4,5)	
	
	boxMenu.attach(btnNiveau6, 5,8,6,7)
	
	boxMenu.attach(btnNiveau7, 5,8,8,9)
	
	boxMenu.attach(btnNiveau8, 5,8,10,11)
	


	boxMenu.attach(btnQuitter, 1,2,1,2)

	add(boxMenu)

	show_all
    end
end
