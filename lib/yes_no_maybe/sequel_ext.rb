# coding: utf-8
module YesNoMaybe
  module SequelExt
    extend ActiveSupport::Concern

    module ClassMethods
      def yes_no_maybe_field(field_name, column_name: nil)
        column_name = column_name || field_name
        same_name = column_name == field_name

        define_method(field_name) do
          column_val = same_name ? super() : send(column_name)
          column_val.nil? ? :maybe : column_val.to_sym
        end

        define_method("#{field_name}=") do |val|
          if same_name
            super(val && val.to_s)
          else
            send("#{column_name}=", val && val.to_s)
          end
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

        ## class methods
        define_singleton_method("#{field_name}") do
          where(column_name => "yes")
        end
        define_singleton_method("#{field_name}_yes") do
          where(column_name => "yes")
        end
        define_singleton_method("#{field_name}_maybe") do
          where{ Sequel.|({column_name => "maybe"},{ column_name => nil})}
        end
        define_singleton_method("#{field_name}_no") do
          where(column_name => "no")
        end
      end
    end
  end
end
