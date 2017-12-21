class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :zip_code
      t.string :name
      t.string :email
      t.string :password
      t.string :work_hours
      t.string :home_type
      t.string :allergies
      t.string :noise_level
      t.string :kids
      t.string :pets
      t.string :activity_level

      t.timestamps
    end
  end
end
