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

# set SIP security attributes for external users
template "#{node['freeswitch']['confpath']}/sip_profiles/external.xml" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  source "external.xml.erb"
  mode 0644
end

template "#{node['freeswitch']['confpath']}/dialplan/default.xml" do
  source "default.xml.erb"
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  mode 0755
  variables :head_fragments => node['freeswitch']['dialplan']['head_fragments'],
            :tail_fragments => node['freeswitch']['dialplan']['tail_fragments']
end

template "#{node['freeswitch']['confpath']}/autoload_configs/event_socket.conf.xml" do
  source "event_socket.conf.xml.erb"
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  mode 0755
end

template "#{node['freeswitch']['confpath']}/dialplan/public.xml" do
  source "public.xml.erb"
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  mode 0755
  variables :public_head_fragments => node['freeswitch']['dialplan']['public_head_fragments'],
            :public_tail_fragments => node['freeswitch']['dialplan']['public_tail_fragments']
end

node['freeswitch']['extra_sip_profiles'].each do |p|
  template "#{node['freeswitch']['confpath']}/sip_profiles/#{p['folder']}/#{p['file_name']}.xml" do
    source "sip_profile_tpl.xml.erb"
    owner node['freeswitch']['user']
    group node['freeswitch']['group']
    mode 0755
    variables :profile_name => p['profile_name'],
              :contents => p['contents']
  end
end

template "#{node['freeswitch']['confpath']}/autoload_configs/modules.conf.xml" do
  source "modules.conf.xml.erb"
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  mode 0755
  variables modules: node['freeswitch']['autoload_modules']
  notifies :restart, "service[#{node['freeswitch']['service']}]"
end

template "#{node['freeswitch']['confpath']}/autoload_configs/rayo.conf.xml" do
  source "rayo.conf.xml.erb"
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  mode 0755
  variables :listeners => node['freeswitch']['modules']['rayo']['listeners']
  notifies :restart, "service[#{node['freeswitch']['service']}]"
end

service node['freeswitch']['service'] do
  action ['restart']
end
