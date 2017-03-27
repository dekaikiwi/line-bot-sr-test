class AddIsResponseToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :is_response, :boolean, default: false
  end
end
