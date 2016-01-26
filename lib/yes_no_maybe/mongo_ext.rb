module YesNoMaybe
  module MongoExt
    extend ActiveSupport::Concern

    module ClassMethods

      def yes_no_maybe_field(field_name)
        field field_name, type: Symbol

        define_method(field_name) do
          super() || :maybe
        end

        # queries
        define_method("#{field_name}?") do
          send(field_name) == :yes
        end
        define_method("#{field_name}_yes?") do
          send(field_name) == :yes
        end
        define_method("#{field_name}_no?") do
          send(field_name) == :no
        end
        define_method("#{field_name}_maybe?") do
          send(field_name) == :maybe || send(field_name).nil?
        end

        # scopes
        scope "#{field_name}", -> { where(field_name => :yes) }
        scope "#{field_name}_yes", -> { where(field_name => :yes) }
        scope "#{field_name}_maybe", -> { all.or({field_name => :maybe}, {field_name => nil}) }
        scope "#{field_name}_no", -> { where(field_name => :no) }

      end
    end
  end
end
