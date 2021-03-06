class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # find company ID for current user.
  def company_id
    e = Employee.find_by(user_id: id)
    e.company_id
  end

  # find current user employee id
  def employee_id
    e = Employee.find_by(user_id: id)
    e.id
  end 

  def company_name
    e = Employee.find_by(user_id: id)
    e.company.name.upcase!
  end

  def first_name
    e = Employee.find_by(user_id: id)
    e.first_name
  end

  def last_name
    e = Employee.find_by(user_id: id)
    e.last_name
  end
  
  def current_employee
   Employee.find_by(user_id: id)
  end

  # *** This method is needed to kill an error in devise_invitable
  # that causes passwords not to be sent.
  def after_password_reset;
  end

end
