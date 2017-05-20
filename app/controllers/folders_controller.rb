class FoldersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_company!

  def index
    # @folders = Folder.joins(:company_folders).where(company_id: params[:company_id])
    # puts @folders

    @folders = []
    CompanyFolder.where(company_id: params[:company_id]).each{|company_folder|
      @folders << Folder.find(company_folder.folder_id)
    }
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
      CompanyFolder.create!(company_id: params[:company_id], folder_id: @folder.id)

      redirect_to company_folder_path(company_id: params[:company_id], id: @folder.id)
    else
      render :new
    end
  end

  def update
    @folder = Folder.find(params[:id])
    if @folder.update_attributes(folder_params)
      redirect_to company_folder_path
    else
      render :edit
    end
  end

  def destroy
    @folder = Folder.find(params[:id])
    # write prompt first?
    @folder.destroy
    redirect_to company_folders_path
  end

  # delete individual document from folder
  def delete_doc
    company_folder = CompanyFolder.find_by(company_id: params[:company_id], folder_id: params[:folder_id])
    unless company_folder.present?
      flash[:error] = "No document found"
    else
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
    end
    redirect_to company_folder_path(company_id: params[:company_id], id: params[:folder_id])
  end

  def new_doc
    @folder = Folder.find(params[:folder_id])
  end

  # add individual document to folder
  def add_doc
    folder_id = params[:folder_id]

    temp_folder = Folder.new(folder_params)
    temp_folder.title = "Temporary Folder"

    if temp_folder.documents.empty?
      flash[:error] = "At least one document is required."
      render :new_doc
    elsif temp_folder.save!
      # CompanyFolder.create!(company_id: params[:company_id], folder_id: folder_id)
      temp_folder.documents.each{|doc|
        doc.folder_id = folder_id
        doc.save!
      }
      temp_folder.delete

      flash[:info] = "Document added to folder"
      redirect_to company_folder_path(company_id: params[:company_id], id: folder_id)
    else
      flash[:error] = "Document NOT added to folder"
      redirect_to company_folder_new_doc_path(company_id: params[:company_id], id: params[:folder_id])
    end 
  end

  private

    # folder params permissions
    def folder_params
      params.fetch(:folder).permit(:title, :image, :remove_image, :description, documents_files: [])
    end
end
