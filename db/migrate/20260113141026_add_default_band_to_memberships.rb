class AddDefaultBandToMemberships < ActiveRecord::Migration[8.0]
  def change
    add_reference :memberships, :default_band, foreign_key: { to_table: :bands }
  end
end
