require 'rails_helper'

describe User, :type => :model do
    it "is invalid when saved" do
        user = User.new
        expect(user.valid?).to eq(false)
        expect(user.errors[:email]).to eq(['can\'t be blank'])
        expect(user.errors[:password]).to eq(['can\'t be blank'])

    end
    
    
    it "should be valid" do
        user = User.new
        user.email = 'admin@admin.com'
        user.password = 'password'
        expect(user.valid?).to eq(true)
    end
    
    
    it "email is unique" do
        user1 = User.new(email: 'unique@email.com', password: 'password')
        user2 = User.new(email: 'unique@email.com', password: 'password')
        user1.save!
    
        expect do
          user2.save!
        end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Email has already been taken')
        
        expect(user1.persisted?).to eq(true)
        expect(user2.persisted?).to eq(false)
    end
    
end