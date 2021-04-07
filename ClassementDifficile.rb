##
# Cette classe représente l'interface des Classements de niveaux Difficiles
##
require 'gtk3'

class ClassementDifficile < Gtk::Window
    def initialize
        super
	set_title "Classement Difficile"
	set_resizable(true)
	signal_connect "destroy" do 
		self.destroy 
	end

	set_default_size 500, 400

	set_window_position Gtk::WindowPosition::CENTER
	
	texte = "<span font_desc = \"Verdana 20\">Classement :</span>\n"

	# Represente tout les boutons pour accéder aux différents niveaux
	boxMenu = Gtk::Table.new(16,4,true)
	
	textTitle = Gtk::Label.new()
	textTitle.set_markup(texte)
	btnNiveau1 = Gtk::Button.new(:label => 'Niveau 1')
	btnNiveau1.signal_connect('clicked'){
		self.set_sensitive(false)
		File.open("Classement/Facile/classement7x7.txt", 'a')
		classement = ClassementNiveau.new("Classement/Hard/classement7x7.txt")
		self.set_sensitive(true)
	}
	btnNiveau2 = Gtk::Button.new(:label => 'Niveau 2')
	btnNiveau2.signal_connect('clicked'){
		self.set_sensitive(false)
		File.open("Classement/Facile/classement8x8.txt", 'a')
		classement = ClassementNiveau.new("Classement/Hard/classement8x8.txt")
		self.set_sensitive(true)
	}
	btnNiveau3 = Gtk::Button.new(:label => 'Niveau 3')
	btnNiveau3.signal_connect('clicked'){
		self.set_sensitive(false)
		File.open("Classement/Facile/classement10x7.txt", 'a')
		classement = ClassementNiveau.new("Classement/Hard/classement10x7.txt")
		self.set_sensitive(true)
	}
	btnNiveau4 = Gtk::Button.new(:label => 'Niveau 4')
	btnNiveau4.signal_connect('clicked'){
		self.set_sensitive(false)
		File.open("Classement/Facile/classement10x10.txt", 'a')
		classement = ClassementNiveau.new("Classement/Hard/classement10x10.txt")
		self.set_sensitive(true)
	}
	btnNiveau5 = Gtk::Button.new(:label => 'Niveau 5')
	btnNiveau5.signal_connect('clicked'){
		self.set_sensitive(false)
		File.open("Classement/Facile/classement10x10_2.txt", 'a')
		classement = ClassementNiveau.new("Classement/Hard/classement10x10_2.txt")
		self.set_sensitive(true)
	}
	btnNiveau6 = Gtk::Button.new(:label => 'Niveau 6')
	btnNiveau6.signal_connect('clicked'){
		self.set_sensitive(false)
		File.open("Classement/Facile/classement12x12.txt", 'a')
		classement = ClassementNiveau.new("Classement/Hard/classement12x12.txt")
		self.set_sensitive(true)
	}
	btnNiveau7 = Gtk::Button.new(:label => 'Niveau 7')
	btnNiveau7.signal_connect('clicked'){
		self.set_sensitive(false)
		File.open("Classement/Facile/classement15x5.txt", 'a')
		classement = ClassementNiveau.new("Classement/Hard/classement15x5.txt")
		self.set_sensitive(true)
	}
	btnQuitter = Gtk::Button.new(:label => 'Retour')
	btnQuitter.signal_connect('clicked'){
		self.destroy
		MainMenu.new
	}

	
	btnQuitter.signal_connect('clicked'){self.destroy}
	
	#Affichage de toutes les box
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