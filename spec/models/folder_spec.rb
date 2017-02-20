require 'rails_helper'

describe Folder, type: :model do
    
    it 'should require title' do
    
        f = Folder.new(title: 'Testing')
        f2 = Folder.new(description: 'Not Working')
        
        expect(f.valid?).to eq(true)
        expect(f2.valid?).to eq(false)
    end
    
end