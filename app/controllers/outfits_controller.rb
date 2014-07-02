class OutfitsController < ApplicationController
  before_action :check_if_logged_in, :except => [:index]
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
    @outfit = Outfit.new
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
    params.require(:outfit).permit( :name, :image )
  end

end