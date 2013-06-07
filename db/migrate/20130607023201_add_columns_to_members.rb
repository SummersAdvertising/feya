class AddColumnsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :username, :string
    add_column :members, :address, :string
    add_column :members, :tel, :string
    add_column :members, :discountpoint, :integer
  end
end
