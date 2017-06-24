class CreatePostcode2Bmras < ActiveRecord::Migration[5.1]
  def change
    create_table :postcode2_bmras do |t|
      t.string :postcode
      t.text :bmra
      t.text :name

      t.timestamps
    end
  end
end
