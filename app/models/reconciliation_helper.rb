class ReconciliationHelper < ResourceModel::Base
  string_accessor :company_id
  string_accessor :month
  string_accessor :year

  validates_presence_of :company_id
  validates_presence_of :month
  validates_presence_of :year

  validate :is_valid_company_id
  validate :is_valid_month
  validate :is_valid_year

  attr_reader :has_health_invoices
  attr_reader :has_payroll_deductions

  def initialize(attributes = {})
    super(attributes)

    check_for_records
  end

  def check_for_records!
    return false unless self.valid?
    check_for_records
  end

  private
    def check_for_records
      return false unless self.valid?
      num_invoices = HealthInvoice.where(month: self.month, year: self.year).count
      num_deductions = PayrollDeduction.where(month: self.month, year: self.year).count
      @has_health_invoices = num_invoices > 0
      @has_payroll_deductions = num_deductions > 0

      unless @has_health_invoices
        errors.add(:health_invoices, "no health invoices found for month #{month} and year #{year}")
      end

      unless @has_payroll_deductions
        errors.add(:payroll_deductions, "no payroll deductions found for month #{month} and year #{year}")
      end

      return @has_payroll_deductions && @has_payroll_deductions
    end

    def is_valid_month
      return unless self.month.present?

      unless is_int?(self.month)
        errors.add(:month, 'must be an integer')
        return
      end

      unless [1,2,3,4,5,6,7,8,9,10,11,12].include?(self.month.to_i)
        errors.add(:month, 'must be 1 - 12')
      end
    end

    def is_valid_year
      return unless self.year.present?

      unless is_int?(self.year)
        errors.add(:year, 'must be an integer')
      end
    end

    def is_valid_company_id
      return unless self.company_id.present?

      unless is_int?(self.company_id)
        errors.add(:company_id, 'must be an integer')
        return
      end

      company = Company.find_by(id: self.company_id.to_i)
      unless company.present?
        errors.add(:company_id, 'should be a valid company id')
      end
    end

    def is_int?(input)
      true if Integer(input) rescue false
    end
end