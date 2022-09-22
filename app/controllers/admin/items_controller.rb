class Admin::ItemsController < ApplicationController
  before_action :set_q, only: [:index]

  def index
    @results = @q.result
    if @results == nil
      @items = Item.all
    else
      @items = @q.result
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end

  private
  def set_q
    @q = Item.ransack(params[:q])
  end

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :is_active, :image)
  end

end
