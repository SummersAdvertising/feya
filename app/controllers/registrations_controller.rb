class RegistrationsController < Devise::RegistrationsController
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
end