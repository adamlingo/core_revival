class CreateBenefitSelectionCategories < ActiveRecord::Migration
  def up
    create_table :benefit_selection_categories do |t|
    	t.string "code", null: false
    	t.string "name", null: false
    	t.string "description", null: false
      t.timestamps null: false
    end

    BenefitSelectionCategory.create!(code: "SUB", name: "Subscriber", description: "Actual subscriber")
    BenefitSelectionCategory.create!(code: "SUB-SPS", name: "Subscriber plus Spouse", description: "Subscriber plus Spouse")
    BenefitSelectionCategory.create!(code: "SUB-DEP", name: "Subscriber plus Dependent", description: "Subscriber plus Dependent")
    BenefitSelectionCategory.create!(code: "SUB-SPS-PLUS-ONE", name: "Subscriber plus Spouse plus Dependent", description: "Subscriber plus Spouse plus Dependent")
    BenefitSelectionCategory.create!(code: "SUB-DEP-PLUS-ONE", name: "Subscriber plus multiple Dependents", description: "Subscriber plus multiple Dependents")
  end

  def down
  	BenefitSelectionCategory.all.delete_all
  end
end
