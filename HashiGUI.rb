require 'gtk3'

load "HashiGrid.rb"
load "HashiGame.rb"


class HashiGUI < Gtk::Window

    attr_accessor :jeu 

    # GTK:Grid contenant les Gtk::Button
    attr_accessor :grid 
    
    
    def initialize 

        super()
        # Titre de la fenêtre
        self.set_title("Game")
        # Taille de la fenêtre
        self.set_default_size(500,600)
        self.signal_connect("destroy") { Gtk.main_quit}
        # Réglage de la bordure
        self.border_width=10
        # On peut redimensionner
        self.set_resizable(false)
        # L'application est toujours centrée
        self.set_window_position(:center_always)

        grid = HashiGrid.new 
        grid.set_column_homogeneous(true)
        grid.set_row_homogeneous(true)

        #  Chargement de la grille
        loadGrid(grid)

        grid.each{ |btn| btn.loadNeighbours }

        self.add( grid )

        self.show_all   

    end


end