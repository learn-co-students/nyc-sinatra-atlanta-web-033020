class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params[:title][:name].empty?
      @title = Title.create(params[:title])
      @figure.titles << @title
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark
    end
    
    @figure.save

    redirect to "/figures"
  end

  get '/figures/:id' do
    @figure = Figure.all.find_by(id: params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.all.find_by(id: params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.all.find_by(id: params[:id])
    @figure.name = params[:figure][:name]
    @landmark = Landmark.find_or_create_by(name: params[:figure][:landmark])
    @figure.landmarks << @landmark
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end
