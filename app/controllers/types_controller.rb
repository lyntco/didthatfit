class TypesController < ApplicationController
  def index
    @types = Type.all
  end

  def create
    @type = Type.new type_params
    # raise params.inspect
    if @type.save
      redirect_to( root_path )
    else
      render :new
    end
  end

  def new
    # raise params.inspect
    @type = Type.new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def type_params
    params.require(:type).permit( :name, :warmth )
  end

end