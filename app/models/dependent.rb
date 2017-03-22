class Dependent < ActiveRecord::Base
    belongs_to :employee
    validates_presence_of :employee_id

    # has profiles or details?
end
