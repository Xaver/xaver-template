# -*- encoding : utf-8 -*-
class CreateArchivos < ActiveRecord::Migration
  def change
    create_table :archivos do |t|
      t.string :titulo, :codigo
      t.string :archivo_uid, :archivo_name, :mime_type, :format
      t.integer :width, :height, :peso, :default => 0

      t.string :type
      t.integer :orden
      t.references :propietario, :polymorphic => true
      t.timestamps
    end
    add_index :archivos, [:propietario_id, :propietario_type]
  end
end