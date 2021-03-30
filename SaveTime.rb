class SaveTime
    def initialize(nomGrille,difficulte,chrono, nom)

        titre = nomGrille.match(/[^\/]*.txt/)

        file = File.open("./Classement/#{difficulte}/classement#{titre}", 'a')
        file.write("#{chrono}:#{nom}\n")
        file.close
    end
end