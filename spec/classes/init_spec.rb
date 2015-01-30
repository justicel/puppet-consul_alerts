require 'spec_helper'
describe 'consul_alerts' do

  context 'with defaults for all parameters' do
    it { should contain_class('consul_alerts') }
  end
end
