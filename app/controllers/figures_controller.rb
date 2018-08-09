class FiguresController < ApplicationController

  get '/figures/new' do #view form to create new
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !(params[:title][:name] == "")
      @figure.titles << Title.create(params[:title])
    end
    if !(params[:landmark][:name] == "")
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    @figure.save
    redirect to '/figures'
  end

  get '/figures' do
    @figure = Figure.all
    erb :'/figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])

    if params[:title][:name] != ""
      @figure.titles << Title.create(params[:title])
    end
    if params[:landmark][:name] != ""
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    @figure.save

    redirect "/figures/#{@figure.id}"
  end

end
