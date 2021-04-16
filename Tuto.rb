require 'gtk3'

$id=1


##
# Cette classe représente le menu Tutoriel
class Tuto 

	def initialize
		
		main_window_res = "./Ressources/Glade/tutoriel.glade"
        builder = Gtk::Builder.new
        builder.add_from_file(main_window_res)

        @tutoriel = builder.get_object('tutoriel')
		@tutoriel.set_title "Tutoriel"
        @tutoriel.signal_connect "destroy" do 
			@tutoriel.destroy
            Gtk.main_quit 
        end
		
        @tutoriel.set_window_position Gtk::WindowPosition::CENTER
        css_file = Gtk::CssProvider.new
        css_file.load(data: <<-CSS)
             @import url("css/tuto.css");
                CSS

		@box_tuto = builder.get_object('box_principale')
	

		# Creation et ajouts des boutons <- et -> du Tutoriel  #
		@btnGauche =  builder.get_object('btnGauche')
		@btnDroite =  builder.get_object('btnDroite')

		
		#--------------------------------------------#
		# Creation du bouton quitter du Tutoriel  #
		btnQuitter = builder.get_object('home')
		btnQuitter.signal_connect('clicked') {
			@tutoriel.destroy
			MainMenu.new	
			Gtk.main
		}

		#--------------------------------------------#
		# Lien entre le fichier css et les différents composants 

		@box_tuto.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
		@box_tuto.style_context.add_class('tuto_1')
		@btnDroite.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
		btnQuitter.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
		@btnGauche.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
		@tutoriel.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)

		j = 0
		@box_tuto.show_all
		
		@img_tuto = builder.get_object('img_tuto')
		@img_tuto.from_file = "./Ressources/Tuto/tuto_1.png"
		
		@btnGauche.signal_connect('clicked') do
			if $id > 1  && $id<=10
				$id-=1
				@img_tuto.from_file = "./Ressources/Tuto/tuto_"+$id.to_s+".png"
			end
		end

		@btnDroite.signal_connect('clicked') do
			if $id>=1 && $id<10
				$id+=1
				@img_tuto.from_file = "./Ressources/Tuto/tuto_"+$id.to_s+".png"
			end
		end

		@tutoriel.show

	end

end 
