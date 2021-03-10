require 'gtk3'

# Cette classe représente le plateau du jeu
# c'est dans cette classe que toute la logique du jeu va
#  s'articuler

require "gtk3"

load "Case.rb"
load "HashiGrid.rb"

hashi = Gtk::Window.new

# Titre de la fenêtre
hashi.set_title("TP Exercice 2-1")
# Taille de la fenêtre
hashi.set_default_size(500,600)
hashi.signal_connect("destroy") { Gtk.main_quit}
# Réglage de la bordure
hashi.border_width=10
# On peut redimensionner
hashi.set_resizable(false)
# L'application est toujours centrée
hashi.set_window_position(:center_always)


grille = Array.[]

# Chargement d'une grille
def loadGrid(grid)

        data = []
        File.foreach('file.txt').with_index do |line, line_no|
            data << line.chomp
        end
        # Slice permet de récupérer la taille de la matrice 
        # tel que 7:7
        num = data.slice!(0)
        grid.colonnes = num[0].to_i
        grid.lignes = num[1].to_i

        # Parcours des données récupérés afin de charger
        # les boutons
        for i in 0..(data.length() - 1) 
            data[i].split(':').each_with_index do | ch, index| 
           
            # Création d'une case 
            btn = Case::new(ch,index,i)
            # On attache la référence de la grille
            btn.attach(grid)

            btn.hover
            grid.attach(btn, index,i, 1,1)
        end
     
    end
end

grid = HashiGrid.new 
grid.set_column_homogeneous(true)
grid.set_row_homogeneous(true)

#  Chargement de la grille
loadGrid(grid)

hashi.add ( grid )

hashi.show_all

Gtk.main

