class UpdatePublicSiteMarkdownDefault < ActiveRecord::Migration[8.1]
  PREVIOUS_DEFAULT = <<~MARKDOWN.freeze
    # {{ bandName }}

    {{ contact }}

    ## Upcoming shows

    {{ gigList | future }}
  MARKDOWN

  DEFAULT = <<~MARKDOWN.freeze
    # {{ bandName }}

    {{ description }}

    {{ contact }}

    ## Upcoming shows

    {{ gigList | future }}
  MARKDOWN

  def up
    change_column_default :bands, :public_site_markdown, DEFAULT
    execute "UPDATE bands SET public_site_markdown = #{connection.quote(DEFAULT)} WHERE public_site_markdown = #{connection.quote(PREVIOUS_DEFAULT)}"
  end

  def down
    change_column_default :bands, :public_site_markdown, PREVIOUS_DEFAULT
  end
end
