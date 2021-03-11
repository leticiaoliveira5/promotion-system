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

ActiveRecord::Schema.define(version: 20_210_213_173_658) do
  create_table 'coupons', force: :cascade do |t|
    t.string 'code'
    t.integer 'promotion_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'status', default: 0
    t.index ['code'], name: 'index_coupons_on_code', unique: true
    t.index ['promotion_id'], name: 'index_coupons_on_promotion_id'
  end

  create_table 'product_categories', force: :cascade do |t|
    t.string 'name'
    t.string 'code'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['code'], name: 'index_product_categories_on_code', unique: true
  end

  create_table 'product_category_promotions', force: :cascade do |t|
    t.integer 'product_category_id'
    t.integer 'promotion_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_category_id'], name: 'index_product_category_promotions_on_product_category_id'
    t.index ['promotion_id'], name: 'index_product_category_promotions_on_promotion_id'
  end

  create_table 'promotion_approvals', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'promotion_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['promotion_id'], name: 'index_promotion_approvals_on_promotion_id'
    t.index ['user_id'], name: 'index_promotion_approvals_on_user_id'
  end

  create_table 'promotions', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.string 'code'
    t.integer 'discount_rate'
    t.decimal 'coupon_quantity'
    t.date 'expiration_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.index ['user_id'], name: 'index_promotions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
