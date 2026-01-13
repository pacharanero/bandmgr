class AllowInvitedEmailOnBandMemberships < ActiveRecord::Migration[8.0]
  def change
    change_column_null :band_memberships, :user_id, true
    add_column :band_memberships, :invited_email, :string

    add_index :band_memberships, [:band_id, :invited_email], unique: true
  end
end
