class WelcomeController < ApplicationController
	def index
		flash[:notice] = "Evening Your Majesty."
	end
end
