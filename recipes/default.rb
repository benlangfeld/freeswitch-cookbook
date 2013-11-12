case node['freeswitch']['install_method']
when 'package'
  include_recipe 'freeswitch::package'
when 'source'
  include_recipe 'freeswitch::source'
end

service node['freeswitch']['service']

# set global variables
template "#{node['freeswitch']['confpath']}/vars.xml" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  source node['freeswitch']['vars_template']
  mode 0644
  variables local_ip_v4: node['freeswitch']['local_ip'], domain: node['freeswitch']['domain']
end

# Set modules to autoload
template "#{node['freeswitch']['confpath']}/autoload_configs/modules.conf.xml" do
  source "modules.conf.xml.erb"
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  mode 0755
  variables modules: node['freeswitch']['autoload_modules']
  notifies :restart, "service[#{node['freeswitch']['service']}]"
end
