class ItemsController < ApplicationController
  before_action :check_if_logged_in, :except => [:index,:following,:show]

  def index
    @items = Item.order(:created_at => :desc)
    @title = "What's new"
  end

  def following
    if @current_user
      @following = @current_user.friends # => array of friends
      @items = []
      # @items += @current_user.items

        @following.each do |f|
          @items += f.items
        end

      @items = @items.sort_by(&:created_at).reverse
      @fit_items = @current_user.items
      @title = "Watch list"
      render :following
    else
      redirect_to( about_path )
    end
  end

  def create
    @user = User.find_by(:username => @current_user.username)
    @item = Item.new item_params
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
    if @current_user.is_admin? or @current_user.items.include? @item
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
    redirect_to( user_path( @item.user.username ) )
  end

  def destroy
    item = Item.find params[:id]
    item.destroy
    redirect_to( user_path(@current_user.username) )
  end

  private
  def item_params
    params.require(:item).permit(:name,:type_id,:brand_id,:size,:fit, :image, :image_cache, :remote_image_url, :user_id)
  end

end
