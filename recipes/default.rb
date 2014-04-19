case node['freeswitch']['install_method']
when 'package'
  include_recipe 'freeswitch::package'
when 'source'
  include_recipe 'freeswitch::source'
end

template "/etc/default/freeswitch" do
  source "freeswitch.default.erb"
  mode 0644
end

template "/etc/init.d/freeswitch" do
  source "freeswitch.init.erb"
  mode 0755
end

service node['freeswitch']['service'] do
  supports :restart => true, :start => true, :reload => true
  action :enable
end

# set global variables
template "#{node['freeswitch']['confpath']}/vars.xml" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  source node['freeswitch']['vars_template']
  cookbook node['freeswitch']['vars_template_cookbook']
  mode 0644
  variables local_ip_v4: node['freeswitch']['local_ip'], domain: node['freeswitch']['domain']
  notifies :reload, "service[#{node['freeswitch']['service']}]"
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
