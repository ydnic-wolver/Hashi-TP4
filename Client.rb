
load "Pause.rb"
load "Pont.rb"
load "HashiGrid.rb"
load "Ile.rb"
load 'Plateau.rb'
load "APropos.rb"
load "Classement.rb"
load "MenuSelection.rb"
load "Tuto.rb"
load 'BoutonChoix.rb'
load 'MainMenu.rb'


window = MainMenu.new

nom = "ListeNiveau/niveau_facile/7x7_1.txt"

# titre = nom.match(/[^\/]*.txt/)


Gtk.main
