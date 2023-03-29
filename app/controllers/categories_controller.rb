class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /Categories
  def index
    @categories = Category.all
  end
end
