require 'gtk3'


require 'gtk3'

load "HashiGrid.rb"
load "Noeud.rb"

class HashiGame < Gtk::Window

    # GTK:Grid contenant les Gtk::Button
    attr_accessor :grid 

    attr_accessor :colonnes

    attr_accessor :lignes
    
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

        @grid = HashiGrid.new 
        @grid.set_column_homogeneous(true)
        @grid.set_row_homogeneous(true)

        #  Chargement de la grille
        loadGrid()

        grid.set_colonnes( @colonnes )
        grid.set_lignes( @lignes )

        grid.each{ |btn| btn.loadNeighbours }

        self.add( @grid )

        self.show_all   

    end

    def loadNeighbours
       
        for x in 0..(@grid.lignes)
            p "ok"
        end
        # for x in 0..(@grid.lignes-1)
        #     for y in 0..(@grid.colonnes-1)
        #         if (@grid.get_child_at(x,y).status == 'i')

        #             # k = @grid.get_child(x,y).row - 1  #HAUT
        #             # until k <= 0
        #             #     newCase = @gridRef.get_child_at(@grid.get_child(x,y).column,k)
        #             #     if newCase.status == 'i' && newCase.row != @row
        #             #         @northNode = newCase
        #             #         break;
        #             #     end
        #             #     k -=1
        #             # end

                    
        #             for y2 in (y - 1)..0
        #                 if (@grid.get_child_at(x,y2).status == 'i')
        #                     puts "NORTH"
        #                     @grid.get_child_at(x,y).northNode(@grid.get_child_at(x,y2))
        #                     y2 = -1;
        #                 end
        #             end
        #         end
                   
        #     end        
        # end
    end

    # Chargement d'une grille
    def loadGrid()
        data = []
        File.foreach('file.txt').with_index do |line, line_no|
            data << line.chomp
        end
        # Slice permet de récupérer la taille de la matrice 
        # tel que 7:7
        num = data.slice!(0)
        @colonnes = num[0].to_i
        @lignes = num[2].to_i

        

        # Parcours des données récupérés afin de charger
        # les boutons
        for i in 0..(data.length() - 1) 
            data[i].split(':').each_with_index do | ch, index| 
                # # Création d'une case 
                btn = Noeud::new(@grid, ch,index,i)
                # On attache la référence de la grille
                btn.hover
                # if( ch != '0')
                #     grid.attachNode(btn)
                # end
                @grid.attach(btn, index,i, 1,1)
            end
        end
    end
end