class OutfitsController < ApplicationController
  before_action :check_if_logged_in, :except => [:index,:show]
  def index
    @outfits = Outfit.all
  end

  def create
    @outfit.save
    @current_user.outfits << @outfit
    redirect_to( user_outfits_path( @current_user.username ) )
  end

  def new
    # raise params.inspect
    @coords = Geocoder.coordinates("sydney")
    @f = ForecastIO.forecast(@coords.first, @coords.last, params: { units: 'si' })
    @temp = @f.currently.temperature
    @summary = @f.currently.summary
    @offset = 31 - @temp
    # @t = 31 - @p

    @outfit = Outfit.new
    # Category.where(:name => 'Outerwear').first.items.first.type.warmth to get warmth
    # & @current_user.items will only keep the items that are the current user's and belong in the category
    # my_items = @current_user.items
    @torso = Category.where(:name => 'Tops').first.items & @current_user.items
    @torso_out = Category.where(:name => 'Outerwear').first.items & @current_user.items
    @legs = Category.where(:name => 'Bottoms').first.items & @current_user.items
    @feet = Category.where(:name => 'Footwear').first.items & @current_user.items
    @accessories = Category.where( name: 'Accessories' ).first.items & @current_user.items
    @whole_body = Category.where( name: 'One Piece').first.items & @current_user.items

    @outfit_for_today = []
    # find n clos
    # add items by random to be the closest sum of clo
    # use blackjack logic?
    # put into array either @whole_body or @torso + @legs
    # add @torso_out if cold, add @torso_out &/ @legs to @whole_body if cold
    # always put @feet
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