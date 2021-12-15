class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.timestamps

      t.integer :worker_id
      t.string :check_in_date
      t.string :check_in_time
      t.string :check_out_date
      t.string :check_out_time
      t.string :check_in_weekday
      t.string :check_out_weekday
      t.date :check_in_full_date
      t.date :check_out_full_date
    end
  end
end
