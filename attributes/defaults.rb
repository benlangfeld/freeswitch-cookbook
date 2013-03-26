default[:freeswitch][:git_uri] = "git://git.freeswitch.org/freeswitch.git"
default[:freeswitch][:git_branch] = "v1.2.stable"
default[:freeswitch][:inbound_proxy_media] = "true"
default[:freeswitch][:inbound_bypass_media] = "false"
default[:freeswitch][:sip_tls_version] = "sslv23"
default[:freeswitch][:service] = "freeswitch"
default[:freeswitch][:user] = "freeswitch"
default[:freeswitch][:group] = "freeswitch"
default[:freeswitch][:enabled] = "true"
default[:freeswitch][:path] = "/usr/local/freeswitch/bin"
default[:freeswitch][:homedir] = "/usr/local/freeswitch"
default[:freeswitch][:tls_only] = "true"
default[:freeswitch][:domain] = node[:fqdn]
default[:freeswitch][:local_ip] = '127.0.0.1'
default[:freeswitch][:dialplan][:head_fragments] = ''
default[:freeswitch][:dialplan][:tail_fragments] = ''
default[:freeswitch][:dialplan][:public_head_fragments] = ''
default[:freeswitch][:dialplan][:public_tail_fragments] = ''
default[:freeswitch][:acl][:domains] = ''
default[:freeswitch][:extra_sip_profiles] = []
default[:freeswitch][:sip_profiles][:internal][:extra_settings] = '<param name="apply-nat-acl" value="nat.auto"/>\n<param name="ext-rtp-ip" value="auto-nat"/>\n<param name="ext-sip-ip" value="auto-nat"/>'

default[:freeswitch][:modules][:rayo][:listeners] = {
  "$${domain}" => 5222
}
