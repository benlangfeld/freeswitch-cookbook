node['freeswitch']['binpath'] = node['freeswitch']['package']['binpath']
node['freeswitch']['confpath'] = node['freeswitch']['package']['confpath']
node['freeswitch']['homedir'] = node['freeswitch']['package']['homedir']

case node['platform']
when 'ubuntu', 'debian'
  if node['freeswitch']['package']['repo']['enable']
    apt_repository 'freeswitch' do
      uri node['freeswitch']['package']['repo']['url']
      distribution node['freeswitch']['package']['repo']['distro']
      components node['freeswitch']['package']['repo']['branches']
      keyserver node['freeswitch']['package']['repo']['keyserver']
      key node['freeswitch']['package']['repo']['key']
    end
  end

  node['freeswitch']['package']['debs'].each do |pkg|
    package pkg
  end

  directory "/etc/freeswitch" do
    owner node['freeswitch']['user']
    group node['freeswitch']['group']
  end

  execute "install_fs_config" do
    command "cp -a /usr/share/freeswitch/conf/rayo/* #{node['freeswitch']['confpath']} && chown -R #{node['freeswitch']['user']}:#{node['freeswitch']['group']} #{node['freeswitch']['confpath']}"
  end
else
  raise "Platform #{node['platform']} not supported"
end
