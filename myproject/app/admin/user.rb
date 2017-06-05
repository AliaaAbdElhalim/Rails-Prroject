ActiveAdmin.register User do
	permit_params :email, :name, :gender ,:dob , :picture, :password, :password_confirmation , :status

	index do
	    selectable_column
	    id_column
	    column :name
	    column :email
	    column :status
	    column :gender
	    column :dob
	    column :created_at
	    actions
	  end

	  filter :name
	  filter :email
	  filter :status
	  filter :gender



	form do |f|
	    f.inputs "User Details" do
	      f.input :name
	      f.input :gender, :label => 'Gender', as: :select, collection: (["Male", "Female"]),default: "Male",  include_blank: false
	      f.input :status, :label => 'Role', :as => :select, :collection => [["Student","student"],["Teacher","teacher"]]
	      f.input :email
	      f.input :dob, type: 'date', start_year: 1900, end_year: 2000 ,:label=>"Date of birth" 
	      # f.input :picture
	      f.input :password
	      f.input :password_confirmation
	     
	    end
	    # f.buttons
	    f.actions
	  end
end  