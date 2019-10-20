# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20191020200102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "administrations", force: :cascade do |t|
    t.integer "adm"
    t.bigint "state_id"
    t.bigint "city_ibge_code"
    t.string "preposition"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cod"
    t.string "contact_name"
    t.index ["adm"], name: "index_administrations_on_adm"
    t.index ["city_ibge_code"], name: "index_administrations_on_city_ibge_code"
    t.index ["cod"], name: "index_administrations_on_cod"
    t.index ["state_id"], name: "index_administrations_on_state_id"
  end

  create_table "administrations_collects", id: false, force: :cascade do |t|
    t.bigint "collect_id", null: false
    t.bigint "administration_id", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.string "ibge_code"
    t.index ["name"], name: "index_cities_on_name"
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "collect_entries", force: :cascade do |t|
    t.bigint "collect_id"
    t.string "name"
    t.string "school_inep"
    t.string "adm_cod"
    t.string "phase"
    t.integer "size"
    t.integer "sample_size"
    t.integer "school_sequence"
    t.integer "group", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "card_id"
    t.boolean "substitute", default: false
    t.boolean "quitter", default: false
    t.string "member_email"
    t.index ["collect_id"], name: "index_collect_entries_on_collect_id"
  end

  create_table "collects", force: :cascade do |t|
    t.string "name"
    t.string "phase"
    t.text "form_sections", default: [], array: true
    t.string "form_assembly_params"
    t.datetime "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "form_id"
    t.integer "status", default: 0, null: false
    t.bigint "pipe_id"
    t.index ["form_id"], name: "index_collects_on_form_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "collect_id"
    t.string "school_inep"
    t.string "school_phone"
    t.string "principal_name"
    t.string "principal_phone"
    t.string "principal_email"
    t.string "coordinator1_name"
    t.string "coordinator1_phone"
    t.string "coordinator1_email"
    t.string "coordinator2_name"
    t.string "coordinator2_phone"
    t.string "coordinator2_email"
    t.string "coordinator3_name"
    t.string "coordinator3_phone"
    t.string "coordinator3_email"
    t.string "member_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "send_to_pipefy", default: false
    t.index ["collect_id"], name: "index_contacts_on_collect_id"
  end

  create_table "form_options", force: :cascade do |t|
    t.text "sections_to_show", default: [], array: true
    t.string "dependencia_desc"
    t.string "state_or_city"
    t.string "form_assembly_params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deadline"
    t.string "form_name"
  end

  create_table "forms", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "link", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_forms_on_name"
  end

  create_table "notices", force: :cascade do |t|
    t.text "content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pipefy_members", force: :cascade do |t|
    t.bigint "pipefy_id"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pipefy_pipes", force: :cascade do |t|
    t.bigint "pipefy_id"
    t.string "name"
    t.text "labels", default: [], array: true
    t.text "phases", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "inep"
    t.text "name"
    t.integer "tp_dependencia"
    t.string "tp_dependencia_desc"
    t.string "cod_municipio"
    t.text "municipio"
    t.string "unidade_federativa"
    t.integer "num_estudantes"
    t.integer "ano_censo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sample", default: false
    t.string "adm_cod"
    t.string "region"
    t.integer "num_students_fund"
    t.string "location"
    t.index ["adm_cod"], name: "index_schools_on_adm_cod"
    t.index ["inep"], name: "index_schools_on_inep"
    t.index ["name"], name: "index_schools_on_name"
  end

  create_table "states", force: :cascade do |t|
    t.string "acronym"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_states_on_name"
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "school_id"
    t.integer "status"
    t.string "school_phone"
    t.string "submitter_name"
    t.string "submitter_email"
    t.string "submitter_phone"
    t.integer "response_id"
    t.string "redirected_at"
    t.string "saved_at"
    t.string "modified_at"
    t.string "submitted_at"
    t.string "form_name"
    t.string "adm_cod"
    t.bigint "collect_id"
    t.bigint "collect_entry_id"
    t.string "school_inep"
    t.bigint "card_id"
    t.index ["adm_cod"], name: "index_submissions_on_adm_cod"
    t.index ["collect_entry_id"], name: "index_submissions_on_collect_entry_id"
    t.index ["collect_id"], name: "index_submissions_on_collect_id"
    t.index ["school_id"], name: "index_submissions_on_school_id"
    t.index ["school_inep"], name: "index_submissions_on_school_inep"
  end

  add_foreign_key "administrations", "states"
  add_foreign_key "cities", "states"
  add_foreign_key "collect_entries", "collects"
  add_foreign_key "collects", "forms"
  add_foreign_key "contacts", "collects"
  add_foreign_key "submissions", "collect_entries"
  add_foreign_key "submissions", "collects"
  add_foreign_key "submissions", "schools"

  create_view "submissions_reports", materialized: true,  sql_definition: <<-SQL
      SELECT matview.adm_cod,
      max(matview.collect_id) AS collect_id,
      max(matview.administration_name) AS adm_name,
      max(matview.administration_contact_name) AS adm_contact,
      sum((matview.sample_count)::integer) AS total_schools_count,
      sum((
          CASE
              WHEN (matview.collect_entries_group = 1) THEN matview.sample_count
              ELSE (0)::bigint
          END)::integer) AS sample_count,
      sum((matview.quitter_count)::integer) AS quitters_count,
      sum((
          CASE
              WHEN (matview.collect_entries_group = 1) THEN matview.quitter_count
              ELSE (0)::bigint
          END)::integer) AS quitters_in_sample_count,
      sum((matview.substitute_count)::integer) AS substitutes_count,
      sum((matview.redirected_count)::integer) AS redirected_count,
      sum((
          CASE
              WHEN (matview.collect_entries_group = 1) THEN matview.redirected_count
              ELSE (0)::bigint
          END)::integer) AS redirected_in_sample_count,
      sum((matview.in_progress_count)::integer) AS in_progress_count,
      sum((
          CASE
              WHEN (matview.collect_entries_group = 1) THEN matview.in_progress_count
              ELSE (0)::bigint
          END)::integer) AS in_progress_in_sample_count,
      sum((matview.submitted_count)::integer) AS submitted_count,
      sum((
          CASE
              WHEN (matview.collect_entries_group = 1) THEN matview.submitted_count
              ELSE (0)::bigint
          END)::integer) AS submitted_in_sample_count,
      sum((matview.answered_count)::integer) AS answered_count,
      round(((sum(matview.answered_count) * 100.0) / sum(
          CASE
              WHEN (matview.collect_entries_group = 1) THEN matview.sample_count
              ELSE (0)::bigint
          END)), 2) AS sample_percent,
      round(((sum(matview.submitted_count) * 100.0) / sum(matview.sample_count)), 2) AS total_percent
     FROM ( SELECT t1.adm_cod,
              t1."group" AS collect_entries_group,
              max(t1.collect_id) AS collect_id,
              max(t1.administration_name) AS administration_name,
              max(t1.administration_contact_name) AS administration_contact_name,
              count(*) AS sample_count,
              sum(t1.quitters) AS quitter_count,
              sum(
                  CASE
                      WHEN ((t1.max_status = 0) AND (t1.quitters = 0)) THEN 1
                      ELSE 0
                  END) AS redirected_count,
              sum(
                  CASE
                      WHEN ((t1.max_status = 1) AND (t1.quitters = 0)) THEN 1
                      ELSE 0
                  END) AS in_progress_count,
              sum(
                  CASE
                      WHEN ((t1.max_status = 2) AND (t1.quitters = 0)) THEN 1
                      ELSE 0
                  END) AS submitted_count,
              sum(t1.substitutes) AS substitute_count,
              sum(t1.answered) AS answered_count
             FROM ( SELECT collect_entries.collect_id,
                      collect_entries.school_inep,
                      max(submissions.status) AS max_status,
                      max((administrations.name)::text) AS administration_name,
                      max((administrations.contact_name)::text) AS administration_contact_name,
                      max((collect_entries.adm_cod)::text) AS adm_cod,
                      max(
                          CASE
                              WHEN collect_entries.substitute THEN 1
                              ELSE 0
                          END) AS substitutes,
                      max(
                          CASE
                              WHEN ((submissions.status = 2) AND (NOT collect_entries.quitter) AND ((collect_entries."group" = 1) OR ((collect_entries."group" = 0) AND collect_entries.substitute))) THEN 1
                              ELSE 0
                          END) AS answered,
                      max(
                          CASE
                              WHEN collect_entries.quitter THEN 1
                              ELSE 0
                          END) AS quitters,
                      collect_entries."group"
                     FROM ((collect_entries
                       LEFT JOIN submissions ON (((collect_entries.school_inep)::text = (submissions.school_inep)::text)))
                       LEFT JOIN administrations ON (((collect_entries.adm_cod)::text = (administrations.cod)::text)))
                    GROUP BY collect_entries.collect_id, collect_entries.school_inep, collect_entries."group") t1
            GROUP BY t1.adm_cod, t1."group"
            ORDER BY t1.adm_cod) matview
    GROUP BY matview.adm_cod;
  SQL

end
