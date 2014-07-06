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
    @ip_location = request.location
    # raise
    @coords = Geocoder.coordinates( @ip_location.city ) if Rails.env.production?
    @coords = Geocoder.coordinates( 'sydney' ) if Rails.env.development?
    @f = ForecastIO.forecast(@coords.first, @coords.last, params: { units: 'si' })
    @temp = @f.currently.temperature
    @summary = @f.currently.summary

    @offset = 31 - @temp #find how many degrees your clothes need to make up for ambient body temp
    @p = 60 # the heat your body generates on avg
    @r = (@offset/60).round(2) # find n clos needed
    @adjusting_clo = @r

    @outfit = Outfit.new

    tops = Category.find_by(:name => 'Tops' )
    outerwear = Category.find_by(:name => 'Outerwear' )
    bottoms = Category.find_by(:name => 'Bottoms' )
    footwear = Category.find_by(:name => 'Footwear')
    accessories = Category.find_by( name: 'Accessories' )
    onepiece = Category.find_by( name: 'One Piece')
    # will get pants more warm than 0.1
    # @current_user.items.joins(:type).where("types.category_id = #{ bottoms.id }").select('types.warmth as w').select {|i| i.w > 0.1}
    @torso = @current_user.items.joins(:type).where("types.category_id = #{ tops.id }").select('types.warmth as w') if tops.present?
    @torso_out = @current_user.items.joins(:type).where("types.category_id = #{ outerwear.id }").select('types.warmth as w') if outerwear.present?
    @legs = @current_user.items.joins(:type).where("types.category_id = #{ bottoms.id }").select('types.warmth as w') if bottoms.present?
    @feet = @current_user.items.joins(:type).where("types.category_id = #{ footwear.id }").select('types.warmth as w') if footwear.present?
    @acc = @current_user.items.joins(:type).where("types.category_id = #{ accessories.id }").select('types.warmth as w') if accessories.present?
    @whole_body = @current_user.items.joins(:type).where("types.category_id = #{ onepiece.id }").select('types.warmth as w') if onepiece.present?
    @outfit_for_today = []
    # raise @legs.map {|i| i.w.to_s }

    if @feet.load.any? && item = @feet.select {|i| i.w < @adjusting_clo }.sample
      @outfit_for_today << item
      @adjusting_clo -= item.w
    else
      # raise
      @outfit_for_today << "default_legs"
    end

    if @legs.load.any? && item = @legs.select {|i| i.w < @adjusting_clo }.sample
      @outfit_for_today << item
      @adjusting_clo -= item.w
    else
      @outfit_for_today << "default_legs"
    end

    if @torso.load.any? && item = @torso.select {|i| i.w < @adjusting_clo }.sample
      @outfit_for_today << item
      @adjusting_clo -= item.w
    else
      @outfit_for_today << "default_torso"
    end

    # if @torso_out.load.any?
    #   item = @torso_out.select {|i| i.w < @adjusting_clo }.sample
    #   if item
    #     @outfit_for_today << item
    #     @adjusting_clo -= item.w
    #   else
    #     @outfit_for_today << "default_outer"
    #   end
    # end

    # put into array either @whole_body or @torso + @legs
    # add @torso_out if cold, add @torso_out &/ @legs to @whole_body if cold
    # always put @feet
    # @clo = sum_clo( @r,@outfit_for_today.join(",") )
  end

  # def sum_clo(r,*x) #splat operator takes any number of arguments
    # x.inject(:+) == r #adds all the arguments and compares them to clos needed
    # puts x.inject(:+) #prints the sum
  # end


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