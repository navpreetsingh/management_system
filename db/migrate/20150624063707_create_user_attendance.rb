class CreateUserAttendance < ActiveRecord::Migration
  def change
    create_table :acc_monitor_log do |t|
      t.string :name

      t.timestamps
    end
  end
end
