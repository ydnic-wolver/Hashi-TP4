require 'gtk3'

##
# Cette classe représente le menu A Propos
class APropos < Gtk::Window

	# Constructeur du menu A propos
    def initialize
        super

	set_title "A Propos"
	set_resizable(true)
	signal_connect "destroy" do 
		self.destroy
	end

	set_default_size 500, 400

	set_window_position Gtk::WindowPosition::CENTER
	
	title = "<span font_desc = \"Toledo 30\">A Propos</span>\n"
	texte = "<span font_desc = \"Toledo 15\">Créé par les plus beaux : \n Aaron Amani \n Axel Jourry  \n Clement Janvier  \n Cindy Calvados  \n Collins Soares  \n Florian Dreux  \n Rayyan Lajnef  \n Thomas Malabry  \n Willhem Liban </span>\n"
	
	boxMenu = Gtk::Box.new(:vertical, 6)
	
	textTitle = Gtk::Label.new("A Propos")
	textTitle.set_markup(title)
	textTitle.set_justify(Gtk::JUSTIFY_CENTER)
	
	textepro = Gtk::Label.new()
	textepro.set_markup(texte)
	textepro.set_justify(Gtk::JUSTIFY_CENTER)

	# Creation d'un nouveau fichier permettant de gérer le CSS
	css_file = Gtk::CssProvider.new
	css_file.load(data: <<-CSS)
		.about {
			background-color: #F8DDD7;
		}
		CSS

	# Ajout de la classe CSS a la box
	boxMenu.style_context.add_class('about')
	# Lien entre la box et le fichier css afin que le css puisse être appliqué
	boxMenu.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)

	boxMenu.add(textTitle)
	boxMenu.add(textepro)
	
	add(boxMenu)

	show_all
    end
end
