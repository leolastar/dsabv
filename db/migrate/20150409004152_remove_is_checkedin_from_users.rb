class RemoveIsCheckedinFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :is_checkedin, :boolean
  end
end
