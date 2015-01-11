class CreaturesController < ApplicationController

  def index
    @creature_list = Creatures.all
  end

  def new
    @creatures = Creatures.new
  end

  def edit
    @creature = Creatures.find(params[:id])
  end

  def create
    # render json: params

    #RAILS WAY
    Creatures.create(creatures_params)
    redirect_to creatures_path
  end

  def update
    @creature = Creatures.find(params[:id])

    if @creature.update(creatures_params)
      redirect_to @creature
    else
      render 'edit'
    end
  end

  def creatures_params
    params.require(:creatures).permit(:name,:desc)
  end

  def show
    @creature = Creatures.find(params[:id])
    list = flickr.photos.search :text => @creature.name, :sort => "relevance"

    @results = list.map do |photo|
      FlickRaw.url_s(photo)
    end
  end

  def destroy
  @creature = Creatures.find(params[:id])
  @creature.destroy

  redirect_to creatures_path
  end

end