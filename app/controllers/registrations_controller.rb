# encoding: utf-8
class RegistrationsController < Devise::RegistrationsController
  layout :determine_layout

  def update
    # required for settings form to submit when password is left blank
    if params[:member][:password].blank?
      params[:member].delete("password")
      params[:member].delete("password_confirmation")
    end
    params[:member].delete("email")

    @member = Member.find(current_member.id)
    if @member.update_attributes(params[:member])
      set_flash_message :notice, :updated
      # Sign in the member bypassing validation in case his password changed
      sign_in @member, :bypass => true
    end

    redirect_to edit_member_registration_path
  end
  
  def create
    build_resource
        
    resource.discountpoint = 50

    if resource.save
      if resource.active_for_authentication?
        
        flash[ :notice ] = '您已經成功註冊，並已經登入系統。'
        
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end

  end
  
  private
    def determine_layout
      params[:action]=="edit" ? "service" : "profile"
    end
    
end