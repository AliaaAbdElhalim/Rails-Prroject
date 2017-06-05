class AddLecattachementToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :lecattachement, :string 
  end
end
