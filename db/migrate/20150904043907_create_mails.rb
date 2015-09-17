class CreateMails < ActiveRecord::Migration
  def change
  	create_table :samples do |t|
      t.string  :id
      t.string :name
      t.timestamps
    end
  end
end