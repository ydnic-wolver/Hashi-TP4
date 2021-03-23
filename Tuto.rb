#!/usr/bin/ruby
require 'gtk3'


class Tuto < Gtk::Window

	@@id=0

	def initialize
		super
		set_default_size 500, 400
		set_resizable(TRUE)
		set_title "TUTORIEL"
		set_window_position Gtk::WindowPosition::CENTER

		signal_connect "destroy" do 
			destroy
		end

		image0=Gtk::Image.new(:file =>"image/TUTO-0.png")
		image1=Gtk::Image.new(:file =>"image/TUTO1.png")
		image2=Gtk::Image.new(:file =>"image/TUTO2.png")
		image3=Gtk::Image.new(:file =>"image/TUTO3.png")
		image4=Gtk::Image.new(:file =>"image/TUTO4.png")
		image5=Gtk::Image.new(:file =>"image/TUTO5.png")
		image6=Gtk::Image.new(:file =>"image/TUTO6.png")
		imageF=Gtk::Image.new(:file =>"image/TUTOF.png")
		imageClassement=Gtk::Image.new(:file =>"image/Classement.png")
		imageChoixNiveau=Gtk::Image.new(:file =>"image/ChoixNiveau.png")

		texte_0 = "<span font_desc = \"Calibri 10\">Voici les règles du jeu\nLe Hashiwokakero se joue sur une grille rectangulaire sans grandeur standard.\nOn y retrouve des nombres de 1 à 8 inclusivement.\nIls sont généralement encerclés et nommés îles.\nLe but du jeu est de relier toutes les îles en un seul groupe en créant\nune série de ponts (simples ou doubles) entre les îles.</span>\n"

		texte_1 = "<span font_desc = \"Calibri 10\">Pour jouer, vous douvez reliez les iles avec des lignes\nsimple ou double en cliquant entre elles.</span>\n"

		texte_2 = "<span font_desc = \"Calibri 10\">Voici le bouton Pause,\nil vous permettra de mettre le jeu en pause, de sauvegarder ou de quitter le jeu</span>\n"

		texte_3 = "<span font_desc = \"Calibri 10\"> Voici le chronometre :\n Il vous indiquera le temps que vous avez mis pendant de la partie</span>\n"

		texte_4 = "<span font_desc = \"Calibri 10\">Voici le bouton des hypothèses:\nIl vous permettra de suggérer plusieurs possibilité de solution.\nVous pouvez ainsi validé ou en ajouter votre hypothèse grace au deux boutons du haut. </span>\n"

		texte_5 = "<span font_desc = \"Calibri 10\">Voici le bouton retour et le bouton avant :\nCes deux boutons, vous permettront de revenir sur les actions précedente\n ou celle récentes qui ont deja été effectuées. </span>\n"

		texte_6 = "<span font_desc = \"Calibri 10\">Voici le bouton Aide :\n en cliquant une aide vous sera afficher\n afin de vous aider dans l'avancer du jeu.</span>\n"

		texte_F = "<span font_desc = \"Calibri 10\"> Pour gagner vous devez reliez les iles comme la grille ci-contre </span>\n"

		texte_Classement = "<span font_desc = \"Calibri 10\">Voici le classement :\nQuand votre partie sera finie vou serai repertorié dans un classementpar rapport au temps que vous aurez mis a finir celle-ci.\n\n--- C'est la fin du tutoriel ---\nVous pouvez cliquez sur le boutons Quitter ci-dessous afin de joindre le menu principale.</span>\n"

		texte_ChoixNiveau = "<span font_desc = \"Calibri 10\">Choix des niveaux :\nPour lancer une nouvelle partie , vous devez selectionner la taille de la grille\nainsi que la difficulté du niveau que vous souhaité.</span>\n"

		tabImage= Array.new(10)
		tabTexte= Array.new(10)  

		tabImage =[image0,image1,imageChoixNiveau,image2,image3,image4,image5,image6,imageF,imageClassement]
		tabTexte =[texte_0,texte_1,texte_ChoixNiveau,texte_2,texte_3,texte_4,texte_5,texte_6,texte_F,texte_Classement]

		pVBox1 = Gtk::Box.new(:vertical, 25)
		pVBox2 = Gtk::Box.new(:vertical, 0)
		pHBox1 = Gtk::Box.new(:horizontal, 0)
		pHBox2 = Gtk::Box.new(:horizontal, 0)


		# Creation et ajout du titre de la fenetre  "TUTORIEL" #

		title = "<span font_desc = \"Verdana 40\">TUTORIEL</span>\n"
		textTitle = Gtk::Label.new("TUTORIEL")
		textTitle.set_markup(title)
		textTitle.set_justify(Gtk::Justification::CENTER)
		pVBox1.add(textTitle)

		#-----------------------------------------------------------#

		pVBox1.add(pHBox1)
		pHBox1.add(tabImage[@@id])
		pHBox1.add(pVBox2)
		
		textepro = Gtk::Label.new()
		textepro.set_markup(tabTexte[@@id])
		textepro.set_justify(Gtk::Justification::CENTER)

		
		pVBox2.pack_start(textepro, :expand => true, :fill => true, :padding => 0)

		pVBox2.pack_start(pHBox2, :expand => false, :fill => false, :padding => 0)
		
		# Creation et ajouts des boutons <- et -> du Tutoriel  #

		btnGauche = Gtk::Button.new(:label => '<--')
		btnGauche.signal_connect('clicked') do
			self.btnGaucheClicked
		end

		pHBox2.pack_start(btnGauche, :expand => true, :fill => true, :padding => 50)

		btnDroite = Gtk::Button.new(:label => '-->')
		btnDroite.signal_connect('clicked') do
			self.btnDroiteClicked
		end
		pHBox2.pack_start(btnDroite, :expand => true, :fill => true, :padding => 50)
		
		

		#--------------------------------------------#

		# Creation du bouton quitter du Tutoriel  #

		btnQuitter = Gtk::Button.new(:label => 'Retour')
		btnQuitter.signal_connect('clicked'){
			@@id=0
			self.destroy
			MainMenu.new	
		}
		pVBox1.add(btnQuitter)
		#--------------------------------------------#

		add(pVBox1)
		show_all
	
	end



	def btnDroiteClicked 

		if @@id>=0 && @@id<9
			self.destroy
			@@id+=1
			self.initialize
		end

	end


	def btnGaucheClicked 

		if @@id>0 && @@id<=9
			self.destroy
			@@id-=1
			self.initialize
		end
		
	end

end 
