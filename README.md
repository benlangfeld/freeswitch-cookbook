# FreeSWITCH cookbook

This Chef cookbook installs FreeSWITCH either from source or packages and configures its basic settings. It is intended that this cookbook remain small and perform only installation tasks, with downstream cookbooks depending on it to configure FreeSWITCH for more specific tasks.

# Requirements

Tested on Ubuntu 12.04, Debian 7.1 and CentOS 6.5.

# Usage

Add `recipe[freeswitch]` to your node's run list

# Attributes

* `node['freeswitch']['install_method']` - the method by which to install FreeSWITCH. May be `package` or `source`. This choice determines other applicable parameters. (default `package`)
* `node['freeswitch']['user']` - the user as which to run FreeSWITCH (default `freeswitch`)
* `node['freeswitch']['group']` - the group as which to run FreeSWITCH (default `freeswitch`)
* `node['freeswitch']['service']` - the service name as which to run FreeSWITCH (default `freeswitch`)
* `node['freeswitch']['binpath']` - the path at which FreeSWITCH binaries are located (default `/usr/bin`)
* `node['freeswitch']['confpath']` - the path at which FreeSWITCH configuration is located (default `/etc/freeswitch`)
* `node['freeswitch']['homedir']` - the path at which FreeSWITCH's home directory is' located (default `/var/lib/freeswitch`)
* `node['freeswitch']['local_ip']` - the local IP FreeSWITCH listens on (default `default['asterisk']['public_ip'] = node['ec2'] ? node['ec2']['public_ipv4'] : node['ipaddress']`)
* `node['freeswitch']['domain']` - the domain at which FS acts as a registrar, etc (default `node['fqdn']`)
* `node['freeswitch']['vars_template']` - the template file to use for placing FreeSWITCH `vars.xml`
* `node['freeswitch']['vars_template_cookbook']` - the cookbook from which to load the vars template
* `node['freeswitch']['autoload_modules']` - the list of modules which FreeSWITCH should load on startup (default `%w[mod_console mod_logfile mod_cdr_csv mod_event_socket mod_sofia mod_loopback mod_commands mod_conference mod_db mod_dptools mod_expr mod_fifo mod_hash mod_voicemail mod_esf mod_fsv mod_cluechoo mod_valet_parking mod_httapi mod_dialplan_xml mod_dialplan_asterisk mod_spandsp mod_g723_1 mod_g729 mod_amr mod_speex mod_h26x mod_vp8 mod_b64 mod_sndfile mod_native_file mod_local_stream mod_tone_stream mod_spidermonkey mod_lua mod_say_en]`)

## Package install attributes
* `node['freeswitch']['package']['packages']` - the FreeSWITCH packages to install (default `%w(freeswitch-meta-vanilla freeswitch-lang freeswitch-music freeswitch-sounds freeswitch-conf-vanilla)` on Debian/Ubuntu, `%w(freeswitch freeswitch-lang-en freeswitch-sounds-music freeswitch-sounds-en-us-callie freeswitch-config-vanilla)` on RedHat/CentOS)
* `node['freeswitch']['package']['repo']['enable']` - if the FreeSWITCH official repository should be enabled (default `true`)
* `node['freeswitch']['package']['repo']['url']` - the URL of the FreeSWITCH official repo (default `http://files.freeswitch.org/repo/deb/debian`)
* `node['freeswitch']['package']['repo']['distro']` - the distro to select from the repo (default `wheezy`)
* `node['freeswitch']['package']['repo']['branches']` - the branches of the repo to import (default `%w(main)`)
* `node['freeswitch']['package']['repo']['keyserver']` - the keyserver against which to auth the repo (default `nil`, this will use the cookbook's stored GPG key)
* `node['freeswitch']['package']['repo']['key']` - the repo's public GPG key (default `freeswitch.gpg`)

## Source install attributes
* `node['freeswitch']['source']['git_uri']` - the URI of the FreeSWITCH git repository to use for installation (default `https://stash.freeswitch.org/scm/fs/freeswitch.git`)
* `node['freeswitch']['source']['git_branch']` - the branch of the git repository to install from (default `v1.2.stable`)
* `node['freeswitch']['source']['dependencies']` - the packages to be installed on which compilation depends (default `%w[autoconf automake g++ git-core libjpeg62-dev libncurses5-dev libtool make python-dev gawk pkg-config gnutls-bin libsqlite3-dev bison libasound2-dev]`)
* `node['freeswitch']['source']['modules']` - the modules to compile (default `%w[loggers/mod_console loggers/mod_logfile applications/mod_cluechoo applications/mod_commands applications/mod_conference applications/mod_dptools applications/mod_db applications/mod_fifo applications/mod_hash applications/mod_httapi applications/mod_expr applications/mod_esf applications/mod_fsv applications/mod_spandsp applications/mod_valet_parking applications/mod_voicemail codecs/mod_g723_1 codecs/mod_amr codecs/mod_g729 codecs/mod_h26x codecs/mod_speex dialplans/mod_dialplan_xml dialplans/mod_dialplan_asterisk endpoints/mod_sofia endpoints/mod_loopback event_handlers/mod_event_socket event_handlers/mod_cdr_csv formats/mod_native_file formats/mod_sndfile formats/mod_local_stream formats/mod_tone_stream languages/mod_lua say/mod_say_en]`)

# Recipes

* `freeswitch` - Fetches and installs FreeSWITCH

# Resources/Providers

## `freeswitch_user`
This LWRP provides an easy way to manage FreeSWITCH users (directory entries). FreeSWITCH XML config will be reloaded after a run which manipulates users.

### Actions
- :add: adds a user to the directory
- :remove: removes a user from the directory

### Attribute Parameters
- id: The user's ID. May be alphanumeric, and defaults to the name of the resource.
- directory: The name of the directory in which to place the user (must already exist). Defaults to `'default'`.
- password: The user's password. Defaults to `$${default_password}`.
- vm_password: The user's voicemail password. Defaults to `$${default_password}`.
- effective_caller_id_name: The user's caller ID name. Defaults to `'Extension'`.
- effective_caller_id_number: The user's caller ID number. Defaults to `$${outbound_caller_id}`.
- cookbook: The name of the cookbook from which to fetch the user template. Defaults to this cookbook.
- template: The name of the template to use for the user's configuration. Defaults to `user.xml.erb`.

### Examples

Add the `joebloggs` user:

```ruby
freeswitch_user 'joebloggs'
```

Add a user specifying all the possible attributes:

```ruby
freeswitch_user 'joebloggs' do |variable|
  directory 'default'
  password 'foobar'
  vm_password 'barbaz'
  effective_caller_id_name 'Joe Bloggs'
  effective_caller_id_number 'joe@bloggs.com'
  cookbook 'my-wrapper-cookbook'
  template 'freeswitch-user.xml.erb'
end
```

Remove the `joebloggs` user:

```ruby
freeswitch_user 'joebloggs' do
  action :remove
end
```

# Author

[Ben Langfeld](@benlangfeld)
