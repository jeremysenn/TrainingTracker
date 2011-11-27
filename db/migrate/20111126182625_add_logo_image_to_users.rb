class AddLogoImageToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :logo_image, :string
  end

  def self.down
    remove_column :users, :logo_image
  end
end
