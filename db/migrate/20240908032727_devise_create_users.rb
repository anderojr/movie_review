# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :username,           null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.boolean :admin,             default: false
      t.string :first_name,         null: false
      t.string :last_name,          null: false
      
      # Users must change their password on first login
      t.boolean :valid_password,    default: false
      
      ## Rememberable
      t.datetime :remember_created_at


      t.timestamps null: false
    end

    add_index :users, :username,             unique: true
  end
end
