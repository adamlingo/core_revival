class Document < ActiveRecord::Base
  belongs_to :folder

  attachment :file
end
