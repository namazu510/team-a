class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name , :null=>false
      t.string :email
      t.boolean :admin , :null=>false, :default=> false
      t.string :password
      t.integer :gender , :default => false
      t.float :height
      t.integer :age

      t.timestamps
    end
  end
end
