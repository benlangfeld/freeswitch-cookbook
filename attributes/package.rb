default['freeswitch']['package']['debs'] = %w(
  freeswitch-meta-vanilla
  freeswitch-init
  freeswitch-mod-rayo
  freeswitch-mod-flite
  freeswitch-conf-rayo
)

default['freeswitch']['package']['repo']['enable']    = true
default['freeswitch']['package']['repo']['url']       = 'http://files.freeswitch.org/repo/deb/debian'
default['freeswitch']['package']['repo']['distro']    = 'wheezy'
default['freeswitch']['package']['repo']['branches']  = %w(main)
default['freeswitch']['package']['repo']['keyserver'] = 'pool.sks-keyservers.net'
default['freeswitch']['package']['repo']['key']       = 'D76EDC7725E010CF'

default['freeswitch']['package']['binpath']           = '/usr/bin'
default['freeswitch']['package']['confpath']          = '/etc/freeswitch'
default['freeswitch']['package']['homedir']           = '/var/lib/freeswitch'
