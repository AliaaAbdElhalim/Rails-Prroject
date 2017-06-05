ActiveAdmin.register Course do
  permit_params :title , :user_id

  index do
    selectable_column
    id_column
    column :title
    column :created_at
    column :updated_at
    actions
  end
  filter :user_id

  form do |f|
	    f.inputs "Course Details" do
	      f.input :title
	      f.input :user_id, :label => 'User', :as => :select, :collection => User.where(status:'teacher').map{|u| ["#{u.name}", u.id]}

	    end
      
	    # f.buttons
	    f.actions
	  end
end  