# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ----------------   | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | unique: true, null: false |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :records

## items テーブル

| Column      | Type       | Options     |
| ----------- | ---------- | ----------- |
| name        | string     | null: false |
| description | text       | null: false |
| category_id | integer    | null: false |
| status_id   | integer    | null: false |
| burden_id   | integer    | null: false |
| area_id     | integer    | null: false |
| days_id     | integer    | null: false |
| price       | integer    | null: false |
| user        | references |             |

### Association

- belongs_to :user
- has_one :record

## records テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references |                                |
| item         | references |                                |

### Association

- belongs_to :item
- has_one :buyer

## buyers テーブル

| Column        | Type       | Options                        |
| ------------  | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| area_id       | integer    | null: false                    |
| municipality  | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| record        | references |                                |

### Association

- belongs_to :record