class FoldersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_company!

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

  # delete individual document from folder
  def delete_doc
    @folder = Folder.find(params[:folder_id])
    doc_id = params[:doc_id]
    doc = Document.find_by(id: doc_id, folder_id: @folder.id)
    if doc.present?
      puts "found"
      doc.delete
      flash[:info] = "Document deleted successfully"
    else
      flash[:error] = "No document found"
      puts "not found"
    end
    
    redirect_to folder_url(@folder)
  end

  # add individual document to folder
  def add_doc
    documents = params[:documents_files]


    redirect_to folder_url(@folder)
  end

  private

    # folder params permissions
    def folder_params
      params.fetch(:folder).permit(:title, :image, :remove_image, :description, documents_files: [])
    end
end
