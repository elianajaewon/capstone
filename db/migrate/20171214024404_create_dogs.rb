class CreateDogs < ActiveRecord::Migration[5.1]
  def change
    create_table :dogs do |t|
      t.string :age
      t.string :size
      t.string :grooming
      t.string :bark_level
      t.string :kids
      t.string :pets
      t.string :exercise

      t.timestamps
    end
  end
end
