
require 'gtk3'

##
# Cette classe représente l'affichage des résultats sur un niveau
##
class ClassementNiveau < Gtk::Window
    
	
	# Création du Classement par Niveau
	# * +nomniv+ Chemin du niveau
	def initialize(nomniv)
        super
		set_title "Classement Niveau " 
		set_resizable(true)
		signal_connect "destroy" do 
			self.destroy 
		end

		set_default_size 500, 400

		set_window_position Gtk::WindowPosition::CENTER
		
		#Creation de zone de texte
		texte = "<span font_desc = \"Toledo 20\">Resultats du Niveau :</span>\n"
		texte1 = "<span font_desc = \"Toledo 15\">(Temps):(Joueur)</span>\n"
		texte_0 =""

		boxMenu = Gtk::Box.new(:vertical, 6)

		preset = Gtk::Label.new()
		preset.set_markup(texte1)
		textTitle = Gtk::Label.new()
		textTitle.set_markup(texte)
		
		#Tri les lignes en fonctions des temps
		tab = File.read(nomniv).split("\n")
		tab = tab.sort_by{ |s| s.scan(/\d+/).first.to_i }
		
		#Inclu toutes les lignes du tableau tab dans une variable texte_0 pour être affiché dans une box
		tab.each.with_index do |line|
			texte_0 += "<span font_desc = 'Toledo 13'>#{line} </span>\n"
			end

		score = Gtk::Label.new()
		score.set_markup(texte_0)
			
		btnQuitter = Gtk::Button.new()
		btnQuitter.signal_connect('clicked'){self.destroy}
		btnQuitter.image = Gtk::Image.new(:file => "./Ressources/MenuSelection/back.png") 
		btnQuitter.halign =  Gtk::Align::CENTER
		btnQuitter.valign =  Gtk::Align::CENTER
		btnQuitter.always_show_image = true
		
		css_file = Gtk::CssProvider.new
		css_file.load(data: <<-CSS)
			button {
				all:unset;
			}

			button:hover {
				opacity: .6;
			}
			CSS

		btnQuitter.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
		
		btnScore = Gtk::Label

		#Affichage de toutes les box
		boxMenu.add(textTitle)
		boxMenu.add(preset)
		boxMenu.add(score)
		boxMenu.add(btnQuitter)

		add(boxMenu)

		show_all
    end
end
