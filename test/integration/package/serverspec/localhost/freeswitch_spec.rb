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

  describe command('freeswitch -version') do
    it { should return_stdout /FreeSWITCH version/ }
  end

  describe command('fs_cli -x "version"') do
    it { should return_stdout /FreeSWITCH Version 1.2/ }
  end

  describe port(5060) do
    it { should be_listening.with('tcp') }
    it { should be_listening.with('udp') }
  end

  describe port(5222) do
    it { should be_listening.with('tcp') }
  end

  # Check mod_flite was loaded correctly, since debian packages have been known to fail to load this
  describe command('fs_cli -x "reload mod_flite"') do
    it { should return_stdout /\+OK module loaded/ }
  end
end
