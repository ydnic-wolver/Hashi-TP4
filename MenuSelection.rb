require 'gtk3'
load 'BoutonChoix.rb'

class MenuSelection < Gtk::Window
    def initialize
        super
        set_title "Selection du plateau"

        signal_connect "destroy" do 
            self.destroy
        end
        
        set_default_size 10, 200
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
        btnFacile = Gtk::Button.new(:label => 'Niveau Facile')
        facileImage = Gtk::CssProvider.new
        facileImage.load(data: <<-CSS)
            button{
                background-image: url("btnfacile.PNG");
                border: unset;
            }
        CSS
        btnFacile.style_context.add_provider(facileImage, Gtk::StyleProvider::PRIORITY_USER)
        btnFacile.set_size_request(40, 40)
        #Creation bouton moyen
        btnMoyen = Gtk::Button.new(:label => 'Niveau Moyen')
        btnHard = Gtk::Button.new(:label => 'Niveau Difficile')
        #Création du bouton retour 
        btnRetour = Gtk::Button.new()
        retourImage = Gtk::CssProvider.new
        retourImage.load(data: <<-CSS)
            button{
                background-image: url("retour.png");
                border: unset;
            }
        CSS
        btnRetour.style_context.add_provider(retourImage, Gtk::StyleProvider::PRIORITY_USER)
        btnRetour.set_size_request(10, 40)

        #Initialisation des boutons de niveau
        tableauBtn=Array.new(24)
        compteur=0
        nivo=1
        while(compteur<24)
            if (nivo==1)
                tableauBtn[compteur]= BoutonChoix.new(true,false,false,compteur)
                nivo=2
            elsif(nivo==2)
                tableauBtn[compteur]= BoutonChoix.new(false,true,false,compteur)
                nivo=3
            elsif(nivo==3)
                tableauBtn[compteur]= BoutonChoix.new(false,false,true,compteur)
                nivo=1
            end
            allbtn.add(tableauBtn[compteur])
            compteur+=1
        end
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
                    while(compteur<24)
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
                    while(compteur<24)
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
                    while(compteur<24)
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
        
        #Bouton Retour cliqué
        btnRetour.signal_connect('clicked'){
           	self.destroy
           	MainMenu.new
        }
        add(boxPrincipal)

        show_all
    end
end

