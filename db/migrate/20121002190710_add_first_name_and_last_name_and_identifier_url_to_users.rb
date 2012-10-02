class AddFirstNameAndLastNameAndIdentifierUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :identifier_url, :string
    remove_column :users, :name
    remove_column :users, :login
  end
end
