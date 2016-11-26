class BenefitRate < ActiveRecord::Base
    belongs_to :benefit_detail
    validates_presence_of :benefit_detail_id
    
    
    
    def new
    end
    
    def self.compute_rate
    end
    
    def self.import(benefit_detail_id, file_path)
       # file_path = '/home/ubuntu/workspace/core_redux/test/fixtures/BCBS G712PFR.csv'
        CSV.foreach(file_path, headers: true) do |row|
           import_hash = row.to_hash
           unless import_hash['Age'].nil?
                import = find_or_create_by!(age: import_hash['Age'],
                                            benefit_detail_id: benefit_detail_id,
                                            rate: import_hash['Rate'])
            import.save!
           end
        end
    end
    
end
