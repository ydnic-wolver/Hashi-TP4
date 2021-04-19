
require 'gtk3'
load 'MenuLayout.rb'
load 'ClassementNiveau.rb'

##
# Cette classe représente le Classement
##
class Classement < MenuLayout

	# @menu       -> Variable contenant le menu, initialisé dans MenuLayout
	# @builder    -> Variable contenant les propriétés d'affichage, initialisé dans MenuLayout

	# Création du Classement
    def initialize
		super("Classement","Classement")

		image = @builder.get_object('logo-menu')
        image.from_file = "css/classement.png"

		# Lien entre le classement et chaque niveau
        tableauBtn.each_index{|x| tableauBtn[x].signal_connect('clicked'){
			@menu.set_sensitive(false)
			File.open(tableauBtn[x].path, 'a')
			classement = ClassementNiveau.new(tableauBtn[x].path)
			
			classement.style_context.add_class('menu-ext')
			classement.style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)
	
			classement.signal_connect('destroy') {
					@menu.set_sensitive(true)
			}
		}   
	}
		
	@menu.show
    end
end