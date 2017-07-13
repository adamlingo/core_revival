class LifeCapPercentage < ActiveRecord::Base
	belongs_to :life_benefit_detail
	
	def self.import(life_benefit_detail_id, file_path)
   # file_path = '/mnt/c/Users/adaml/workspace/core_redux/test/fixtures/LifeCapPercentageExample.csv'
    CSV.foreach(file_path, headers: true) do |row|
       import_hash = row.to_hash
       unless import_hash['Age'].nil?
            import = find_or_create_by!(age: import_hash['Age'],
                                        life_benefit_detail_id: life_benefit_detail_id,
                                        cap_percentage: import_hash['Cap Percentage'])
        import.save!
       end
    end
  end
end
