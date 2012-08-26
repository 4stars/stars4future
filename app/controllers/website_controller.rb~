class WebsiteController < ApplicationController
	
	before_filter :authenticate_user!

	def index
		@website = Website.all
	end

	def home
	end
	
	def new
		@website = Website.new
	end
	
	def create
		@website = Website.new(params[:website])
		if @website.save 
			redirect_to :action => :show,:id=>@website.id
		else
			redirect_to :action => :new
		end
	end
	
	def	edit
		@website = Website.find(params[:id])
	end
	
	def update
		@website = Website.find(params[:id])
		if @website.update_attributes(params[:website])
			redirect_to website_path
		else
			redirect_to :action=> :edit, :id => @website.id
		end
	end


	def show
		@website = Website.find(params[:id])
	end
	
end
