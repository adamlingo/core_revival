class Folder < ActiveRecord::Base
  validates_presence_of :title

  attachment :image, type: :image

  has_many :documents, dependent: :destroy
  has_many :company_folders

  accepts_attachments_for :documents

end
