class HealthInvoicesImporter < ResourceModel::Base
  string_accessor :company_id
  string_accessor :month
  string_accessor :year

  validates_presence_of :company_id
  validates_presence_of :month
  validates_presence_of :year

  validate :is_valid_company_id
  validate :is_valid_month
  validate :is_valid_year

  attr_reader :health_invoices

  def initialize(attributes = {})
    super(attributes)
  end

  def import!(file)
    return false unless self.valid?
    invoice_date = get_invoice_date(file)
    
    is_valid_date = true
    if invoice_date.month != self.month.to_i
      errors.add(:month, "month in file name does not match input month")
      is_valid_date = false
    end

    if invoice_date.year != self.year.to_i
      errors.add(:year, "year in file name does not match input year")
      is_valid_date = false
    end

    unless is_valid_date
      return false
    end

    @health_invoices = HealthInvoice.import_by_month_and_year(file, self.month.to_i, self.year.to_i)
    true
  end

  private
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

    def get_invoice_date(file)
      if (file.respond_to?(:original_filename))
        filename = file.original_filename
      else
        filename = File.basename(file.path)
      end

      HealthInvoice.convert_to_date(filename)
    end
end