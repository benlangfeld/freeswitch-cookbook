## Cookbook Name:: freeswitch
## Recipe:: default
##
## Copyright 2012, "Twelve Tone Software" <lee@twelvetone.info>
##
##    This program is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.
##
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with this program.  If not, see <http://www.gnu.org/licenses/>.
##
#
## Freeswitch cookbook
## ZRTP media pass-through proxy mode

case node['freeswitch']['install_method']
when 'package'
  include_recipe 'freeswitch::package'
when 'source'
  include_recipe 'freeswitch::source'
end

# SSL actions
cookbook_file "#{node['freeswitch']['binpath']}/gentls_cert" do
  source "gentls_cert"
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  mode 0755
end

execute "build_ca" do
  user "freeswitch"
  cwd node['freeswitch']['binpath']
  command "./gentls_cert setup -config-dir #{node['freeswitch']['confpath']}/ssl -cn #{node['freeswitch']['domain']} -alt DNS:#{node['freeswitch']['domain']} -org #{node['freeswitch']['domain']}"
  creates "#{node['freeswitch']['confpath']}/ssl/CA/cakey.pem"
end

execute "gen_server_cert" do
  user "freeswitch"
  cwd node['freeswitch']['binpath']
  command "./gentls_cert create_server -config-dir #{node['freeswitch']['confpath']}/ssl -quiet -cn #{node['freeswitch']['domain']} -alt DNS:#{node['freeswitch']['domain']} -org #{node['freeswitch']['domain']}"
  creates "#{node['freeswitch']['confpath']}/ssl/agent.pem"
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

directory "#{node['freeswitch']['homedir']}/scripts" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
end

template "#{node['freeswitch']['homedir']}/scripts/gen_users" do
  source "gen_users.rb.erb"
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  mode 0755
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

template "#{node['freeswitch']['confpath']}/autoload_configs/acl.conf.xml" do
  source "acl.conf.xml.erb"
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  mode 0755
  variables :acl_domains => node['freeswitch']['acl']['domains']
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
