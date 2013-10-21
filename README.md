# FreeSWITCH cookbook

This Chef cookbook installs FreeSWITCH either from source or packages and configures its basic settings. It is intended that this cookbook remain small and perform only installation tasks, with downstream cookbooks depending on it to configure FreeSWITCH for more specific tasks.

# Requirements

Tested on Ubuntu 12.04 and Debian 7.1.

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
* `node['freeswitch']['local_ip']` - the local IP FreeSWITCH listens on (default `127.0.0.1`)
* `node['freeswitch']['domain']` - the domain at which FS acts as a registrar, etc (default `node['fqdn']`)
* `node['freeswitch']['autoload_modules']` - the list of modules which FreeSWITCH should load on startup (default `%w[mod_console mod_logfile mod_enum mod_event_socket mod_rayo mod_sofia mod_loopback mod_commands mod_conference mod_db mod_dptools mod_expr mod_fifo mod_hash mod_esf mod_fsv mod_http_cache mod_dialplan_xml mod_g723_1 mod_g729 mod_amr mod_ilbc mod_speex mod_h26x mod_siren mod_sndfile mod_native_file mod_local_stream mod_tone_stream mod_ssml mod_flite mod_pocketsphinx mod_say]`)

## Package install attributes
* `node['freeswitch']['package']['debs']` - the FreeSWITCH packages to install (default `%w(freeswitch-meta-vanilla freeswitch-init freeswitch-mod-rayo freeswitch-mod-flite freeswitch-conf-rayo)`)
* `node['freeswitch']['package']['repo']['enable']` - if the FreeSWITCH official repository should be enabled (default `true`)
* `node['freeswitch']['package']['repo']['url']` - the URL of the FreeSWITCH official repo (default `http://files.freeswitch.org/repo/deb/debian`)
* `node['freeswitch']['package']['repo']['distro']` - the distro to select from the repo (default `wheezy`)
* `node['freeswitch']['package']['repo']['branches']` - the branches of the repo to import (default `%w(main)`)
* `node['freeswitch']['package']['repo']['keyserver']` - the keyserver against which to auth the repo (default `pool.sks-keyservers.net`)
* `node['freeswitch']['package']['repo']['key']` - the repo's public GPG key (default `D76EDC7725E010CF`)

## Source install attributes
* `node['freeswitch']['source']['git_uri']` - the URI of the FreeSWITCH git repository to use for installation (default `git://git.freeswitch.org/freeswitch.git`)
* `node['freeswitch']['source']['git_branch']` - the branch of the git repository to install from (default `v1.2.stable`)
* `node['freeswitch']['source']['dependencies']` - the packages to be installed on which compilation depends (default `%w[autoconf automake g++ git-core libjpeg62-dev libncurses5-dev libtool make python-dev gawk pkg-config gnutls-bin libsqlite3-dev bison libasound2-dev]`)
* `node['freeswitch']['source']['modules']` - the modules to compile (default `%w[loggers/mod_console loggers/mod_logfile loggers/mod_syslog applications/mod_commands applications/mod_conference applications/mod_dptools applications/mod_enum applications/mod_db applications/mod_hash applications/mod_http_cache applications/mod_expr applications/mod_esf applications/mod_fsv codecs/mod_g723_1 codecs/mod_amr codecs/mod_g729 codecs/mod_h26x codecs/mod_bv codecs/mod_ilbc codecs/mod_speex codecs/mod_siren dialplans/mod_dialplan_xml endpoints/mod_sofia endpoints/mod_loopback asr_tts/mod_flite asr_tts/mod_pocketsphinx event_handlers/mod_event_socket event_handlers/mod_cdr_csv event_handlers/mod_rayo formats/mod_native_file formats/mod_sndfile formats/mod_local_stream formats/mod_tone_stream formats/mod_ssml say/mod_say_en]`)

# Recipes

* `freeswitch` - Fetches and installs FreeSWITCH

# Author

[Ben Langfeld](@benlangfeld)
