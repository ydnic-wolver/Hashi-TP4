


class Sauvegarde  

    attr_accessor :undoStack

    attr_accessor :redoStack 

    def initialize
        @undoStack = Array.[]
        @redoStack = Array.[]
    end

    def saveUserClick(action)
        puts action
        @undoStack << action
    end

    def undoUserAction(action)
        @undoStack.pop!()
    end

end