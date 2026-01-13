# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_01_13_224448) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "ai_anthropic_api_key"
    t.string "ai_local_url"
    t.string "ai_openai_api_key"
    t.string "ai_provider"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_accounts_on_slug", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "band_memberships", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.datetime "created_at", null: false
    t.datetime "invitation_accepted_at"
    t.datetime "invitation_sent_at"
    t.string "invitation_token"
    t.string "invited_email"
    t.integer "role", default: 1, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["band_id", "invited_email"], name: "index_band_memberships_on_band_id_and_invited_email", unique: true
    t.index ["band_id", "user_id"], name: "index_band_memberships_on_band_id_and_user_id", unique: true
    t.index ["band_id"], name: "index_band_memberships_on_band_id"
    t.index ["invitation_token"], name: "index_band_memberships_on_invitation_token", unique: true
    t.index ["user_id"], name: "index_band_memberships_on_user_id"
  end

  create_table "bands", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "bandcamp"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "facebook"
    t.string "instagram"
    t.string "location"
    t.string "name", null: false
    t.string "phone"
    t.string "private_calendar_token"
    t.boolean "public_calendar_enabled", default: false, null: false
    t.boolean "public_calendar_include_rehearsals", default: false, null: false
    t.string "public_calendar_token"
    t.string "soundcloud"
    t.string "twitter"
    t.datetime "updated_at", null: false
    t.string "youtube"
    t.index ["account_id"], name: "index_bands_on_account_id"
    t.index ["private_calendar_token"], name: "index_bands_on_private_calendar_token", unique: true
    t.index ["public_calendar_token"], name: "index_bands_on_public_calendar_token", unique: true
  end

  create_table "chat_channel_participants", force: :cascade do |t|
    t.bigint "chat_channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["chat_channel_id", "user_id"], name: "index_chat_channel_participants_unique", unique: true
    t.index ["chat_channel_id"], name: "index_chat_channel_participants_on_chat_channel_id"
    t.index ["user_id"], name: "index_chat_channel_participants_on_user_id"
  end

  create_table "chat_channels", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.datetime "created_at", null: false
    t.integer "kind", default: 0, null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_chat_channels_on_band_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "chat_channel_id", null: false
    t.datetime "created_at", null: false
    t.bigint "parent_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["chat_channel_id"], name: "index_chat_messages_on_chat_channel_id"
    t.index ["parent_id"], name: "index_chat_messages_on_parent_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "event_setlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "event_id", null: false
    t.bigint "setlist_id", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "setlist_id"], name: "index_event_setlists_on_event_id_and_setlist_id", unique: true
    t.index ["event_id"], name: "index_event_setlists_on_event_id"
    t.index ["setlist_id"], name: "index_event_setlists_on_setlist_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.datetime "created_at", null: false
    t.integer "kind", default: 0, null: false
    t.text "notes"
    t.datetime "starts_at"
    t.datetime "updated_at", null: false
    t.string "venue"
    t.index ["band_id"], name: "index_events_on_band_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.bigint "default_band_id"
    t.integer "role", default: 2, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["account_id", "user_id"], name: "index_memberships_on_account_id_and_user_id", unique: true
    t.index ["account_id"], name: "index_memberships_on_account_id"
    t.index ["default_band_id"], name: "index_memberships_on_default_band_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "setlist_songs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "position", default: 0, null: false
    t.bigint "setlist_id", null: false
    t.bigint "song_id", null: false
    t.datetime "updated_at", null: false
    t.index ["setlist_id", "position"], name: "index_setlist_songs_on_setlist_id_and_position"
    t.index ["setlist_id", "song_id"], name: "index_setlist_songs_on_setlist_id_and_song_id"
    t.index ["setlist_id"], name: "index_setlist_songs_on_setlist_id"
    t.index ["song_id"], name: "index_setlist_songs_on_song_id"
  end

  create_table "setlists", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "band_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_setlists_on_account_id"
    t.index ["band_id"], name: "index_setlists_on_band_id"
  end

  create_table "songs", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "album"
    t.string "artist"
    t.bigint "band_id", null: false
    t.string "chart_url"
    t.datetime "created_at", null: false
    t.integer "duration_seconds"
    t.string "key"
    t.text "notes"
    t.string "original_artist"
    t.bigint "singer_band_membership_id"
    t.string "singer_name"
    t.integer "tempo"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.string "video_url"
    t.index ["account_id"], name: "index_songs_on_account_id"
    t.index ["band_id"], name: "index_songs_on_band_id"
    t.index ["singer_band_membership_id"], name: "index_songs_on_singer_band_membership_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "tag_id", null: false
    t.bigint "taggable_id", null: false
    t.string "taggable_type", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id", "taggable_type", "taggable_id"], name: "index_taggings_on_tag_id_and_taggable_type_and_taggable_id", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable"
  end

  create_table "tags", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "color", default: "blue", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "name"], name: "index_tags_on_account_id_and_name", unique: true
    t.index ["account_id"], name: "index_tags_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "song_sort", default: "title", null: false
    t.string "song_sort_direction", default: "asc", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "band_memberships", "bands"
  add_foreign_key "band_memberships", "users"
  add_foreign_key "bands", "accounts"
  add_foreign_key "chat_channel_participants", "chat_channels"
  add_foreign_key "chat_channel_participants", "users"
  add_foreign_key "chat_channels", "bands"
  add_foreign_key "chat_messages", "chat_channels"
  add_foreign_key "chat_messages", "chat_messages", column: "parent_id"
  add_foreign_key "chat_messages", "users"
  add_foreign_key "event_setlists", "events"
  add_foreign_key "event_setlists", "setlists"
  add_foreign_key "events", "bands"
  add_foreign_key "memberships", "accounts"
  add_foreign_key "memberships", "bands", column: "default_band_id"
  add_foreign_key "memberships", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "setlist_songs", "setlists"
  add_foreign_key "setlist_songs", "songs"
  add_foreign_key "setlists", "accounts"
  add_foreign_key "setlists", "bands"
  add_foreign_key "songs", "accounts"
  add_foreign_key "songs", "band_memberships", column: "singer_band_membership_id"
  add_foreign_key "songs", "bands"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tags", "accounts"
end
