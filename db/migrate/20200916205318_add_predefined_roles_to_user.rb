class AddPredefinedRolesToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :predefined_roles, :string
  end
end
