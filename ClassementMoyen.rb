require 'gtk3'

class ClassementMoyen < Gtk::Window
    def initialize
        super
	set_title "Classement Moyen"
	set_resizable(true)
	signal_connect "destroy" do 
		self.destroy 
	end

	set_default_size 500, 400

	set_window_position Gtk::WindowPosition::CENTER
	
	texte = "<span font_desc = \"Verdana 20\">Classement :</span>\n"

	boxMenu = Gtk::Table.new(16,4,true)
	
	textTitle = Gtk::Label.new()
	textTitle.set_markup(texte)
	btnNiveau1 = Gtk::Button.new(:label => 'Niveau 1')
	btnNiveau1.signal_connect('clicked'){
		self.set_sensitive(false)
		classement = ClassementNiveau.new("Classement/Moyen/classement10x7_1.txt")
		self.set_sensitive(true)
	}
	btnNiveau2 = Gtk::Button.new(:label => 'Niveau 2')
	btnNiveau2.signal_connect('clicked'){
		self.set_sensitive(false)
		classement = ClassementNiveau.new("Classement/Moyen/classement10x10_2.txt")
		self.set_sensitive(true)
	}
	btnNiveau3 = Gtk::Button.new(:label => 'Niveau 3')
	btnNiveau3.signal_connect('clicked'){
		self.set_sensitive(false)
		classement = ClassementNiveau.new("Classement/Moyen/classement10x10.txt.txt")
		self.set_sensitive(true)
	}
	btnNiveau4 = Gtk::Button.new(:label => 'Niveau 4')
	btnNiveau4.signal_connect('clicked'){
		self.set_sensitive(false)
		classement = ClassementNiveau.new("Classement/Moyen/classement12x12.txt")
		self.set_sensitive(true)
	}
	btnNiveau5 = Gtk::Button.new(:label => 'Niveau 5')
	btnNiveau5.signal_connect('clicked'){
		self.set_sensitive(false)
		classement = ClassementNiveau.new("Classement/Moyen/classement15x5.txt")
		self.set_sensitive(true)
	}
	btnNiveau6 = Gtk::Button.new(:label => 'Niveau 6')
	btnNiveau6.signal_connect('clicked'){
		self.set_sensitive(false)
		classement = ClassementNiveau.new("Classement/Moyen/classement15x15_2.txt")
		self.set_sensitive(true)
	}
	btnNiveau7 = Gtk::Button.new(:label => 'Niveau 7')
	btnNiveau7.signal_connect('clicked'){
		self.set_sensitive(false)
		classement = ClassementNiveau.new("Classement/Moyen/classement15x5.txt")
		self.set_sensitive(true)
	}
	btnQuitter = Gtk::Button.new(:label => 'Retour')

	btnQuitter.signal_connect('clicked'){self.destroy}
	

	boxMenu.attach(textTitle, 0,4,1,4)
	boxMenu.attach(btnNiveau1, 1,2,4,5)

	boxMenu.attach(btnNiveau2, 1,2,6,7)

	boxMenu.attach(btnNiveau3, 1,2,8,9)
	
	boxMenu.attach(btnNiveau4, 1,2,10,11)

	boxMenu.attach(btnNiveau5, 2,3,4,5)	
	
	boxMenu.attach(btnNiveau6, 2,3,6,7)
	
	boxMenu.attach(btnNiveau7, 2,3,8,9)
	
	


	boxMenu.attach(btnQuitter, 1,3,12,13)

	add(boxMenu)

	show_all
    end
end