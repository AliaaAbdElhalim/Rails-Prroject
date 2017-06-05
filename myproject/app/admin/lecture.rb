ActiveAdmin.register Lecture do
  permit_params :content , :attachement , :course_id, :user_id, :title

  filter :course_id
  filter :user_id

  form do |f|
    f.inputs "Lecture Details" do
      f.input :course_id, :label => 'Course', :as => :select, :collection => Course.all.map{|c| ["#{c.title}", c.id]}
      f.input :user_id, :label => 'User', :as => :select, :collection => User.all.where('users.status="teacher"').map{|u| ["#{u.name}", u.id]}
      f.input :title
      f.input :content
    end
    f.actions
  end

end  