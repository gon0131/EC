class Customer::ItemsController < ApplicationController
  before_action :set_q, only: [:index]

  def index
    @results = @q.result
    @genres = Genre.all
    if params[:genre_id] == nil
      @items = Item.all
    else
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private
    def set_q
      @q = Item.ransack(params[:q])
    end
end
