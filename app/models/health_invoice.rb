class HealthInvoice < ActiveRecord::Base
  # Need code to fix: "Mass assignment is not restricted using attr_accessible"

  # change column_names to specific fields after test
  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |health_invoice|
        csv << health_invoice.attributes.values_at(*fields)
      end
    end
  end

  def self.import(file)
    # Parse file name for Year/Month>> string split by underscore [0]billing prof ID [1] month/year
    # Check dups by parsing to billing profile ID and year/month 
    CSV.foreach(file.path, headers: true) do |row|
      health_invoice_hash = row.to_hash
      # all columns in Health csv
      health_invoice = find_or_create_by!(account_number: health_invoice_hash['Account'],
                                          billing_profile: health_invoice_hash['BillingProfile'],
                                          category: health_invoice_hash['Category'],
                                          product: health_invoice_hash['Product'],
                                          health_sub_id: health_invoice_hash['Subscriber ID'],
                                          sub_name: health_invoice_hash['Subscriber Name'],
                                          tier: health_invoice_hash['Tier'],
                                          change_reason: health_invoice_hash['Change Reason'],
                                          retro_fee_adjustment: health_invoice_hash['Retro Fee Adjustment'],
                                          current_charges: health_invoice_hash['Current Charges'],
                                          total_charges: health_invoice_hash['Total Charges'])
      health_invoice.save!
    end
  end
end
