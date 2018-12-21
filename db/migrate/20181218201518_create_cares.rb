class CreateCares < ActiveRecord::Migration[5.2]
  def change
    create_table :cares do |t|
      t.boolean :fed
      t.boolean :medicated
      t.datetime :fedAt
      t.datetime :medicatedAt

      t.timestamps
    end
  end
end
