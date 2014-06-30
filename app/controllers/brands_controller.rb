class BrandsController < ApplicationController
  def index
    @brands = Brand.all
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