class CreaturesController < ApplicationController
  before_action :locate_creature, only: [:show, :edit, :update]

  def index
    @creature_list = Creatures.all
  end

  def new
    @creature = Creatures.new
  end

  def edit
    @creature = Creatures.find(params[:id])
  end

  def create
    # render json: params
    @creature = Creatures.create(creatures_params)

    if @creature.save
      redirect_to creatures_path
    else
      render 'new'
    end
  end

  def update
    @creature = Creatures.find_by_id(params[:id])

    if @creature.update(creatures_params)
      redirect_to @creature
    else
      render 'edit'
    end
  end

  def show
    @creature = Creatures.find_by_id(params[:id])

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

private

  def creatures_params
    params.require(:creatures).permit(:name,:desc)
  end

  def locate_creature
    not_found unless @creature = Creatures.find_by_id(params[:id])
      # redirect_to '/404.html'
    # end
  end

end