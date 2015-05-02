class RemoveDsClassIdFromTimeSlots < ActiveRecord::Migration
  def change
  	remove_column :time_slots, :ds_class_id, :integer
  end
end
