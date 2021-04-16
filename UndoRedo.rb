
##
# Cette classe représente les fonctionnalités Undo / Redo
##
class UndoRedo  

    attr_accessor :undoStack

    attr_accessor :redoStack 

    def cleanAll
        @undoStack.clear
        @redoStack.clear
    end
    def initialize
        @undoStack = Array.[]
        @redoStack = Array.[]
    end

    def saveUserClick(action)
        @undoStack << action
    end

    def showUndoStack
        @undoStack.each do |el| 
            puts el.to_s
        end
    end

    def undoUserAction(action)
        @undoStack.pop!()
    end

    def undoEmpty?
        return @undoStack.empty? 
    end

end