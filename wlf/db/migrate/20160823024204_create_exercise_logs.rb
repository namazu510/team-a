class CreateExerciseLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :exercise_logs do |t|
      t.references :user, foreign_key: true
      t.datetime :start_time ,:null=>false
      t.datetime :end_time,:null=>false
      t.integer :step_cnt,:null=>false
      t.float :calorie,:null=>false
      t.references :schedule, foreign_key: true

      t.timestamps
    end
  end
end
