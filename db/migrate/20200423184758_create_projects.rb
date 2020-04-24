class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :tags, array: true, default: []
      t.string :project_type, null: false

      t.timestamps
    end
  end
end
