class CreateSeminars < ActiveRecord::Migration[6.1]
  def change
    create_table :seminars do |t|
      t.string :title
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
