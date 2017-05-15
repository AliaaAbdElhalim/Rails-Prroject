class AddUser < ActiveRecord::Migration
  def change
  	add_column :users , :name , :string
  	add_column :users , :dob , :datetime
  	add_column :users , :gender , :string
  	add_column :users , :picture , :string
  end
end
