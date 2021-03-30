require 'gtk3'

class MainMenu < Gtk::Window

	
    def initialize
        super
		
		set_title "Hashi Game"
		set_resizable(true)
		signal_connect "destroy" do 
			Gtk.main_quit 
		end
		provider = Gtk::CssProvider.new

		if $dark_mode == true
			provider.load(path: "dark_mode.css")
		elsif $dark_mode == false
			provider.load(path: "style.css")
		
		end
		
		Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
		
		set_default_size 580, 520
		set_window_position Gtk::WindowPosition::CENTER
		
		texte = "<span font_desc = \"Brush Script MT, Brush Script Std, cursive 60\">Hashi Game</span>\n"

		boxMenu = Gtk::Table.new(15,3,true)	
		
		textTitle = Gtk::Label.new("Hashi Game")
		textTitle.set_markup(texte)
		btnSelection = Gtk::Button.new(:label => 'Selection du niveau')
		btnSelection.signal_connect('clicked'){
		
			MenuSelection.new
			self.destroy
			Gtk.main
		}
		btnTuto = Gtk::Button.new(:label => 'Tutoriel')
		btnTuto.signal_connect('clicked'){
			Tuto.new
			self.destroy
			Gtk.main
		}
		btnClassement = Gtk::Button.new(:label => 'Classement')
		btnClassement.signal_connect('clicked'){
		
			Classement.new
			self.destroy
			Gtk.main

		}
		btnAPropos = Gtk::Button.new(:label => 'A propos')
		btnAPropos.signal_connect('clicked'){
		
			APropos.new
			self.destroy
			Gtk.main
		}
		
		btnQuitter = Gtk::Button.new(:label => 'Quitter')
		btnQuitter.signal_connect('clicked'){Gtk.main_quit}
		
		switch = Gtk::Switch.new
	
        switch.signal_connect('notify::active') { |s| on_switch_activated s }
  
        switch.active = $dark_mode
        switch.halign = :center
        
        texte1 = "\n<span font_desc = \"Brush Script MT, Brush Script Std, cursive 13\">Mode Sombre</span>"

    		lab_lumi = Gtk::Label.new()
   		lab_lumi.set_markup(texte1)
   		lab_lumi.halign =:fill
    		
		boxMenu.attach(textTitle, 0,3,1,4)
		boxMenu.attach(btnSelection, 1,2,4,5)
		boxMenu.attach(btnTuto, 1,2,6,7)
		boxMenu.attach(btnClassement, 1,2,8,9)
		boxMenu.attach(btnAPropos, 1,2,10,11)
		boxMenu.attach(lab_lumi,2,3,11,12)
		boxMenu.attach(switch, 2,3,12,13)
		boxMenu.attach(btnQuitter, 1,2,12,13)
		
		


		add(boxMenu)

		show_all
    end
    
    def on_switch_activated(switch)
			provider = Gtk::CssProvider.new
		  if switch.active?
		  	$dark_mode = true 
		  	provider.load(path: "dark_mode.css")
		  	
		  else
		  	$dark_mode = false
		  	provider.load(path: "style.css")
		  	
		  end
		  Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default,provider, Gtk::StyleProvider::PRIORITY_APPLICATION)

 	end
end