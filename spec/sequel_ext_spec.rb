require "spec_helper"
require "sequel_helper"

module YesNoMaybe
  describe SequelExt do

    # just pick any object with a text field
    class YesNoMaybeTestObj < Sequel::Model(:items)
      include YesNoMaybe::SequelExt

      yes_no_maybe_field :contains_oomph, column_name: :description
    end

    describe "module behavior" do
      let(:obj) { YesNoMaybeTestObj.new }

      it "initializes to maybe" do
        byebug
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

      it "counts nil as maybe" do
        obj.contains_oomph = nil

        expect(obj.contains_oomph).to eq(:maybe)
      end

      describe "finders" do
        let!(:yes_obj) { YesNoMaybeTestObj.create(contains_oomph: :yes) }
        let!(:no_obj) { YesNoMaybeTestObj.create(contains_oomph: :no) }
        let!(:maybe_obj) { YesNoMaybeTestObj.create(contains_oomph: :maybe) }
        let!(:nil_obj) { YesNoMaybeTestObj.create(contains_oomph: nil) }

        it "finds yes" do
          expect(YesNoMaybeTestObj.contains_oomph).to match_array([yes_obj])
        end

        it "finds no" do
          expect(YesNoMaybeTestObj.contains_oomph_no).to match_array([no_obj])
        end

        it "finds maybe" do
          expect(YesNoMaybeTestObj.contains_oomph_maybe).to match_array([maybe_obj, nil_obj])
        end
      end
    end
  end
end
