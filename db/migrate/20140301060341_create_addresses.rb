class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|

      t.string :address
      t.integer :zipcode
      t.string  :website
      t.integer :phone_no
 	  t.references :addressable, polymorphic: true
      t.timestamps
    end
  end
end