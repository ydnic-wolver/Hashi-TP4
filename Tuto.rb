#!/usr/bin/ruby
require 'gtk3'

$id=0

class Tuto < Gtk::Window

	def initialize
		super
		set_default_size 500, 400
		set_resizable(false)
		set_title "TUTORIEL"
		set_window_position Gtk::WindowPosition::CENTER

		signal_connect "destroy" do 
			destroy
		end

		image0=Gtk::Image.new(:file =>"Ressources/Tuto/TUTO-0.png")
		image1=Gtk::Image.new(:file =>"Ressources/Tuto/TUTO1.png")
		image2=Gtk::Image.new(:file =>"Ressources/Tuto/TUTO2.png")
		image3=Gtk::Image.new(:file =>"Ressources/Tuto/TUTO3.png")
		image4=Gtk::Image.new(:file =>"Ressources/Tuto/TUTO4.png")
		image5=Gtk::Image.new(:file =>"Ressources/Tuto/TUTO5.png")
		image6=Gtk::Image.new(:file =>"Ressources/Tuto/TUTO6.png")
		imageF=Gtk::Image.new(:file =>"Ressources/Tuto/TUTOF.png")
		imageClassement=Gtk::Image.new(:file =>"Ressources/Tuto/Classement.png")
		imageChoixNiveau=Gtk::Image.new(:file =>"Ressources/Tuto/ChoixNiveau.png")

		texte_0 = "<span font_desc = \"Calibri 15\">Voici les règles du jeu.\nLe Hashiwokakero se joue sur une grille rectangulaire sans grandeur standard.\nOn y retrouve des nombres de 1 à 8 inclusivement.\nIls sont généralement encerclés et nommés îles.\nLe but du jeu est de relier toutes les îles en un seul groupe en créant\nune série de ponts (simple ou double) entre les îles.</span>\n"

		texte_1 = "<span font_desc = \"Calibri 15\">Pour jouer, vous devez relier les îles avec des lignes\nsimple ou double en cliquant sur celles ci.</span>\n"

		texte_2 = "<span font_desc = \"Calibri 15\">Voici le bouton Pause.\nIl vous permettra de mettre le jeu en pause\nde sauvegarder ou de quitter le jeu.</span>\n"

		texte_3 = "<span font_desc = \"Calibri 15\"> Voici le chronomètre :\n Il vous indiquera le temps écoulé depuis le lancement de la partie.</span>\n"

		texte_4 = "<span font_desc = \"Calibri 15\">Voici le bouton des hypothèses:\nIl vous permettra, dans une nouvelle fenêtre.\n d'essayer différentes solutions sans altérer votre\nréflexion principale. Vous pourrez aussi valider ou annuler votre \nhypothèse grâce aux boutons situés en bas. </span>\n"

		texte_5 = "<span font_desc = \"Calibri 15\">Voici le bouton retour et le bouton avant :\nCes deux boutons vous permettront de revenir sur les actions précedentes\n ou celle récentes qui ont deja été effectuées. </span>\n"

		texte_6 = "<span font_desc = \"Calibri 15\">Voici le bouton Aide :\n en cliquant dessus, une aide s'affichera\n afin de vous aider dans l'avancée du jeu.</span>\n"

		texte_F = "<span font_desc = \"Calibri 15\"> Pour gagner vous devez relier les iles de telle sorte\n qu'elles ne représentent qu'une seulle composante. </span>\n"

		texte_Classement = "<span font_desc = \"Calibri 15\">Voici le classement :\nQuand votre partie sera finie, vous serez répertorié dans un classement\n en fonction du niveau et de votre temps final\n\n--- C'est la fin du tutoriel ---\nVous pouvez cliquer sur le bouton Quitter ci-dessous\n afin de rejoindre le menu principal.</span>\n"

		texte_ChoixNiveau = "<span font_desc = \"Calibri 15\">Choix des niveaux :\nPour lancer une nouvelle partie , vous devez selectionner votre difficulté\n et votre niveau. Si une sauvegarde existe, vous aurez\nle choix entre charger votre partie ou recommencer de zéro.</span>\n"

		tabImage= Array.new(10)
		tabTexte= Array.new(10)  

		tabImage =[image0,image1,imageChoixNiveau,image2,image3,image4,image5,image6,imageF,imageClassement]
		tabTexte =[texte_0,texte_1,texte_ChoixNiveau,texte_2,texte_3,texte_4,texte_5,texte_6,texte_F,texte_Classement]

		# Creation et ajout du titre de la fenetre  "TUTORIEL" #

		title = "<span font_desc = \"Verdana 40\">TUTORIEL</span>\n"
		textTitle = Gtk::Label.new("TUTORIEL")
		textTitle.set_markup(title)
		textTitle.set_justify(Gtk::Justification::CENTER)

		# Creation et ajouts des boutons <- et -> du Tutoriel  #

		btnGauche = Gtk::Button.new(:label => '<--')
		btnDroite = Gtk::Button.new(:label => '-->')

		
		#--------------------------------------------#

		# Creation du bouton quitter du Tutoriel  #

		btnQuitter = Gtk::Button.new(:label => 'Retour')
		btnQuitter.signal_connect('clicked'){
			self.destroy
			MainMenu.new	
		}
		
		#--------------------------------------------#

		pVBox = Gtk::Box.new(:vertical, 25)
		pHBox1 = Gtk::Box.new(:horizontal, 0)
		pHBox2 = Gtk::Box.new(:horizontal, 0)
		pVBox.add(textTitle)
		pVBox.add(pHBox1)
		pVBox.add(pHBox2)
		pHBox1.add(tabImage[$id])
		textepro = Gtk::Label.new()
		textepro.set_markup(tabTexte[$id])
		textepro.set_justify(Gtk::Justification::CENTER)
		pHBox1.add(textepro)
		pHBox2.pack_start(btnGauche, :expand => true, :fill => true, :padding => 50)
		pHBox2.pack_start(btnDroite, :expand => true, :fill => true, :padding => 50)
		pVBox.add(btnQuitter)
		add(pVBox)
		

		btnGauche.signal_connect('clicked') do
			if $id>0 && $id<=9

				pVBox.remove(textTitle)
				pHBox1.remove(tabImage[$id])
				pHBox1.remove(textepro)
				pHBox2.remove(btnGauche)
				pHBox2.remove(btnDroite)
				pVBox.remove(pHBox1)
				pVBox.remove(pHBox2)
				pVBox.remove(btnQuitter)
				remove(pVBox)

				$id-=1

				pVBox.add(textTitle)
				pVBox.add(pHBox1)
				pVBox.add(pHBox2)
				pHBox1.add(tabImage[$id])
				textepro = Gtk::Label.new()
				textepro.set_markup(tabTexte[$id])
				textepro.set_justify(Gtk::Justification::CENTER)
				pHBox1.add(textepro)
				pHBox2.pack_start(btnGauche, :expand => true, :fill => true, :padding => 50)
				pHBox2.pack_start(btnDroite, :expand => true, :fill => true, :padding => 50)
				pVBox.add(btnQuitter)
				add(pVBox)
		
				
				show_all
			end
		end

		btnDroite.signal_connect('clicked') do
			if $id>=0 && $id<9

				pVBox.remove(textTitle)
				pHBox1.remove(tabImage[$id])
				pHBox1.remove(textepro)
				pHBox2.remove(btnGauche)
				pHBox2.remove(btnDroite)
				pVBox.remove(pHBox1)
				pVBox.remove(pHBox2)
				pVBox.remove(btnQuitter)
				remove(pVBox)
				
				$id+=1

				pVBox.add(textTitle)
				pVBox.add(pHBox1)
				pVBox.add(pHBox2)
				pHBox1.add(tabImage[$id])
				textepro = Gtk::Label.new()
				textepro.set_markup(tabTexte[$id])
				textepro.set_justify(Gtk::Justification::CENTER)
				pHBox1.add(textepro)
				pHBox2.pack_start(btnGauche, :expand => true, :fill => true, :padding => 50)
				pHBox2.pack_start(btnDroite, :expand => true, :fill => true, :padding => 50)
				pVBox.add(btnQuitter)
				add(pVBox)
				
		
				show_all

			end
		end

		show_all

	end

end 
