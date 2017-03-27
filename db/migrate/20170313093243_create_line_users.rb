class CreateLineUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :line_users do |t|
      t.string :username
      t.string :mid

      t.timestamps
    end
  end
end
