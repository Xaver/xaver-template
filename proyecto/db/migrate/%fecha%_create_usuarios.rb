# -*- encoding : utf-8 -*-
class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :username, :email, :crypted_password, :salt, :rol

      t.timestamps
    end
  end
end