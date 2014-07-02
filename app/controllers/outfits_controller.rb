class OutfitsController < ApplicationController
  before_action :check_if_logged_in, :except => [:index,:show]
  def index
    @outfits = Outfit.all
  end

  def create
    @outfit = Outfit.new outfit_params
    # raise params.inspect
    if @outfit.save
      redirect_to( outfits_path )
    else
      render :new
    end
  end

  def new
    # raise params.inspect
    @coords = Geocoder.coordinates("sydney")
    @f = ForecastIO.forecast(@coords.first, @coords.last, params: { units: 'si' })
    @temp = @f.currently.temperature
    @summary = @f.currently.summary
    @offset = 31 - @temp

    @outfit = Outfit.new
    # Category.where(:name => 'Outerwear').first.items.first.type.warmth to get warmth
    # & @current_user.items will only keep the items that are the current user's and belong in the category
    @torso = Category.where(:name => 'Tops').first.items & @current_user.items
    @torso += Category.where(:name => 'Outerwear').first.items & @current_user.items
    @legs = Category.where(:name => 'Bottoms').first.items & @current_user.items
    @shoes = Category.where(:name => 'Shoes').first.items & @current_user.items
    @accessories = Category.where( name: 'Accessories' ).first.items & @current_user.items
    @whole_body = Category.where( name: 'One Piece').first.items & @current_user.items
  end

  def edit
    @outfit = Outfit.find params[:id]
  end

  def show
    @outfit = Outfit.find params[:id]
  end

  def update
    @outfit = Outfit.find params[:id]
    @outfit.update( outfit_params )
    redirect_to( outfits_path )
  end

  def destroy
    outfit = Outfit.find params[:id]
    outfit.destroy
    redirect_to( outfits_path )
  end

  private
  def outfit_params
    params.require(:outfit).permit( :name, :items )
  end

end