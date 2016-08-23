class CreateWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :weights do |t|
      t.float :weight ,:null=>false
      t.float :bmi ,:null=>false

      t.references :user

      t.timestamps
    end
  end
end
