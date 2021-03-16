require 'gtk3'

load 'MainMenu.rb'
class Pause < Gtk::Window
    def initialize
        super
        set_title "En Pause"

        signal_connect "destroy" do
            $window.set_sensitive(TRUE)
            self.destroy
        end
        
        set_default_size 300, 200
        
        set_window_position Gtk::WindowPosition::CENTER

        logoPause = Gtk::Image.new(:file =>"Ressources/pauseLogo.png")

        boutonReprendre = Gtk::Button.new(:label =>"Reprendre")
        boutonReprendre.signal_connect('clicked'){
            $window.set_sensitive(TRUE)
            self.destroy
        }

        boutonRecommencer = Gtk::Button.new(:label =>"Recommencer")
        boutonQuitter = Gtk::Button.new(:label =>"Quitter")
	boutonQuitter.signal_connect('clicked'){
		self.destroy
		$window.destroy
		MainMenu.new
	}

        boxOption = Gtk::Box.new(:vertical, 6)

        boxOption.add(logoPause)
        boxOption.add(boutonReprendre)
        boxOption.add(boutonRecommencer)
        boxOption.add(boutonQuitter)
        

        add(boxOption)

        boxOption.set_border_width(30)

        show_all
    end
end
