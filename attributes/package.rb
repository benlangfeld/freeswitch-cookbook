default['freeswitch']['package']['packages'] = case node['platform']
when 'ubuntu', 'debian'
  %w(
    freeswitch-meta-vanilla
    freeswitch-lang
    freeswitch-music
    freeswitch-sounds
    freeswitch-conf-vanilla
  )
when 'redhat', 'centos', 'fedora'
  %w(
    freeswitch
    freeswitch-lang-en
    freeswitch-sounds-music
    freeswitch-sounds-en-us-callie
    freeswitch-config-vanilla
  )
end
default['freeswitch']['package']['config_template']   = 'vanilla'

default['freeswitch']['package']['repo']['enable']    = true
default['freeswitch']['package']['repo']['url']       = case node['platform']
when 'ubuntu', 'debian'
  'http://files.freeswitch.org/repo/deb/debian'
when 'redhat', 'centos', 'fedora'
  'http://files.freeswitch.org/yum/6/x86_64'
end

default['freeswitch']['package']['repo']['distro']    = 'wheezy'
default['freeswitch']['package']['repo']['branches']  = %w(main)
default['freeswitch']['package']['repo']['keyserver'] = nil
default['freeswitch']['package']['repo']['key']       = 'freeswitch.gpg'
