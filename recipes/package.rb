case node['platform']
when 'ubuntu', 'debian'
  include_recipe 'apt'

  apt_repository 'freeswitch' do
    uri node['freeswitch']['package']['repo']['url']
    distribution node['freeswitch']['package']['repo']['distro']
    components node['freeswitch']['package']['repo']['branches']
    keyserver node['freeswitch']['package']['repo']['keyserver']
    key node['freeswitch']['package']['repo']['key']
    only_if { node['freeswitch']['package']['repo']['enable'] }
  end

  node['freeswitch']['package']['packages'].each do |pkg|
    package pkg
  end

  directory "/etc/freeswitch" do
    owner node['freeswitch']['user']
    group node['freeswitch']['group']
    notifies :run, 'execute[install_fs_config]', :immediately
  end

  execute "install_fs_config" do
    command "cp -a /usr/share/freeswitch/conf/#{node['freeswitch']['package']['config_template']}/* #{node['freeswitch']['confpath']} && chown -R #{node['freeswitch']['user']}:#{node['freeswitch']['group']} #{node['freeswitch']['confpath']}"
    action :nothing
  end
when 'redhat', 'centos', 'fedora'
  yum_repository 'freeswitch' do
    description "FreeSWITCH repo"
    url node['freeswitch']['package']['repo']['url']
    gpgcheck false
    only_if { node['freeswitch']['package']['repo']['enable'] }
  end

  node['freeswitch']['package']['packages'].each do |pkg|
    package pkg
  end
else
  raise "Platform #{node['platform']} not supported"
end
