require 'spec_helper'

describe 'FreeSWITCH' do
  describe user('freeswitch') do
    it { should exist }
    it do
      expected_group = case property[:os_by_host]['localhost'][:family]
      when /redhat/i
        'daemon'
      else
        'freeswitch'
      end
      should belong_to_group expected_group
    end
  end

  describe service('freeswitch') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('freeswitch -version') do
    it { should return_stdout /FreeSWITCH version/ }
  end

  describe command('fs_cli -x "version"') do
    it { should return_stdout /FreeSWITCH Version 1.2.22/ }
  end

  describe port(5060) do
    it { should be_listening.with('tcp') }
    it { should be_listening.with('udp') }
  end

  describe command('sudo fs_cli -x "eval \$\${local_ip_v4}"') do
    it { should return_stdout '0.0.0.0' }
  end

  describe command('sudo fs_cli -x "eval \$\${domain}"') do
    it { should return_stdout 'foo.bar.com' }
  end

  # Local-network environments need to present the set IP in SIP
  describe command('sudo fs_cli -x "eval \$\${external_sip_ip}"') do
    it { should return_stdout '0.0.0.0' }
  end

  # Local-network environments need to present the set IP in RTP
  describe command('sudo fs_cli -x "eval \$\${external_rtp_ip}"') do
    it { should return_stdout '0.0.0.0' }
  end
end
