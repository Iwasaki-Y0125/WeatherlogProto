class AddLocationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :latitude, :decimal, precision: 10, scale: 7
    add_column :users, :longitude, :decimal, precision: 10, scale: 7

    # 位置情報での検索用インデックス
    add_index :users, [:latitude, :longitude], name: 'index_users_on_location'
  end
end
