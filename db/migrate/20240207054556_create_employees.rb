class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :Employee_id
      t.string :FirstName
      t.string :lastName
      t.string :Email
      t.string :PhoneNumber
      t.date :DOJ
      t.integer :Salary

      t.timestamps
    end
  end
end
