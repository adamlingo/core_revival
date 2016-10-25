class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  def index
    @folders = Folder.all
  end

  def show
    @folder = Folder.find(params[:id])
  end

  def new
    @folder = Folder.new
  end

  def edit
    @folder = Folder.find(params[:id])
  end

  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      redirect_to @folder
    else
      render :new
    end
  end

  def update
    @folder = Folder.find(params[:id])
    if @folder.update_attributes(folder_params)
      redirect_to @folder
    else
      render :edit
    end
  end

  def destroy
    @folder = Folder.find(params[:id])
    # write prompt first?
    @folder.destroy
    redirect_to :folders
  end

  private
  
    # folder params permissions
    def folder_params
      params.fetch(:folder).permit(:title, :image, :description, documents_files: [])
    end
end
