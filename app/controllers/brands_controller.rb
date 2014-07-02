class BrandsController < ApplicationController
  before_action :check_if_logged_in, :except => [:index]

  def index
    @brands = Brand.order(:name => :asc)
    brands = Brand.all
    @small = []
    @fit = []
    @big = []

    brands.each do |brand|
      big_count = brand.items.where(:fit => 'big').count
      fit_count = brand.items.where(:fit => 'right').count
      small_count = brand.items.where(:fit => 'small').count
      # raise params.inspect
      unless big_count == 0 && fit_count == 0 && small_count == 0
        least, mid, most = [big_count,fit_count,small_count].sort
        case most
        when fit_count then @fit << brand
        when big_count then @big << brand
        when small_count then @small << brand
        end
      end
    end
  end

  def create
    @brand = Brand.new brand_params
    # raise params.inspect
    if @brand.save
      redirect_to( brands_path )
    else
      render :new
    end
  end

  def new
    # raise params.inspect
    @brand = Brand.new
  end

  def edit
    @brand = Brand.find params[:id]
  end

  def show
    @brand = Brand.find params[:id]
  end

  def update
    @brand = Brand.find params[:id]
    @brand.update(brand_params)
    redirect_to( brands_path )
  end

  def destroy
    brand = Brand.find params[:id]
    brand.destroy
    redirect_to( brands_path )
  end

  private
  def brand_params
    params.require(:brand).permit( :name, :image )
  end

end