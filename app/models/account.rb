class Account < ApplicationRecord
  AI_PROVIDERS = %w[openai anthropic local].freeze

  encrypts :encrypted_ai_openai_api_key
  encrypts :encrypted_ai_anthropic_api_key

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :bands, dependent: :destroy
  has_many :songs, through: :bands
  has_many :setlists, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :ai_provider, inclusion: { in: AI_PROVIDERS }, allow_blank: true

  def ai_openai_api_key
    encrypted_ai_openai_api_key
  end

  def ai_openai_api_key=(value)
    self.encrypted_ai_openai_api_key = value
  end

  def ai_anthropic_api_key
    encrypted_ai_anthropic_api_key
  end

  def ai_anthropic_api_key=(value)
    self.encrypted_ai_anthropic_api_key = value
  end

  def ai_enabled?
    case ai_provider
    when "openai"
      ai_openai_api_key.present?
    when "anthropic"
      ai_anthropic_api_key.present?
    when "local"
      ai_local_url.present?
    else
      false
    end
  end

  def ai_configured?
    ai_enabled?
  end
end
