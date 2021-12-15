class RootController < ApplicationController
    
    def home
        @worker = Worker.first
    end


    
end

