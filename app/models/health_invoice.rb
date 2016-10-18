class HealthInvoice < ActiveRecord::Base
  # Need code to fix: "Mass assignment is not restricted using attr_accessible"

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |health_invoice|
        csv << health_invoice.attributes.values_at(*fields)
      end
    end
  end

  def self.import(file)
    health_invoices = []
    if (file.original_filename.present?)
      filename = file.original_filename
    else
      filename = File.basename(file.path)
    end
    puts "filename: #{filename}"

    invoice_date = HealthInvoice.convert_to_date(filename)
    puts "invoice_date: #{invoice_date}"
    # puts "invoice_date month: #{invoice_date.month}"
    # puts "invoice_date year: #{invoice_date.year}"

    # Check dups by parsing to billing profile ID and year/month 
    CSV.foreach(file.path, headers: true) do |row|
      health_invoice_hash = row.to_hash
      # all columns in Health csv
      retro_fee_adjustment = HealthInvoice.convert_to_decimal(health_invoice_hash['RetroFeeAdjustment'])
      current_charges = HealthInvoice.convert_to_decimal(health_invoice_hash['CurrentCharges'])
      total_charges = HealthInvoice.convert_to_decimal(health_invoice_hash['TotalCharges'])

      health_invoice = find_or_create_by!(account_number: health_invoice_hash['Account'].to_i.to_s,
                                          billing_profile: health_invoice_hash['BillingProfile'].to_i.to_s,
                                          category: health_invoice_hash['Category'].to_i.to_s,
                                          product: health_invoice_hash['Product'],
                                          health_sub_id: health_invoice_hash['Subscriber ID'].to_i.to_s,
                                          sub_name: health_invoice_hash['Subscriber Name'],
                                          tier: health_invoice_hash['Tier'],
                                          change_reason: health_invoice_hash['Change Reason'],
                                          retro_fee_adjustment: retro_fee_adjustment,
                                          current_charges: current_charges,
                                          total_charges: total_charges,
                                          month: invoice_date.month,
                                          year: invoice_date.year)
      health_invoice.save!
      health_invoices << health_invoice
    end
    health_invoices
  end

  
  def self.convert_to_decimal(input)
    input.gsub(/\$|,/,'').gsub(/\(/,'-').gsub(/\)/,'').strip
  end

  def self.convert_to_date(file_name)
    puts "file_name: #{file_name}"
    tokens = file_name.split(/_/)
    date_token = tokens[1]
    Date::strptime(date_token, '%m-%d-%Y')
  end
end
