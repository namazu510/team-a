class CreateWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :weights do |t|
      t.references :user, foreign_key: true
      t.float :weight, :null=>false
      t.float :bmi, :null=>false

      t.timestamps
    end
  end
end
