class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # find company ID for current user.
  def company_id
    e = Employee.find_by(user_id: id)
    e.company_id
  end

  def company_name
    e = Employee.find_by(user_id: id)
    e.company.name
  end

  def first_name
    e = Employee.find_by(user_id: id)
    e.first_name
  end

  def last_name
    e = Employee.find_by(user_id: id)
    e.last_name
  end

end
