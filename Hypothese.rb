require 'gtk3'

load 'HashiGrid.rb'

##
# Cette classe représente le mode Hypothèse
# Elle est responsable de la création du mode hypothèse
#   - Créer une copie du plateau courant
class Hypothese

    # $window        -> la fenêtre contenant le plateau de jeu

    # Constructeur du mode hypothèse
    # * +plateau+ Référence sur le plateau de jeu
    def initialize(plateau)
		
        main_window_res = "./Ressources/Glade/hypo.glade"
        builder = Gtk::Builder.new
        builder.add_from_file(main_window_res)

        hypo = builder.get_object('hypo')
        hypo.set_title "Hypothèse"
        hypo.signal_connect "destroy" do 
            hypo.destroy
            plateau.getPlateau().set_sensitive(true)
            
        end
        hypo.set_window_position Gtk::WindowPosition::CENTER
        css_file = Gtk::CssProvider.new
    
        css_file.load(data: <<-CSS)
            button {
                all:unset;
            }

            button:hover {
                opacity: .6;
            }
            
            .bg-hypo {
                background-color: #F8DDD7;
            }

                CSS

       

        # #Reglage du bouton Undo
        boutonUndo = builder.get_object('btnUndo')
      
        # #Reglage du bouton Redo
        boutonRedo = builder.get_object('btnRedo')

        # #Initialisation de la grille
        # # Copie des noeuds contenus dans la grille
        copy_grille = plateau.grid.collect(&:dup)
        
        
        # # Création d'une nouvelle grille
        @hypoGrille = HashiGrid.new(plateau.grid.nomniv, @diff, plateau.grid.lignes, plateau.grid.colonnes)
        @hypoGrille.set_column_homogeneous(true)
        @hypoGrille.set_row_homogeneous(true)
        @hypoGrille.colonnes = plateau.grid.colonnes
        @hypoGrille.lignes = plateau.grid.lignes
        @hypoGrille.sommets = plateau.grid.sommets

        # # On parcourt le tableau des iles/ponts copiés
        copy_grille.each do |x| 
            # Si c'est une ile 
            # On copie les attributs de l'ile
            if x.status != 'p'
                btn = Ile.new(@hypoGrille,x.degreeMax.to_s,x.column,x.row)
                btn.degree = x.degree
                btn.estComplet = x.estComplet
                btn.northEdge = x.northEdge
                btn.southEdge = x.southEdge
                btn.westEdge = x.westEdge
                btn.eastEdge = x.eastEdge
                btn.update
            else 
                # Si c'est un pont on copie les attributs 
                # et on met à jour le pont 
                btn = Pont.new(@hypoGrille,x.column,x.row)
                btn.set_typePont( x.get_typePont )
                btn.estDouble = x.estDouble
                btn.set_directionPont ( x.get_directionPont )
                btn.update
            end
                # On attache la référence de la grille
                @hypoGrille.attach(btn, x.column,x.row, 1,1)
        end
        # # Chargement des voisins
        @hypoGrille.chargeVoisins

        boxJeu = builder.get_object('boxJeu')
        boxJeu.add(@hypoGrille)

      
        #Creation et affichage de la fenêtre principale
        boxPrincipale = builder.get_object('boxPrincipale')

        aide = Aide.new(@hypoGrille)
        label_aide = builder.get_object('label_indice')
        
        boutonIndice = builder.get_object('btnIndice')
        boutonIndice.signal_connect('clicked'){
            label_aide.set_label(aide.getMessageAide)
            boxPrincipale.show_all
        }

      
        btnValider = builder.get_object('btnValider')
        btnValider.signal_connect('clicked'){
            boxJeu.remove(@hypoGrille)
            plateau.hypotheseValider(@hypoGrille)
            hypo.destroy
            $window.getPlateau().set_sensitive(true)
        }

        btnAnnuler =  builder.get_object('btnAnnuler')
        btnAnnuler.signal_connect('clicked'){
            hypo.destroy
            $window.getPlateau().set_sensitive(true)
        }

        boutonUndo.signal_connect('clicked'){
            @hypoGrille.undoPrevious
        }

        boutonRedo.signal_connect('clicked'){
            @hypoGrille.redoPrevious
        }

        btnAnnuler.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        btnValider.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonUndo.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonIndice.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        boutonRedo.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
        hypo.style_context.add_provider(css_file, Gtk::StyleProvider::PRIORITY_USER)
       

        hypo.show_all
    end

end