name             "freeswitch"
maintainer       "Mojo Lingo LLC"
maintainer_email "ops@mojolingo.com"
license          "Apache 2.0"
description      "Installs/Configures freeswitch"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1"

recipe "freeswitch", "Install FreeSWITCH and configure"
recipe "freeswitch::package", "Install FreeSWITCH from a package"
recipe "freeswitch::source", "Compile and install FreeSWITCH from source"

depends 'apt', '~> 2.2'

supports "debian", ">= 6.0"
supports "ubuntu", ">= 12.04"
