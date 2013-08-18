class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :label
      t.datetime :start_time
      t.boolean :approved, default: false
      t.boolean :booked, default: false
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
