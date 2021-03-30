require 'gtk3'

class ClassementNiveau < Gtk::Window
    def initialize(nomniv)
        super
	set_title "Classement Niveau " 
	set_resizable(true)
	signal_connect "destroy" do 
		self.destroy 
	end

	set_default_size 500, 400

	set_window_position Gtk::WindowPosition::CENTER
	
	texte = "<span font_desc = \"Verdana 20\">Resultats du Niveau :</span>\n"
	texte1 = "<span font_desc = \"Verdana 10\">(Temps):(Joueur)</span>\n"
	texte_0 =""
	boxMenu = Gtk::Table.new(16,4,true)

	preset = Gtk::Label.new()
	preset.set_markup(texte1)
	textTitle = Gtk::Label.new()
	textTitle.set_markup(texte)
	
	tab = File.read(nomniv).split("\n")
	tab = tab.sort_by{ |s| s.scan(/\d+/).first.to_i }
	
	tab.each.with_index do |line|
		texte_0 += "#{line} \n"
		end

	score = Gtk::Label.new()
	score.set_markup(texte_0)

    btnQuitter = Gtk::Button.new(:label => 'Retour')
	btnQuitter.signal_connect('clicked'){self.destroy}
	
	btnScore = Gtk::Label

	boxMenu.attach(textTitle, 0,4,1,4)
	boxMenu.attach(score,1,3,6,11)
	boxMenu.attach(preset,1,3,2,11)
	boxMenu.attach(btnQuitter, 1,3,12,13)

	add(boxMenu)

	show_all
    end
end
