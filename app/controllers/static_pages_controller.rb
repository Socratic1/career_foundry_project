class StaticPagesController < ApplicationController
  def index
  end

  def landing_page
  	@featured_produce = Product.first
  end

end