class AddPublicSiteToBands < ActiveRecord::Migration[8.1]
  DEFAULT_PUBLIC_SITE_MARKDOWN = <<~MARKDOWN.freeze
    # {{ bandName }}

    {{ description }}

    {{ contact }}

    ## Upcoming shows

    {{ gigList | future }}
  MARKDOWN

  def change
    add_column :bands, :public_site_enabled, :boolean, default: false, null: false
    add_column :bands, :public_domain, :string
    add_column :bands, :public_contact_email, :string
    add_column :bands, :public_site_markdown, :text, default: DEFAULT_PUBLIC_SITE_MARKDOWN, null: false
    add_column :bands, :merch_url, :string
    add_index :bands, :public_domain, unique: true
  end
end
