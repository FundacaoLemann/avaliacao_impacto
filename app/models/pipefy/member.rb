class Pipefy::Member < ApplicationRecord
  has_many :collect_entries, foreign_key: 'email', primary_key: 'member_email'
end
