class LandmarksController < ApplicationController
    get '/landmarks/new' do
        erb :'/landmarks/new'
    end
    post '/landmarks/new' do
        @landmark = params[:landmark]
        @landmark = Landmark.create(:name => @landmark[:name], :year_completed => @landmark[:year_completed])
        @landmark.save
        erb :'/landmarks/show'
    end
    get '/landmarks' do
        @landmarks = Landmark.all
        erb :'/landmarks/index'
    end
    get '/landmarks/:id' do
        @landmark = Landmark.find(params[:id])
        erb :'/landmarks/show'
    end
    get '/landmarks/:id/edit' do
        @landmark = Landmark.find(params[:id])
        erb :'/landmarks/edit'
    end
    put '/landmarks/:id' do
        @landmark = Landmark.update(params[:id], params[:landmark])
        erb :'/landmarks/show'
    end


end
