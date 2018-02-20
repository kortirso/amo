class CreateConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :configs do |t|
      t.string :api_key, default: ''
      t.timestamps
    end
  end
end
