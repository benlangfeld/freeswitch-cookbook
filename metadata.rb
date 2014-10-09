name             "freeswitch"
maintainer       "Mojo Lingo LLC"
maintainer_email "ops@mojolingo.com"
license          "Apache 2.0"
description      "Installs/Configures FreeSWITCH"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

recipe "freeswitch", "Install FreeSWITCH and configure"

depends 'apt', '~> 2.2'
depends 'yum', '~> 3.1'

supports "debian", ">= 6.0"
supports "ubuntu", ">= 12.04"
supports "centos", ">= 6.0"
