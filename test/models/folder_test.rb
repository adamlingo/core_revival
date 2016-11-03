require "test_helper"

class FolderTest < ActiveSupport::TestCase
  def folder
    @folder ||= Folder.new
  end

  def test_valid
    skip
    # assert folder.valid?
  end
end
