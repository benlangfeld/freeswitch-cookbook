default['freeswitch']['install_method'] = "package"

default['freeswitch']['user'] = "freeswitch"
default['freeswitch']['group'] = "freeswitch"
default['freeswitch']['service'] = "freeswitch"

default['freeswitch']['binpath']  = '/usr/bin'
default['freeswitch']['confpath'] = '/etc/freeswitch'
default['freeswitch']['homedir']  = '/var/lib/freeswitch'

default['freeswitch']['inbound_proxy_media'] = "true"
default['freeswitch']['inbound_bypass_media'] = "false"
default['freeswitch']['sip_tls_version'] = "sslv23"
default['freeswitch']['tls_only'] = "true"
default['freeswitch']['domain'] = node['fqdn']
default['freeswitch']['local_ip'] = '127.0.0.1'
default['freeswitch']['dialplan']['head_fragments'] = ''
default['freeswitch']['dialplan']['tail_fragments'] = ''
default['freeswitch']['dialplan']['public_head_fragments'] = ''
default['freeswitch']['dialplan']['public_tail_fragments'] = ''

default['freeswitch']['modules']['rayo']['listeners'] = [
  {
    'type' => "c2s",
    'port' => "5222",
    'address' => "$${rayo_ip}",
    'acl' => ""
  }
]

default['freeswitch']['autoload_modules'] = %w[
  mod_console
  mod_logfile
  mod_enum
  mod_event_socket
  mod_rayo
  mod_sofia
  mod_loopback
  mod_commands
  mod_conference
  mod_db
  mod_dptools
  mod_expr
  mod_fifo
  mod_hash
  mod_esf
  mod_fsv
  mod_http_cache
  mod_dialplan_xml
  mod_g723_1
  mod_g729
  mod_amr
  mod_ilbc
  mod_speex
  mod_h26x
  mod_siren
  mod_sndfile
  mod_native_file
  mod_local_stream
  mod_tone_stream
  mod_ssml
  mod_flite
  mod_pocketsphinx
  mod_say
]
