class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    
    if  params[:password_confirmation].blank? && params[:password].blank? && params[:email] == resource.email
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:email)
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
    
  end
  
  
  # def after_update_path_for(resource)
  #     user_path(resource)
  # end
  
  # layout 'application'


  # def update
  #   self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)


  #   # custom logic
  #   if params[:user][:password].present?
  #     result = resource.update_with_password(params[resource_name])
  #   else
  #     result = resource.update_without_password(params[resource_name])
  #   end

  #   # standart devise behaviour
  #   if result
  #     if is_navigational_format?
  #       if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
  #         flash_key = :update_needs_confirmation
  #       end
  #       set_flash_message :notice, flash_key || :updated
  #     end
  #     sign_in resource_name, resource, :bypass => true
  #     respond_with resource, :location => after_update_path_for(resource)
  #   else
  #     clean_up_passwords resource
  #     respond_with resource
  #   end
  # end
  
  
end