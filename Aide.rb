require 'gtk3'

load 'HashiGrid.rb'
load "Ile.rb"
load "Pont.rb"

##
# Cette classe correspond à l'aide du jeu 
class Aide 

    # @id         -> Id de l'aide
    # @grille     -> Grille dans laquelle l'aide est utile
    # @nb_voisins -> Nombre de voisins de chaque sommet de la grille
    # @position   -> Case concernée par l'aide
    
  
    # Identifiant correspondant a l'état dans laquelle se trouve le plateau 
    attr_reader :id

    # Constructeur du menu Aide 
    # * +grille+ grille dans laquelle l'aide doit opérer
    def initialize(grille)
        @grille = grille
        @nb_voisins = Array.new(@grille.sommets.size)
        @id = 0
    end

    # Méthode permettant de definir un cas en fonction de l'etat du tableau
    def lireId 
        @id = definirCas()
    end

    # Méthode permettant d'obtenir le message d'aide correspondant un id 
    def getMessageAide 
      self.lireId()
      file = File.readlines("AideTexte.txt")
      file.each do |line|
        temp = line.split(':')
        if( temp[0] == @id.to_s )
          return temp[1]
        end
      end
    end

    
    # Méthode responsable de l'analyse de la grille ainsi que de ses sommets 
    # afin de déduire le cas dans lequel on se trouve.
    def definirCas()
        @grille.sommets.each_with_index do |x, i|
          @nb_voisins[i] = x.compterVoisins()
        end
        if estCas1?()
            return 1
          elsif estCas2?()
            return 2
          elsif estCas3?()
            return 3
          elsif estCas4?()
            return 4
          elsif estCas5?()
            return 5
          elsif estCas6?()
            return 6
          elsif estCas7?()
            return 7
          elsif estCas8?()
            return 8
          elsif estCas9?()
            return 9
          elsif estCas10?()
            return 10
          elsif estCas11?()
            return 11
          elsif estCas12?()
            return 12
          elsif estCas13?()
            return 13
          elsif estCas14?()
            return 14
          else
            return 0
        end
    end

    # VALIDE
    def estCas1?()
        @grille.sommets.each_with_index do |x, i|
          if @nb_voisins[i] == 1 && x.pontRestants() != x.degreeMax
            @position = @grille.get_child_at(x.column, x.row)
            return true
          end
        end
        return false
    end

  
  # Cas 2 : île avec une seule île voisine restante dans la grille
  def estCas2?()
    @grille.sommets.each_with_index do |x, i|
      puts x.to_s
      puts x.compterVoisinsNonComplets()
      puts x.pontRestants()
      if x.compterVoisinsNonComplets() == 1 && x.pontRestants() != x.degreeMax
        @position =  @grille.get_child_at(x.column, x.row)
        return true
      end
    end
    return false
  end

  # Cas 3 : île à 8 restante dans la grille
  def estCas3?()
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 8 && x.pontRestants() != x.degreeMax
        @position = @grille.get_child_at(x.column, x.row)
        return true
      end
    end
    return false
  end

  # Cas 4 : île à 6 avec 3 îles voisines restante dans la grille
  def estCas4?()
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 6 && @nb_voisins[i] == 3 && x.pontRestants() != x.degreeMax
        @position = @grille.get_child_at(x.column, x.row)
        return true
      end
    end
    return false
  end

  # Cas 5 : île à 4 avec 2 îles voisines restante dans la grille
  def estCas5?()
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 4 && @nb_voisins[i] == 2 && x.pontRestants() != x.degreeMax
        @position = @grille.get_child_at(x.column, x.row)
        return true
      end
    end
    return false
  end

  # Cas 6 : île à 4 avec deux des îles voisines à 1
  def estCas6?()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 4 && @nb_voisins[i] == 3 && x.pontRestants() != x.degreeMax
        x.getVoisins().each do |v|
          compteur = 0
          if v.degreeMax == 1
            compteur += 1
          end
        end
        if compteur == 2
          @position = @grille.get_child_at(x.column, x.row)
          return true
        end
      end
    end
    return false
  end

  # Cas 7 :  île à 5 avec trois îles voisines restante dans la grille
  def estCas7?()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 5 && @nb_voisins[i] == 3 && !x.pontAvecVoisins()
        @position = @grille.get_child_at(x.column, x.row)
        return true
      end
    end
    return false
  end

  
  # Cas 8 : île à 3 avec deux îles voisines dont une à 1 restante dans la grille
  def estCas8?()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 3 && @nb_voisins[i] == 2 && x.pontRestants() != x.degreeMax
        x.getVoisins().each do |v|
          if v.degreeMax == 1 && v.connexionRestantes() != 0
            compteur += 1
          end
        end
        if compteur == 1
          @position =  @grille.get_child_at(x.column, x.row)
          return true
        end
      end
    end
    return false
  end

 
  # Cas 9 : île à 7 restante dans la grille
  def estCas9?()
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 7 && !x.pontAvecVoisins()
        @position = @grille.get_child_at(x.column, x.row)
        return true
      end
    end
    return false
  end

  # Cas 10 : île à 5 avec trois îles voisines restante dans la grille
  def estCas10?()
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 5 && @nb_voisins[i] == 3 && !x.pontAvecVoisins()
        @position =  @grille.get_child_at(x.column, x.row)
        return true
      end
    end
    return false
  end
  

  # Cas 11 : île à 3 avec deux îles voisines restante dans la grille
  def estCas11?()
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 3 && @nb_voisins[i] == 2 && !x.pontAvecVoisins()
        @position =  @grille.get_child_at(x.column, x.row)
        return true
      end
    end
    return false
  end

  # Cas 12 : île à 6 avec deux des îles voisines à 1
  def estCas12?()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 6 && x.pontRestants() != x.degreeMax
        x.getVoisins().each do |v|
          compteur = 0
          if v.degreeMax == 1
            compteur += 1
          end
        end
        if compteur == 2
          @position = @grille.get_child_at(x.column, x.row)
          return true
        end
      end
    end
    return false
  end

  
  # Cas 13 : île à 4 avec deux des îles voisines à 1
  def estCas13?()
    compteur = 0
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 4 && @nb_voisins[i] == 3 && x.pontRestants() != x.degreeMax
        x.getVoisins().each do |v|
          compteur = 0
          if v.degreeMax == 1
            compteur += 1
          end
        end
        if compteur == 2
          @position = @grille.get_child_at(x.column, x.row)
          return true
        end
      end
    end
    return false
  end

  # Cas 14 : île à 2 avec deux îles voisines dont une île à 2 restante
  def estCas14?()
    voisinDeux = false
    @grille.sommets.each_with_index do |x, i|
      if x.degreeMax == 2 && @nb_voisins[i] == 2 && x.pontRestants() == 0
        x.getVoisins().each do |v|
          if v.degreeMax == 2
            @position = @grille.get_child_at(x.column, x.row)
            voisinDeux = true
          end
        end
      end
    end
    return voisinDeux
  end

end
