
load 'MainMenu.rb'
load "APropos.rb"
load "Classement.rb"
load "MenuSelection.rb"
load "Tuto.rb"
load 'BoutonChoix.rb'
load "Pause.rb"
load 'Plateau.rb'


# window = MainMenu.new

$window = Plateau.new

Gtk.main
