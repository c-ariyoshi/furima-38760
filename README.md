# README

# テーブル設計

## users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false, unique:true |
| encrypted_password | string | null: false              |
| family_name        | string | null: false              |
| first_name         | string | null: false              |
| family_name_kana   | string | null: false              |
| first_name_kana    | string | null: false              |
| birth_day          | date   | null: false              |


### Association

- has_many :items
- belongs_to :destination

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| price         | string     | null: false                    |
| description   | string     | null: false                    |
| category      | string     | null: false                    |
| item_condition| string     | null: false                    |
| commission    | string     | null: false                    |
| prefecture    | string     | null: false                    |
| shipping_fee  | string     | null: false                    |
| shipping_days | string     | null: false                    |
| user          | references | null: false, foreign_key: true |


### Association

- belongs_to :user

## destination テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| post_code    | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| address      | string     | null: false                    |
| building_name| string     |                                |
| phone_number | string     | null: false                    |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :items
