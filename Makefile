default:
	bundle update
	bundle exec thor foodcritic:lint --epic-fail any && bundle exec kitchen test --parallel --destroy=always
