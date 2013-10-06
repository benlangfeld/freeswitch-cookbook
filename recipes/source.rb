node['freeswitch']['binpath'] = node['freeswitch']['source']['binpath']
node['freeswitch']['confpath'] = node['freeswitch']['source']['confpath']
node['freeswitch']['homedir'] = node['freeswitch']['source']['homedir']

## Build requirements
package "autoconf"
package "automake"
package "g++"
package "git-core"
package "libjpeg62-dev"
package "libncurses5-dev"
package "libtool"
package "make"
package "python-dev"
package "gawk"
package "pkg-config"
package "gnutls-bin"
package "libsqlite3-dev"
package "bison"
## install packages for mod_shout for mp3 playback

# user generation dependencies
gem_package "xml-simple"
package "pwgen"

# get source
execute "git_clone" do
  command "git clone -b #{node['freeswitch']['source']['git_branch']} #{node['freeswitch']['source']['git_uri']} freeswitch"
  cwd "/usr/local/src"
  creates "/usr/local/src/freeswitch"
end

template "/usr/local/src/freeswitch/modules.conf" do
  source "modules.conf.erb"
end

# compile source and install
script "compile_freeswitch" do
  interpreter "/bin/bash"
  cwd "/usr/local/src/freeswitch"
  code <<-EOF
  ./bootstrap.sh
  ./configure
  make clean
  make
  make config-rayo
  make install
EOF
  not_if "test -f #{node['freeswitch']['binpath']}/freeswitch"
end

# install init script
template "/etc/init.d/freeswitch" do
  source "freeswitch.init.erb"
  mode 0755
end

# install defaults
template "/etc/default/freeswitch" do
  source "freeswitch.default.erb"
  mode 0644
end

group node['freeswitch']['group'] do
  action :create
end

# create non-root user
user node['freeswitch']['user'] do
  system true
  shell "/bin/bash"
  home node['freeswitch']['source']['homedir']
  gid node['freeswitch']['group']
end

# change ownership of homedir
execute "fs_homedir_ownership" do
  cwd node['freeswitch']['source']['homedir']
  command "chown -R #{node['freeswitch']['user']}:#{node['freeswitch']['group']} ."
end

# define service
service node['freeswitch']['source']['service'] do
  supports :restart => true, :start => true
  action ['enable']
end
