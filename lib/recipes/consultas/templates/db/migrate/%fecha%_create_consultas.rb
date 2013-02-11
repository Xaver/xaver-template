# -*- encoding : utf-8 -*-
class CreateConsultas < ActiveRecord::Migration
  def change
    create_table :consultas do |t|
      t.string :nombre, :apellido, :telefono, :email, :direccion, :localidad
      t.text :mensaje

      t.timestamps
    end
  end
end