require 'gtk3'

# Cette classe représente le plateau du jeu
# c'est dans cette classe que toute la logique du jeu va
#  s'articuler


load "HashiGame.rb"

load "HashiSolver.rb"

hashi = HashiGame.new

solver = HashiSolver.new(hashi)


# Chargement d'une grille


Gtk.main

