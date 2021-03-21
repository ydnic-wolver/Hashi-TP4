 # Chargement d'une grille depuis un fichier
 def chargeGrille()
    data = []
    File.foreach('file.txt').with_index do |line, line_no|
        data << line.chomp
    end
    # Slice permet de récupérer la taille de la matrice 
    # tel que 7:7
    num = data.slice!(0)
    self.colonnes = num[0].to_i
    self.lignes = num[2].to_i

    # Parcours des données récupérés afin de charger
    # les boutons
    for i in 0..(data.length() - 1) 
        data[i].split(':').each_with_index do | ch, index| 
            # # Création d'une case 

            if ch != '0'
                btn = Ile.new(self, ch,index,i)
            else 
                btn = Pont.new(self, ch, index, i)
                if (ch == '-')
                    btn.set_typePont(1)
                    btn.set_directionPont(1)
                elsif(ch == '=')
                    btn.set_typePont(2)
                    btn.set_directionPont(1)
                elsif('I')
                    btn.set_typePont(1)
                    btn.set_directionPont(2)
                elsif('H')
                    btn.set_typePont(1)
                    btn.set_directionPont(2)
                else
                    btn.set_typePont(0)
                end
            end

            # On attache la référence de la grille
            self.attach(btn, index,i, 1,1)
        end
    end
end