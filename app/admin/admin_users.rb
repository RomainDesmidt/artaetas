ActiveAdmin.register AdminUser do

  permit_params :username, :login, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
