require "spec_helper"
require "helpers/mongoid_helper"

describe YesNoMaybeField do
  class TestObj
    include Mongoid::Document
    include YesNoMaybeField

    yes_no_maybe_field :contains_oomph
  end

  describe "module behavior" do
    let(:obj) { TestObj.new }

    it "initializes to maybe" do
      expect(obj.contains_oomph?).to be false
      expect(obj.contains_oomph_yes?).to be false
      expect(obj.contains_oomph_maybe?).to be true
      expect(obj.contains_oomph_no?).to be false
    end

    it "can be set to yes" do
      obj.contains_oomph = :yes

      expect(obj.contains_oomph?).to be true
      expect(obj.contains_oomph_yes?).to be true
      expect(obj.contains_oomph_maybe?).to be false
      expect(obj.contains_oomph_no?).to be false
    end

    it "can be set to no" do
      obj.contains_oomph = :no

      expect(obj.contains_oomph?).to be false
      expect(obj.contains_oomph_yes?).to be false
      expect(obj.contains_oomph_maybe?).to be false
      expect(obj.contains_oomph_no?).to be true
    end

    describe "finders" do
      let!(:yes_obj) { TestObj.create(contains_oomph: :yes) }
      let!(:no_obj) { TestObj.create(contains_oomph: :no) }
      let!(:maybe_obj) { TestObj.create(contains_oomph: :maybe) }
      let!(:nil_obj) { TestObj.create(contains_oomph: nil) }

      it "finds yes" do
        expect(TestObj.contains_oomph).to match_array([yes_obj])
      end

      it "finds no" do
        expect(TestObj.contains_oomph_no).to match_array([no_obj])
      end

      it "finds maybe" do
        expect(TestObj.contains_oomph_maybe).to match_array([maybe_obj, nil_obj])
      end
    end
  end
end
