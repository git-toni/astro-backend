class CreateTelescopes < ActiveRecord::Migration[5.0]
  def change
    create_table :telescopes do |t|
      t.string :name
      t.string :regime
      t.string :operator
      t.string :cospar_id

      t.timestamps
    end
  end
end
