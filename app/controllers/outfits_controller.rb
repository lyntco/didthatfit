class OutfitsController < ApplicationController
  before_action :check_if_logged_in, :except => [:index,:show,:new,:ed]
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
    @r = (@offset/60).round(2) # find n clos needed

    @outfit = Outfit.new

    tops = Category.find_by(:name => 'Tops' )
    outerwear = Category.find_by(:name => 'Outerwear' )
    bottoms = Category.find_by(:name => 'Bottoms' )
    footwear = Category.find_by(:name => 'Footwear')
    accessories = Category.find_by( name: 'Accessories' )
    onepiece = Category.find_by( name: 'One Piece')
    # will get pants more warm than 0.1
    # @current_user.items.joins(:type).where("types.category_id = #{ bottoms.id }").select('types.warmth as w').select {|i| i.w > 0.1}
    @legs = @current_user.items.joins(:type).where("types.category_id = #{ bottoms.id }").select('types.warmth as w')
    raise @legs.map {|i| i.w.to_s }
    # binding.pry
    @outfit_for_today = []
    @outfit_for_today << (@feet.empty? ? "default_feet" : @feet.sample) #puts random shoes in outfit
    @outfit_for_today << (@legs.empty? ? "default_legs" : @legs.sample)
    @outfit_for_today << (@torso.empty? ? "default_torso" : @torso.sample)
    @clos = 0.0
    # raise "dsas"
    @outfit_for_today.each do |item|
      @clos += item.type.warmth
    end
    # binding.pry
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