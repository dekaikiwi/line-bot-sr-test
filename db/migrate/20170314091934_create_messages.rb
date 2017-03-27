class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :message
      t.belongs_to :line_user, index: true

      t.timestamps
    end
  end
end
