require 'spec_helper'

RSpec.describe Galvanize::CLI do
  describe 'class method' do
    describe 'banner' do
      it 'has a default banner' do
        expect(subject.banner).to match /galvanize/
      end
    end
  end
end
