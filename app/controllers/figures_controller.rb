require 'pry'

class FiguresController < ApplicationController

	get '/figures' do
		#binding.pry
		@figures = Figure.all
		erb :'/figures/index'
	end


	get '/figures/new' do
		@titles = Title.all
		@landmarks = Landmark.all
		erb :'/figures/new'
	end

	post '/figures' do
		@figure = Figure.create(params[:figure])
		if !params[:title][:name].empty?
			@figure.titles << Title.create(params[:title])
		end

		if !params[:landmark][:name].empty?
			@figure.landmarks << Landmark.create(params[:landmark])
		end

		@figure.save

		redirect to "figures/#{@figure.id}"
		#binding.pry
	end


	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		erb :'/figures/show'
	end


	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		erb :'/figures/edit'
	end

	# patch '/figures/:id' do

	# 	@figure = Figure.find(params[:id])
	# 	@figure.name = params[:figure][:name]
	# 	#binding.pry


	# 	#binding.pry
	# 	if !params[:landmark][:name].empty?
	# 		@figure.landmarks << Landmark.create(params[:landmark])
	# 		#binding.pry
	# 	end

	# 	if !params[:title][:name].empty?
	# 		@figure.titles << Title.create(params[:title])
	# 		#binding.pry
	# 	end


	# 	@figure.save
	# 	#binding.pry
	# 	redirect to "figures/#{@figure.id}"
	# end

	patch '/figures/:id' do 
      @figure = Figure.find(params[:id])
      @figure.update(params[:figure])
      
      if !params[:landmark][:name].empty?
        @figure.landmarks << Landmark.create(params[:landmark])
      end

      if !params[:title][:name].empty?
        @figure.titles << Title.create(params[:title])
      end
      
      @figure.save
      redirect to "/figures/#{@figure.id}"
    end




end
