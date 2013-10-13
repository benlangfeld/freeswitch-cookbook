default:
	bundle install
	thor foodcritic:lint --epic-fail any && kitchen test --destroy=always
