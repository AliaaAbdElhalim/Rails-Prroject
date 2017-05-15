class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :content
      t.string :attachement
      t.references :Course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
