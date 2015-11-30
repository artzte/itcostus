class CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :update, :destroy]
  before_filter do
    get_to_from
  end

  # GET /categories
  # GET /categories.json
  def index
    render json: Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    render json: @category, include: ['transactions', 'matchers']
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      head :no_content
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy

    head :no_content
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params[:category]
    end
end
