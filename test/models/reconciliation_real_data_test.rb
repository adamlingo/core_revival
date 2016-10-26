require "test_helper"

class ReconciliationRealDataTest < ActiveSupport::TestCase
  FILE_NAME_WITH_REAL_DEDUCTION_DATA='Deduction_Register_Subscriber_BCBS_-_14917935.csv'.freeze
  PATH_TO_ACTUAL_DEDUCTION_FILE = "#{Rails.root}/test/fixtures/#{FILE_NAME_WITH_REAL_DEDUCTION_DATA}".freeze
  FILE_NAME_WITH_REAL_INVOICE_DATA='0000167878_08-01-2016_09-01-2016.csv'.freeze
  PATH_TO_ACTUAL_INVOICE_FILE = "#{Rails.root}/test/fixtures/#{FILE_NAME_WITH_REAL_INVOICE_DATA}".freeze

  TEST_MONTH = 8
  TEST_YEAR = 2016

  def init
    @company = Company.new
    @company.name = 'My Effin Test Company'
    @company.save!

    load_employees_into_new_company_from_real_data_file
    load_payroll_deduction_from_real_data_file(TEST_MONTH, TEST_YEAR)
    load_health_invoice_from_real_data_file

    invoice = HealthInvoice.last

    benefit_profile = BenefitProfile.new
    benefit_profile.account_number = invoice.account_number
    benefit_profile.company_id = @company.id
    benefit_profile.name = 'BenefitProfile - Test'
    benefit_profile.provider = 'BenefitProfile - provider'
    benefit_profile.provider_plan = 'BenefitProfile - plan'
    benefit_profile.benefit_type = 'Medical'
    benefit_profile.benefit_method = '%'
    benefit_profile.save!

  end

  test 'should do the needful' do
    init

    reconciliation = Reconciliation.new(@company.id, TEST_MONTH, TEST_YEAR)
    expected = 'IDK!'
    #actual = Reconciliation.do_it(@company.id)
    actual = reconciliation.calculate
    puts actual

    assert_equal actual, expected
  end

  private

  def load_payroll_deduction_from_real_data_file(month, year)
    puts 'load_payroll_deduction_from_real_data_file not implemented'
    file = File.new(PATH_TO_ACTUAL_DEDUCTION_FILE)
    before = PayrollDeduction.all.count

    PayrollDeduction.import(file, month, year)

    after = PayrollDeduction.all.count
    puts "deductions -\nbefore: #{before} \nafter: #{after}"
  end

  def load_health_invoice_from_real_data_file
    file = File.new(PATH_TO_ACTUAL_INVOICE_FILE)
    before = HealthInvoice.all.count

    HealthInvoice.import(file)

    after = HealthInvoice.all.count
    puts "invoices -\nbefore: #{before} \nafter: #{after}"
  end

  def load_employees_into_new_company_from_real_data_file
    file = File.new(PATH_TO_ACTUAL_DEDUCTION_FILE)

    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      # puts row_hash

      id = row_hash['Employee ID']

      unless id.blank?
        name = row_hash['Employee Name']
        subscriber_id = row_hash['Subscriber  #   ']
        names = name.split(',')

        emp = Employee.create!(company_id: @company.id,
                                sub_id: subscriber_id,
                                last_name: names[0],
                                first_name: names[1].sub(/\ /, '')
                                )
      end
    end
  end
end