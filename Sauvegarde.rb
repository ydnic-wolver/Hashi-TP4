


class Sauvegarde  

    attr_accessor :undoStack

    attr_accessor :redoStack 

    def initialize
        @undoStack = Array.[]
        @redoStack = Array.[]
    end

    def saveUserClick(action)
        @undoStack << action
    end

    def showUndoStack
        puts "UNDO STACKS"
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