class ItemsController < ApplicationController
  # before_action :check_if_logged_in, :except => [:items]

  def index
    @items = Item.all
  end

  def create
    @item = Item.new item_params
    # raise params.inspect
    if @item.save
      redirect_to( items_path )
    else
      render :new
    end
  end

  def new
    # raise params.inspect
    @item = Item.new
  end

  def edit
    @item = Item.find params[:id]
  end

  def show
    @item = Item.find params[:id]
  end

  def update
    @item = Item.find params[:id]
    @item.update( item_params )
    redirect_to( items_path )
  end

  def destroy
    item = Item.find params[:id]
    item.destroy
    redirect_to( items_path )
  end

  private
  def item_params
    params.require(:item).permit( :name, :image )
  end

  private
  def item_params
    params.require(:item).permit(:name,:image,:type_id,:brand_id,:size,:fit)
  end

end

# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type_id    :integer
#  brand_id   :integer
#  size       :string(255)
#  fit        :string(255)
#  created_at :datetime
#  updated_at :datetime
#