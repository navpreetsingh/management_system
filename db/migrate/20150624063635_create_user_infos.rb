class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :userinfo do |t|
      t.string :name

      t.timestamps
    end
  end
end
