class AddInvitationFieldsToBandMemberships < ActiveRecord::Migration[8.0]
  def change
    change_table :band_memberships, bulk: true do |t|
      t.string :invitation_token
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
    end

    add_index :band_memberships, :invitation_token, unique: true
  end
end
