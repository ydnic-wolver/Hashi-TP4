require 'gtk3'

##
# Représentation du Menu de Selection de Niveau qui hérite de la classe Window de Gtk
##
class MenuSelection < Gtk::Window
    def initialize
        super
        set_title "Selection du plateau"

        signal_connect "destroy" do 
            Gtk.main_quit
        end
        
        set_default_size 500, 400
        set_border_width 5
        
        set_window_position Gtk::WindowPosition::CENTER

        #Initialisation des différents blocs composant le fenêtre
        boxHaut = Gtk::HBox.new(:horizontal, 7)
        
        boxMenu = Gtk::HBox.new(:horizontal, 9)
        boxPrincipal=Gtk::VBox.new(:vertical, 9)
        swindow = Gtk::ScrolledWindow.new
        allbtn = Gtk::VBox.new(:vertical, 1)
        easybtn=Gtk::VBox.new(:vertical,1)
        moyenbtn=Gtk::VBox.new(:vertical,1)
        hardbtn=Gtk::VBox.new(:vertical,1)
        seasywindow=Gtk::ScrolledWindow.new
        smoyenwindow=Gtk::ScrolledWindow.new
        shardwindow=Gtk::ScrolledWindow.new        
        #4 bouton en haut de la fenêtre
        #Creation bouton facile
        btnFacile = Gtk::Button.new()
        btnFacile.image = Gtk::Image.new(:file => "Ressources/MenuSelection/etoileFacile.png") 

        #Creation bouton moyen
        btnMoyen = Gtk::Button.new()
        btnMoyen.image = Gtk::Image.new(:file => "Ressources/MenuSelection/etoileMoyen.png") 

        btnHard = Gtk::Button.new()
        btnHard.image = Gtk::Image.new(:file => "Ressources/MenuSelection/etoileDiff.png") 

        #Création du bouton retour 
        btnRetour = Gtk::Button.new()
        btnRetour.image = Gtk::Image.new(:file => "Ressources/MenuSelection/retour.png") 

        #Initialisation des boutons de niveau
        tableauBtn=Array.new(22)
        tabfacile=["ListeNiveau/niveau_facile/7x7_1.txt","ListeNiveau/niveau_facile/7x7_2.txt","ListeNiveau/niveau_facile/7x7_3.txt","ListeNiveau/niveau_facile/10x7.txt","ListeNiveau/niveau_facile/10x10.txt","ListeNiveau/niveau_facile/12x12.txt","ListeNiveau/niveau_facile/15x5.txt","ListeNiveau/niveau_facile/15x15.txt"]
        tabdimfacile=[7,7,7,7,7,7,10,7,10,10,12,12,15,5,15,15]
        tabmoyen=["ListeNiveau/niveau_moyen/7x7.txt","ListeNiveau/niveau_moyen/8x8.txt","ListeNiveau/niveau_moyen/10x7.txt","ListeNiveau/niveau_moyen/10x10_2.txt","ListeNiveau/niveau_moyen/10x10.txt","ListeNiveau/niveau_moyen/12x12.txt","ListeNiveau/niveau_moyen/15x5.txt"]
        tabdimmoyen=[7,7,8,8,10,7,10,10,10,10,12,12,15,5]
        tabdifficile=["ListeNiveau/niveau_difficile/7x7.txt","ListeNiveau/niveau_difficile/8x8.txt","ListeNiveau/niveau_difficile/10x7.txt","ListeNiveau/niveau_difficile/10x10.txt","ListeNiveau/niveau_difficile/10X10_2.txt","ListeNiveau/niveau_difficile/12x12.txt","ListeNiveau/niveau_difficile/15x5.txt"]
        tabdimdifficile=[7,7,8,8,10,7,10,10,10,10,12,12,15,5]
        dimfacile=0
        facile=0
        moyen=0
        dimmoyen=0
        difficile=0
        dimdifficile=0
        tableauBtn.each_index{|z|
            if (z<8)
                x=tabdimfacile[dimfacile]
                dimfacile+=1
                y=tabdimfacile[dimfacile]
                dimfacile+=1
                niveaufacile=tabfacile[facile]
                facile+=1
                tableauBtn[z]= BoutonChoix.new(true,false,false,niveaufacile,x,y)
            elsif(z<15)
                x=tabdimmoyen[dimmoyen]
                dimmoyen+=1
                y=tabdimmoyen[dimmoyen]
                dimmoyen+=1
                niveaumoyen=tabmoyen[moyen]
                moyen+=1
                tableauBtn[z]= BoutonChoix.new(false,true,false,niveaumoyen,x,y)
            elsif(z<22)
                x=tabdimdifficile[dimdifficile]
                dimdifficile+=1
                y=tabdimdifficile[dimdifficile]
                dimdifficile+=1
                niveaudifficile=tabdifficile[difficile]
                difficile+=1
                tableauBtn[z]= BoutonChoix.new(false,false,true,niveaudifficile,x,y)
            end
            allbtn.add(tableauBtn[z])
        }


        
        swindow.add(allbtn)
        boxHaut.add(btnRetour)
        boxHaut.add(btnFacile)
        boxHaut.add(btnMoyen)
        boxHaut.add(btnHard)
        
        boxHaut.set_border_width(10)
        
        boxPrincipal.add(boxHaut)
        
        
        boxMenu.add(swindow)
        boxMenu.set_border_width(10)
        
        boxPrincipal.add(boxMenu)
        easy=1
        moyen=1
        hard=1
        #Utilisation des boutons FACILE/MOYEN/DIFFICILE
        faciledo=1
        moyendo=1
        hardo=1

        #Utilisation du bouton facile
        btnFacile.signal_connect('clicked'){
            compteur=0
            if(easy==1)
                #Si cela n'a pas encore déjà été fait on met tous les boutons facile dans un bloc qui scroll
                if(faciledo==1)
                    while(compteur<22)
                        if(tableauBtn[compteur].isFacile?)
                            allbtn.remove(tableauBtn[compteur])
                            easybtn.add(tableauBtn[compteur])
                        end
                        compteur+=1
                    end
                    faciledo=0
                    seasywindow.add(easybtn)
                end
                #Puis on ajoute le bloc à la fenêtre
                if(moyen==0)
                    boxMenu.remove(smoyenwindow)
                    boxMenu.add(seasywindow)
                elsif(hard==0)
                    boxMenu.remove(shardwindow)
                    boxMenu.add(seasywindow)
                else 
                    boxMenu.remove(swindow)
                    boxMenu.add(seasywindow)
                end
                easy=0
                moyen=1
                hard=1
                show_all
            end
        }
        #Utilisation du bouton Moyen
        btnMoyen.signal_connect('clicked'){
            compteur=0
            if(moyen==1)
                #Si cela n'a pas encore déjà été fait on met tous les boutons moyen dans un bloc qui scroll
                if(moyendo==1)
                    while(compteur<22)
                        if(tableauBtn[compteur].isMoyen?)
                            allbtn.remove(tableauBtn[compteur])
                            moyenbtn.add(tableauBtn[compteur])
                        end
                        compteur+=1
                    end
                    moyendo=0
                    smoyenwindow.add(moyenbtn)
                end
                #Puis on ajoute le bloc à la fenêtre
                if(easy==0)
                    boxMenu.remove(seasywindow)
                    boxMenu.add(smoyenwindow)
                elsif(hard==0)
                    boxMenu.remove(shardwindow)
                    boxMenu.add(smoyenwindow)
                else 
                    boxMenu.remove(swindow)
                    boxMenu.add(smoyenwindow)
                end
                easy=1
                moyen=0
                hard=1
                show_all
            end
        }
        #Utilisation du bouton Difficile
        btnHard.signal_connect('clicked'){
            compteur=0
            if(hard==1)
                #Si cela n'a pas encore déjà été fait on met tous les boutons hard dans un bloc qui scroll
                if(hardo==1)
                    while(compteur<22)
                        if(tableauBtn[compteur].isHard?)
                            allbtn.remove(tableauBtn[compteur])
                            hardbtn.add(tableauBtn[compteur])
                        end
                        compteur+=1
                    end
                    hardo=0
                    shardwindow.add(hardbtn)
                end
                #Puis on ajoute le bloc à la fenêtre
                if(easy==0)
                    boxMenu.remove(seasywindow)
                    boxMenu.add(shardwindow)
                elsif(moyen==0)
                    boxMenu.remove(smoyenwindow)
                    boxMenu.add(shardwindow)
                else 
                    boxMenu.remove(swindow)
                    boxMenu.add(shardwindow)
                end
                easy=1
                moyen=1
                hard=0
                show_all
            end
        }
        #Bouton Lien entre Menu Selection et chaque plateau
        tableauBtn.each_index{|x| tableauBtn[x].signal_connect('clicked'){
                window=Gtk::Window.new()
                window.set_title "Chargement"
                window.set_resizable(true)
                window.set_default_size 300, 300
                window.set_window_position Gtk::WindowPosition::CENTER
                window.signal_connect "destroy" do 
                window.destroy
                end
                pVBox = Gtk::Box.new(:vertical, 25)
                title = "<span font_desc = \"Verdana 40\">Chargement</span>\n"
                textTitle = Gtk::Label.new()
                textTitle.set_markup(title)
                textTitle.set_justify(Gtk::Justification::CENTER)
                btnLancer = Gtk::Button.new(:label => 'Nouvelle Partie')
                btnSave = Gtk::Button.new(:label => 'Charger une Partie')
                btnLancer.signal_connect('clicked'){
                    window.destroy
                    self.destroy
                    $window = Plateau.new(tableauBtn[x].getNiveau,tableauBtn[x].getY,tableauBtn[x].getX)
                    Gtk.main
                }
                btnRetourcharg = Gtk::Button.new(:label => 'Retour')
                btnRetourcharg.signal_connect('clicked'){
                    window.destroy
                }
                pVBox.add(textTitle)
                pVBox.add(btnLancer)
                pVBox.add(btnSave)
                pVBox.add(btnRetourcharg)
                window.add(pVBox)
                window.show_all
            }   
        }
        
        
        
        #Bouton Retour cliqué
        btnRetour.signal_connect('clicked'){
           	self.destroy
            MainMenu.new
            Gtk.main
        }
        add(boxPrincipal)

        show_all
    end
end
