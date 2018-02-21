class AddLoginToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :login, :string, default: ''
  end
end
