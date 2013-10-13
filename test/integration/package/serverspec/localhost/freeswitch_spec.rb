require 'spec_helper'

describe 'FreeSWITCH' do
  describe user('freeswitch') do
    it { should exist }
    it { should belong_to_group 'freeswitch' }
  end

  describe service('freeswitch') do
    it { should be_enabled }
    it { should be_running }
  end
end
