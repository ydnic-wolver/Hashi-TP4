require 'gtk3'

##
# Cette classe sert de layout de base pour la création de Menu.
#  Les classes héritantes peuvent ainsi implémenter les attributs en fonction de leurs besoins.
class MenuLayout 

    # Attribut correspondant au menu 
    attr_reader :menu 

    # Bouton du mode Facile
    attr_accessor :btn_facile
    
    # Bouton du mode Moyen
    attr_accessor :btn_moyen
    
    # Bouton du mode Difficile
    attr_accessor :btn_difficile

    # Tableau de bouton
    attr_accessor :tableauBtn

    # Attribut correspondant au fichier CSS
    attr_accessor :css_file

    
    # Constructeur du MenuLayout
    # * +path+ Chemin du fichier
    # * +title+ Titre du menu
    def initialize(path, title)

        main_window_res = "./Ressources/Glade/menu_selection.glade"
        @builder = Gtk::Builder.new
        @builder.add_from_file(main_window_res)

        @menu = @builder.get_object('main_window')
        @menu.set_title title
        @menu.signal_connect "destroy" do 
            Gtk.main_quit 
        end
        @menu.set_window_position Gtk::WindowPosition::CENTER

        allbtn = @builder.get_object('listbox')

        facile_box = @builder.get_object('facile_box')
        moyen_box= @builder.get_object('moyen_box')
        difficile_box= @builder.get_object('difficile_box')

        niveau = @builder.get_object('niveau')

        @btn_retour = @builder.get_object('btn_retour')
        @css_file = Gtk::CssProvider.new
        @css_file.load(data: <<-CSS)
                    @import url("css/style.css");
                CSS

         # #Bouton Retour cliqué
         @btn_retour.signal_connect('clicked'){
           	@menu.destroy
            MainMenu.new
            Gtk.main
        }

        @btn_facile = @builder.get_object('btn_facile')
        @btn_moyen = @builder.get_object('btn_moyen')
        @btn_difficile = @builder.get_object('btn_difficile')

        @btn_retour.style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)
        @menu.style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)
        @btn_facile.style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)
        @btn_moyen.style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)
        @btn_difficile.style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)

        
        facile_box.style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)
        moyen_box.style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)
        difficile_box.style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)


        @tableauBtn=Array.new(22)
        # "ListeNiveau"
        #Initialisation des boutons de niveau
        @tabfacile=[path+"/Facile/7x7_1.txt",path+"/Facile/7x7_2.txt",path+"/Facile/7x7_3.txt",path+"/Facile/10x7.txt",path+"/Facile/10x10.txt",path+"/Facile/12x12.txt",path+"/Facile/15x5.txt",path+"/Facile/12x12_1.txt"]
        @tabdimfacile=[7,7,7,7,7,7,10,7,10,10,12,12,15,5,12,12]
        @tabmoyen=[path+"/Moyen/7x7.txt",path+"/Moyen/8x8.txt",path+"/Moyen/10x7.txt",path+"/Moyen/10x10_2.txt",path+"/Moyen/10x10.txt",path+"/Moyen/12x12.txt",path+"/Moyen/15x5.txt"]
        @tabdimmoyen=[7,7,8,8,10,7,10,10,10,10,12,12,15,5]
        @tabdifficile=[path+"/Difficile/7x7.txt",path+"/Difficile/8x8.txt",path+"/Difficile/10x7.txt",path+"/Difficile/10x10.txt",path+"/Difficile/10X10_2.txt",path+"/Difficile/12x12.txt",path+"/Difficile/15x5.txt"]
        @tabdimdifficile=[7,7,8,8,10,7,10,10,10,10,12,12,15,5]
        dimfacile=0
        facile=0
        moyen=0
        dimmoyen=0
        difficile=0
        dimdifficile=0
        @tableauBtn.each_index{|z|
            if (z<8)
                x=@tabdimfacile[dimfacile]
                dimfacile+=1
                y=@tabdimfacile[dimfacile]
                dimfacile+=1
                niveaufacile=@tabfacile[facile]
                facile+=1
                @tableauBtn[z]= BoutonChoix.new(true,false,false,niveaufacile,x,y)
                @tableauBtn[z].set_path(niveaufacile)
                facile_box.add(@tableauBtn[z])
            elsif(z<15)
                x=@tabdimmoyen[dimmoyen]
                dimmoyen+=1
                y=@tabdimmoyen[dimmoyen]
                dimmoyen+=1
                niveaumoyen=@tabmoyen[moyen]
                moyen+=1
                @tableauBtn[z]= BoutonChoix.new(false,true,false,niveaumoyen,x,y)
                @tableauBtn[z].set_path(niveaumoyen)
                moyen_box.add(@tableauBtn[z])
            elsif(z<22)
                x=@tabdimdifficile[dimdifficile]
                dimdifficile+=1
                y=@tabdimdifficile[dimdifficile]
                dimdifficile+=1
                niveaudifficile=@tabdifficile[difficile]
                difficile+=1
                @tableauBtn[z]= BoutonChoix.new(false,false,true,niveaudifficile,x,y)
                @tableauBtn[z].set_path(niveaudifficile)
                difficile_box.add(@tableauBtn[z])
            end
            
            @tableauBtn[z].style_context.add_provider(@css_file, Gtk::StyleProvider::PRIORITY_USER)
            # allbtn.add(@tableauBtn[z])
        }

        facile_box.show_all
        moyen_box.show_all
        difficile_box.show_all
        
        moyen_box.visible = false
        difficile_box.visible = false
        
        
        @btn_facile = @builder.get_object('btn_facile').signal_connect('clicked'){
          facile_box.visible = true
          moyen_box.visible = false
          difficile_box.visible = false
          niveau.from_file= "./Ressources/MenuSelection/facile.png"
        
        }
        @btn_moyen = @builder.get_object('btn_moyen').signal_connect('clicked'){
          facile_box.visible = false
          moyen_box.visible = true
          difficile_box.visible = false
          niveau.from_file= "./Ressources/MenuSelection/moyen.png"
        }
        @btn_difficile = @builder.get_object('btn_difficile').signal_connect('clicked'){
          facile_box.visible = false
          moyen_box.visible = false
          difficile_box.visible = true
          niveau.from_file= "./Ressources/MenuSelection/difficile.png"
          
        }

    end

end