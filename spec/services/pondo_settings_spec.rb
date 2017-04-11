require 'rails_helper'

RSpec.describe PondoSettings do
  let(:config) do
    {
      foo: {
        bar: %w{a b c}
      },
      a: {
        b: {
          c: {
            d: "e"
          }
        }
      }
    }
  end
  subject(:settings) { PondoSettings.load_conf(config) }

  describe "#get" do
    subject(:get) { settings.get(*args) }

    {
      %i{foo} => { bar: %w{a b c} },
      %i{foo bar} => %w{a b c},
      %i{a b c d} => "e",
    }.each do |the_args, the_expectation|
      context "when passed with #{the_args}" do
        let(:args) { the_args }
        it do
          expected = if the_expectation.respond_to?(:with_indifferent_access) then
                       the_expectation.with_indifferent_access
                     else
                       the_expectation
                     end
          is_expected.to eql(expected)
        end
      end
    end

    context "when passed with invalid keys" do
      let(:args) { %i{foo zar} }
      it "raises error" do
        expect { settings.get(*args) }.to raise_error(
          PondoSettingsError, "Non-existent key 'zar'"
        )
      end
    end
  end
end

