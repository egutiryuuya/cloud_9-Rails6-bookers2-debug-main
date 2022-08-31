class AddcolumnMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :title, :text
  end
end
