class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :grade
      t.string :assignment_name
      t.date :date_due
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
