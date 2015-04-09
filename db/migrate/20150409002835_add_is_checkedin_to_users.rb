class AddIsCheckedinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_checkedin, :boolean
  end
end
