class EmployeeFoldersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_company!
  before_filter :authorize_manager!, except: [:index, :show]

  def index
    @employee = Employee.find(params[:employee_id])
    @folders = []
    EmployeeFolder.where(employee_id: params[:employee_id]).each{|ee_folder|
      @folders << Folder.find(ee_folder.folder_id)
    }
    @folders.reverse!
  end

  def show
    @employee = Employee.find(params[:employee_id])
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
      EmployeeFolder.create!(employee_id: params[:employee_id], folder_id: @folder.id)
      #redirect to show
      redirect_to company_employee_folder_path(employee_id: params[:employee_id], id: @folder.id)
    else
      render :new
    end
  end

  def update
    @folder = Folder.find(params[:id])
    if @folder.update_attributes(folder_params)
      redirect_to company_employee_folder_path
    else
      render :edit
    end
  end

  def destroy
    @folder = Folder.find(params[:id])
    # write prompt first?
    @folder.destroy
    redirect_to company_employee_folders_path
  end

  # delete individual document from folder
  def delete_doc
    employee_folder = EmployeeFolder.find_by(employee_id: params[:employee_id], folder_id: params[:folder_id])
    unless employee_folder.present?
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
    redirect_to company_employee_folder_path(employee_id: params[:employee_id], id: params[:folder_id])
  end

  def new_doc
    @folder = Folder.find(params[:folder_id])
  end
  # add individual document to folder
  def add_doc
    folder_id = params[:folder_id]
    @folder = Folder.new(folder_params)
    @folder.title = "Updated Folder"
    if @folder.save
      # EmployeeFolder.create!(employee_id: params[:employee_id], folder_id: @folder.id)
      @folder.documents.each{|doc|
        doc.folder_id = folder_id
        doc.save!
      }
      @folder.delete

      redirect_to company_employee_folder_path(employee_id: params[:employee_id], id: folder_id)
      flash[:info] = "Document added to folder"
    else
      redirect_to company_employee_folder_new_doc_path(employee_id: params[:employee_id], id: params[:folder_id])
      flash[:error] = "Document NOT added to folder"
    end 
  end

  private

    # folder params permissions
    def folder_params
      params.fetch(:folder).permit(:title, :image, :remove_image, :description, documents_files: [])
    end
end

