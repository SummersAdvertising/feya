class AddCreditFormToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :credit_form, :string
  end
end
