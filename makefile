# Some common project scripts

testing:
	flutter test --coverage
	lcov --remove coverage/lcov.info '**/**.g.dart' -o coverage/new_lcov.info
	genhtml coverage/new_lcov.info --output=coverage

	@echo "\n\nTesting complete."
	@echo "Run \"open coverage/index.html\" to view coverage files."

precommit:
	dart fix --apply && echo "\n\n"
	dart format lib test && echo "\n\n"
	dart analyze && echo "\n\n"

	@# Prompt to run tests after pre-commit step is complete
	@echo "\nRun tests? [y/N]" && read ans && if [ $${ans:-'N'} = 'y' ]; then make testing; fi;

localizations:
	flutter gen-l10n

generate:
	dart run build_runner build --delete-conflicting-outputs