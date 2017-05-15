ActiveAdmin.register User do
  permit_params :email, :name, :gender ,:dob , :picture
end  