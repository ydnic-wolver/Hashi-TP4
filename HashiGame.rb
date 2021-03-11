require 'gtk3'


class HashiGame 

    # Plateau de jeu contenant les Iles et les Ponts
    attr_accessor :plateau

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
            btn = Noeud::new(ch,index,i)
            # On attache la référence de la grille
            btn.attach(grid)
            btn.hover
            # if( ch != '0')
            #     grid.attachNode(btn)
            # end
        
            grid.attach(btn, index,i, 1,1)
        end
    
    end

    end

end