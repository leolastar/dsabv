class CreateDsClasses < ActiveRecord::Migration
  def change
    create_table :ds_classes do |t|
      t.string :title
      t.string :place
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
