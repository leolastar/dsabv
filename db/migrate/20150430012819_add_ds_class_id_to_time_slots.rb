class AddDsClassIdToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :ds_class_id, :integer
  end
end
