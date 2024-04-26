class CreatePesans < ActiveRecord::Migration[6.1]
  def change
    create_table :pesans do |t|
      t.text :text
      t.references :conversation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
