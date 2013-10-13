default['freeswitch']['source']['git_uri'] = "git://git.freeswitch.org/freeswitch.git"
default['freeswitch']['source']['git_branch'] = "v1.2.stable"
default['freeswitch']['source']['enabled'] = "true"
default['freeswitch']['source']['modules'] = %w[
loggers/mod_console
loggers/mod_logfile
loggers/mod_syslog
applications/mod_commands
applications/mod_conference
applications/mod_dptools
applications/mod_enum
applications/mod_db
applications/mod_hash
applications/mod_http_cache
applications/mod_expr
applications/mod_esf
applications/mod_fsv
codecs/mod_g723_1
codecs/mod_amr
codecs/mod_g729
codecs/mod_h26x
codecs/mod_bv
codecs/mod_ilbc
codecs/mod_speex
codecs/mod_siren
dialplans/mod_dialplan_xml
endpoints/mod_sofia
endpoints/mod_loopback
asr_tts/mod_pocketsphinx
event_handlers/mod_event_socket
event_handlers/mod_cdr_csv
event_handlers/mod_rayo
formats/mod_native_file
formats/mod_sndfile
formats/mod_local_stream
formats/mod_tone_stream
formats/mod_ssml
say/mod_say_en
]
