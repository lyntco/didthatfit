class OutfitsController < ApplicationController
  before_action :check_if_logged_in, :except => [:index,:show,:new]
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

    @offset = 31 - @temp #find how many degrees your clothes need to make up for ambient body temp
    @p = 60 # the heat your body generates on avg
    @r = (@offset/60).round(2) # find n clos

    @outfit = Outfit.new
    # Category.where(:name => 'Outerwear').first.items.first.type.warmth to get warmth
    # & @current_user.items will only keep the items that are the current user's and belong in the category
    # my_items = @current_user.items
    if @current_user.present?
      @torso = Category.find_by(:name => 'Tops').items & @current_user.items
      @torso_out = Category.find_by(:name => 'Outerwear').items & @current_user.items
      @legs = Category.find_by(:name => 'Bottoms').items & @current_user.items
      @feet = Category.find_by(:name => 'Footwear').items & @current_user.items
      @accessories = Category.find_by( name: 'Accessories' ).items & @current_user.items
      @whole_body = Category.find_by( name: 'One Piece').items & @current_user.items
    end
    @outfit_for_today = []
    # use blackjack logic?
    # put into array either @whole_body or @torso + @legs
    # add @torso_out if cold, add @torso_out &/ @legs to @whole_body if cold
    # always put @feet

  end

  #   def twenty_one?(*x) #splat operator takes any number of arguments
  #     x.inject(:+) == @r #adds all the arguments and compares them to clos needed
  #     puts x.inject(:+) #prints the sum
  #   end

#   twenty_one?(2,3,5,6)

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