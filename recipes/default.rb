case node['freeswitch']['install_method']
when 'package'
  include_recipe 'freeswitch::package'
when 'source'
  include_recipe 'freeswitch::source'
end

# set global variables
template "#{node['freeswitch']['confpath']}/vars.xml" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  source "vars.xml.erb"
  mode 0644
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

service node['freeswitch']['service'] do
  action ['restart']
end
