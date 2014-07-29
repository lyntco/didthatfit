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
    @temp, @summary = weather_and_summary
    offset = 31 - @temp #find how many degrees your clothes need to make up for ambient body temp
    p = 60 # the heat your body generates on avg
    @r = (offset/p).round(2) # find n clos needed
    @adjusting_clo = @r

    # @outfit = Outfit.new
    @outfit_for_today = []

    my_items = @current_user.items.group_by { |item| item.type.category.name }

    {'Footwear' => 'feet','Bottoms' => 'legs','Tops' => 'torso','Outerwear' => 'torso_out'}.each do |category,label|
      item, adjusting = remove_clo( (my_items[category] || []), label, @adjusting_clo)
      @outfit_for_today << item
      @adjusting_clo -= adjusting
    end
    # raise @legs.map {|i| i.w.to_s }

    # [
    #   [@feet,'feet'],
    #   [@legs,'legs'],
    #   [@torso,'torso'],
    #   [@torso_out,'torso_out'],
    # ].each do |(value,name)|
    #   item, adjusting = remove_clo(value,name)
    #   @outfit_for_today << item
    #   @adjusting_clo -= adjusting
    # end

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

  def remove_clo(area, name, adjusting)
    if area.any? && item = area.select {|i| i.warmth < adjusting }.sample
        [item, item.warmth]
    else
        ["default_#{name}", 0]
    end
  end

  def weather_and_summary
    coords = Geocoder.coordinates( 'sydney' )
    f = ForecastIO.forecast(coords.first, coords.last, params: { units: 'si' })
    [f.currently.temperature, f.currently.summary]
  end

end