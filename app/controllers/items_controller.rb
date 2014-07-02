class ItemsController < ApplicationController
  before_action :check_if_logged_in, :except => [:index]

  def index
    @items = Item.order(:created_at => :desc)
  end

  def create
    @user = User.where(:username => @current_user.username).first
    @item = Item.new item_params
    @item.image = "default_item.jpg"
    if @item.save
      @user.items << @item
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
    if @current_user.items.include? @item
      @item
    else
      redirect_to( user_path(@current_user.username) )
    end
  end

  def show
    @item = Item.find params[:id]
  end

  def update
    @item = Item.find params[:id]
    @item.update( item_params )
    redirect_to( user_path(@current_user.username) )
  end

  def destroy
    item = Item.find params[:id]
    item.destroy
    redirect_to( user_path(@current_user.username) )
  end

  private
  def item_params
    params.require(:item).permit(:name,:type_id,:brand_id,:size,:fit, :image, :image_cache, :user_id)
  end

end
