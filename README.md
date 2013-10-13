## DESCRIPTION:

This cookbook will compile, install and configure Freeswitch to be an OSTN[https://guardianproject.info/wiki/OSTN_Compliance_Specification]
compliant SIP registrar[http://en.wikipedia.org/wiki/SIP_registrar#Network_elements] and ZRTP[http://en.wikipedia.org/wiki/ZRTP] media proxy. All signalling is encrypted and if
the endpoints support ZRTP, calling parties may encrypt their call with a peer
to peer authentication process.

To handle the SIPS socket, this cookbook will make the system where it is run an
SSL Certificate Authority. It is the operator's responsibility to distribute the
root certificate to all client applications. As of this writing, Freeswitch does
not support commercial SSL authorities like HTTPS web servers.

## REQUIREMENTS:

### Hostname

The only dependency is a Fully Qualified Domain Name (FQDN[http://en.wikipedia.org/wiki/FQDN]). THIS IS CRUCIAL! The
cookbook sets many parameters passed to scripts to this value, including the SIP registrar.
If you do not set a FQDN everything will break.

Unfortunately, the process to do this is varied, poorly documented and
mysterious. Basically, if you create a DNS A record for example.com pointing to
your IP address, you must configure the server so that the output of `hostname
-f` is *exactly* the same name.

On my testbed system, I did this by setting /etc/hostname to the FQDN and adding
a line in /etc/hosts to the IP address/hostname pair. Reboot. Type `hostname
-f`. If you get the output of the FQDN. You may run this cookbook.

### Operating System

The cookbook was written on Debian GNU/Linux 6 "squeeze". Package names are
probably dependent on Debian.

## ATTRIBUTES:

 default['freeswitch']['domain'] = node['fqdn']
 default['freeswitch']['git_uri'] = "git://git.freeswitch.org/freeswitch.git"

## USAGE:

 sudo -i
 cd ~
 git clone git://github.com/lazzarello/chef-twelvetone.git
 cd ~/chef-twelvetone/config
 chef-solo -c client.solo.rb -j config-freeswitch.json

Everything is bundled into the default recipe. The recipe installed a script you
may use to create users in /usr/local/freeswitch/scripts/gen_users.
