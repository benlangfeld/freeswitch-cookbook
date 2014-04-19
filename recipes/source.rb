include_recipe 'apt'

node['freeswitch']['source']['dependencies'].each { |d| package d }

execute "git_clone" do
  command "git clone --depth 1 -b #{node['freeswitch']['source']['git_branch']} #{node['freeswitch']['source']['git_uri']} freeswitch"
  cwd "/usr/local/src"
  creates "/usr/local/src/freeswitch"
end

template "/usr/local/src/freeswitch/modules.conf" do
  source "modules.conf.erb"
  variables modules: node['freeswitch']['source']['modules']
end

script "compile_freeswitch" do
  interpreter "/bin/bash"
  cwd "/usr/local/src/freeswitch"
  code <<-EOF
  ./bootstrap.sh
  ./configure -C --prefix=/usr --localstatedir=/var \
    --sysconfdir=/etc/freeswitch \
    --with-modinstdir=/usr/lib/freeswitch/mod \
    --with-rundir=/var/run/freeswitch \
    --with-logfiledir=/var/log/freeswitch \
    --with-dbdir=/var/lib/freeswitch/db \
    --with-htdocsdir=/usr/share/freeswitch/htdocs \
    --with-soundsdir=/usr/share/freeswitch/sounds \
    --with-storagedir=/var/lib/freeswitch/storage \
    --with-grammardir=/usr/share/freeswitch/grammar \
    --with-certsdir=/etc/freeswitch/tls \
    --with-scriptdir=/usr/share/freeswitch/scripts \
    --with-recordingsdir=/var/lib/freeswitch/recordings
  make clean
  make
  #{"make config-#{node['freeswitch']['source']['config_template']}" if node['freeswitch']['source']['config_template']}
  make install
EOF
  not_if "test -f #{node['freeswitch']['binpath']}/freeswitch"
end

group node['freeswitch']['group'] do
  action :create
end

# create non-root user
user node['freeswitch']['user'] do
  system true
  shell "/bin/bash"
  home node['freeswitch']['homedir']
  gid node['freeswitch']['group']
end

# change ownership of homedir
execute "fs_homedir_ownership" do
  cwd node['freeswitch']['homedir']
  command "chown -R #{node['freeswitch']['user']}:#{node['freeswitch']['group']} ."
end

%w{
  /var/lib/freeswitch
  /var/lib/freeswitch/db
  /var/lib/freeswitch/recordings
  /var/lib/freeswitch/storage
  /var/log/freeswitch
  /var/run/freeswitch
}.each do |dir|
  directory dir do
    owner node['freeswitch']['user']
    group node['freeswitch']['group']
  end
end
