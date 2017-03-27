class AddShuttlerockImageIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :shuttlerock_image_id, :string
  end
end
