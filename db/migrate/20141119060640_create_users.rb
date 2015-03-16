class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.string   :password_digest
  	  t.string   :address
      t.string   :phone
      t.string   :emergency_contact_name
      t.string   :emergency_contact_phone
      t.string   :remember_digest
      t.string   :activation_digest
      t.string   :reset_digest
      t.datetime :activated_at
      t.datetime :reset_sent_at
      t.boolean  :activated, default: false
      t.boolean  :admin,     default: false

      t.datetime :event_register_email_notify

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
