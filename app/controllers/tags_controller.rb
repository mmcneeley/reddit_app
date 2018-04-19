class TagsController < ApplicationController
  def index
    if params[:search]
      @tags = Tag.search(params[:search])
    else
      @tags = Tag.all
    end
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

end
