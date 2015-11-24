class HomeController < ApplicationController
  def index
    @card = Card.random_card
  end

  def check
    @card = Card.find(params[:card_id])
    if @card.original_text == params[:translate]
      p :right
      flash.now[:notice] = "Молодец!"
      redirect_to action: :index
    else
      p :wrong
      flash.now[:error] = "Не правильно"
      render :index
    end
  end
end
