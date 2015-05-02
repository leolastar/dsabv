class AddClassSlotIdToDays < ActiveRecord::Migration
  def change
    add_reference :days, :class_slot, index: true, foreign_key: true
  end
end
