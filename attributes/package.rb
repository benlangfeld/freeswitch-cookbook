default['freeswitch']['package']['debs'] = %w(
  freeswitch-meta-vanilla
  freeswitch-init
  freeswitch-lang
  freeswitch-music
  freeswitch-sounds
  freeswitch-conf-vanilla
)
default['freeswitch']['package']['config_template']   = 'vanilla'

default['freeswitch']['package']['repo']['enable']    = true
default['freeswitch']['package']['repo']['url']       = 'http://files.freeswitch.org/repo/deb/debian'
default['freeswitch']['package']['repo']['distro']    = 'wheezy'
default['freeswitch']['package']['repo']['branches']  = %w(main)
default['freeswitch']['package']['repo']['keyserver'] = 'pool.sks-keyservers.net'
default['freeswitch']['package']['repo']['key']       = 'D76EDC7725E010CF'
