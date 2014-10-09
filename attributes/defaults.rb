default['freeswitch']['install_method'] = "package"

default['freeswitch']['user'] = "freeswitch"
default['freeswitch']['group'] = case node['platform']
when 'ubuntu', 'debian'
  'freeswitch'
when 'redhat', 'centos', 'fedora'
  'daemon'
end
default['freeswitch']['service'] = "freeswitch"

default['freeswitch']['binpath']  = '/usr/bin'
default['freeswitch']['confpath'] = '/etc/freeswitch'
default['freeswitch']['homedir']  = '/var/lib/freeswitch'

default['freeswitch']['domain'] = node['fqdn']
default['freeswitch']['local_ip'] = node['ec2'] ? node['ec2']['public_ipv4'] : node['ipaddress']
default['freeswitch']['vars_template'] = "vars.xml.erb"
default['freeswitch']['vars_template_cookbook'] = "freeswitch"

default['freeswitch']['autoload_modules'] = %w[
  mod_console
  mod_logfile
  mod_cdr_csv
  mod_event_socket
  mod_sofia
  mod_loopback
  mod_commands
  mod_conference
  mod_db
  mod_dptools
  mod_expr
  mod_fifo
  mod_hash
  mod_voicemail
  mod_esf
  mod_fsv
  mod_cluechoo
  mod_valet_parking
  mod_httapi
  mod_dialplan_xml
  mod_dialplan_asterisk
  mod_spandsp
  mod_g723_1
  mod_g729
  mod_amr
  mod_speex
  mod_h26x
  mod_vp8
  mod_b64
  mod_sndfile
  mod_native_file
  mod_local_stream
  mod_tone_stream
  mod_spidermonkey
  mod_lua
  mod_say_en
]
