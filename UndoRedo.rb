
# Cette classe implémente les fonctionnalités Undo / Redo
class UndoRedo  

    # @undoStack    -> Pile contenant les action à enlever
	# @reduStack    -> Pile contenant les action à replacer tant que l'utilisateur n'effectue pas une autre action que le Redo


    # Pile contenant les action à enlever
    attr_accessor :undoStack

    # Pile contenant les action à replacer tant que l'utilisateur n'effectue pas une autre action
    # que le Redo 
    attr_accessor :redoStack 

    # Cette méthode est responsable de nettoyer la pile undo et redo
    def cleanAll
        @undoStack.clear
        @redoStack.clear
    end

    # Constructeur de la classe UndoRedo
    # Initialise les deux tableaux
    def initialize
        @undoStack = Array.[]
        @redoStack = Array.[]
    end

    # Sauvegarde le clic de l'utilisateur
    def saveUserClick(action)
        @undoStack << action
    end

     # Supprime et renvoi la dernière action utilisateur
    def undoUserAction(action)
        @undoStack.pop!()
    end

    # Retourne true si la pile est vide 
    # Sinon false
    def undoEmpty?
        return @undoStack.empty? 
    end

end