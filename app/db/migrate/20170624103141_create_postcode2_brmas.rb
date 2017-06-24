class CreatePostcode2Brmas < ActiveRecord::Migration[5.1]
  def change
    create_table :postcode2_brmas do |t|
      t.string :postcode
      t.text :brma
      t.text :name

      t.timestamps
    end
  end
end
