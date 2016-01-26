require 'sequel'
DB = Sequel.sqlite # memory database, requires sqlite3
DB.create_table :items do
  primary_key :id
  yes_no_maybe_field :description
end

