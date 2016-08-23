class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.references :user, foreign_key: true
      t.datetime :start_time, :null=>false
      t.datetime :end_time, :null=>false
      t.string :comment

      t.timestamps
    end
  end
end
