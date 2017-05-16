class Dependent < ActiveRecord::Base
  belongs_to :employee
  validates_presence_of :employee_id, :date_of_birth

  def dep_age(id, dob)
    dep = Dependent.find(id)
    dep_dob = dob
    age = Date.today.year - dep_dob.year
    age -= 1 if Date.today < dep_dob + age.years
    age
  end

end
