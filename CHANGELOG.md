# develop
  * Use a stored GPG key instead of relying on keyservers

# 0.6.2
  * Fix reloading after user resource execution

# 0.6.1
  * Prevent conflicts between our init script and the one provided by packages
  * Prefix package key ID for reliable lookup

# 0.6.0
  * Allow specifying the cookbook from which to load the vars template
  * Softly reload FreeSWITCH on config changes, rather than doing a full restart

# 0.5.0
  * Allow creating FS users (directory entries) via a LWRP

# 0.4.2
  * Update source build dependencies

# 0.4.1
  * Only place config templates on initial installation. Avoids unnecessarily bouncing config and restarting FreeSWITCH on every run.
  * Speed up the source build
  * Add additional development pkgs needed by FS master

# 0.4.0
  * Bump to yum 3.x cookbook

# 0.3.2
  * Ensure that mod_ssml, mod_flite and mod_pocketsphinx get installed for a Rayo server

# 0.3.1
  * Install rayo config in source install

# 0.3.0
  * Add support for CentOS
  * Default local_ip to the primary interface's IP

# 0.2.0
  * Add rayo recipe for deploying a Rayo server

# 0.1.0
  * First release
