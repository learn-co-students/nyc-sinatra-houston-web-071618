class FiguresController < ApplicationController
    get "/figures/new" do
        @landmarks = Landmark.all
        @titles = Title.all 
        erb :'/figures/new'
    end

    post '/figures/new' do 
        puts params
        @figure = Figure.create(:name => params[:figure][:name])
        @figure.save
        # Adding Titles
        title_ids = params[:figure][:title_ids]
        if title_ids
            title_ids.each do |id|
                FigureTitle.create({figure_id: @figure.id, title_id: id})
            end
        end
        title_name = params[:title][:name]
        puts "title_name: " + title_name
        if title_name
            # create the title
            new_title = Title.create(:name => title_name)
            new_title.save
            #create title_figure join
            FigureTitle.create(figure_id: @figure.id, title_id: new_title.id)
        end

        # Adding Landmarks
        landmark_ids = params[:figure][:landmark_ids]
        if landmark_ids
            landmark_ids.each do |id|
                @landmark = Landmark.find(id)
                @figure.landmarks << @landmark
                # @landmark.figure_id = @figure.id
                # @landmark.save
                # binding.pry
            end
        end
        new_landmark = params[:landmark]
        if new_landmark[:name]
            #create landmark
            new_landmark = Landmark.create(name: new_landmark[:name], year_completed: new_landmark[:year_completed], figure_id: @figure.id)
        end


    end

    get '/figures' do
        @figures = Figure.all
        erb :'/figures/index'
    end

    get '/figures/:id' do
        @figure = Figure.find(params[:id])
        erb :'/figures/show'
    end

    get '/figures/:id/edit' do
        @figure = Figure.find(params[:id])
        @titles = Title.all
        @landmarks = Landmark.all
        erb :'/figures/edit'
    end

    put '/figures/:id' do
        puts params

        @figure = Figure.find(params[:id])


        # remove titles
        @figure.titles.clear
        # Adding Titles
        title_ids = params[:figure][:title_ids]
        if title_ids
            title_ids.each do |id|
                FigureTitle.create({figure_id: @figure.id, title_id: id})
            end
        end
        title_name = params[:title][:name]
        puts "title_name: " + title_name
        if title_name.length > 0
            # create the title
            new_title = Title.create(:name => title_name)
            new_title.save
            #create title_figure join
            FigureTitle.create(figure_id: @figure.id, title_id: new_title.id)
        end

        @figure.landmarks.clear
        # Adding Landmarks
        landmark_ids = params[:figure][:landmark_ids]
        if landmark_ids
            landmark_ids.each do |id|
                @landmark = Landmark.find(id)
                @figure.landmarks << @landmark
                # @landmark.figure_id = @figure.id
                # @landmark.save
                # binding.pry
            end
        end
        new_landmark = params[:landmark]
        if new_landmark[:name].length > 0
            #create landmark
            new_landmark = Landmark.create(name: new_landmark[:name], year_completed: new_landmark[:year_completed], figure_id: @figure.id)
        end

        #Set the name 
        @figure.name = params[:figure][:name]
        @figure.save

        redirect to "/figures/#{@figure.id}"

        
    end

end

