class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :socialId
      t.boolean :admin
      t.string :password
      t.string :access_token
      t.string :access_token_secret
      t.int :gender
      t.float :height
      t.int :age

      t.timestamps
    end
  end
end
