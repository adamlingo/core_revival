class HealthInvoice < ActiveRecord::Base
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
    CSV.foreach(file.path, headers: true) do |row|
      health_invoice_hash = row.to_hash
      health_invoice = find_or_create_by!(account_number: health_invoice_hash['Account'],
                                          health_sub_name: health_invoice_hash['Subscriber Name'])
      health_invoice.update_attributes(health_invoice_hash)
    end
  end
end
