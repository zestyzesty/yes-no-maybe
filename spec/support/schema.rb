ActiveRecord::Schema.define do
  self.verbose = false

  create_table :tests, :force => true do |t|
    t.yes_no_maybe_field :contains_oomph
  end
end
