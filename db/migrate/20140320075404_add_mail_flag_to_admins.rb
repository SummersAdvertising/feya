class AddMailFlagToAdmins < ActiveRecord::Migration
  def change
  	add_column :admins, :mail_flag, :boolean
  end
end
