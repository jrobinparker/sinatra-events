class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.string :start_date
      t.string :start_time
      t.string :end_date
      t.string :end_time
      t.string :description
    end    
  end
end
