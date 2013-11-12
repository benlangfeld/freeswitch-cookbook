default:
	bundle update
	thor foodcritic:lint --epic-fail any && kitchen test -p --destroy=always
