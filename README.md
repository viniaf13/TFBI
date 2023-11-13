<p align="center">
  <img width="400" src="lib/resources/assets/images/splash_logo.png">
</p>

<p align="center">
<img src="https://github.com/BottleRocketStudios/TexasFarmBureau-Flutter/actions/workflows/build-all.yaml/badge.svg?branch=develop" />
<img src="https://github.com/BottleRocketStudios/TexasFarmBureau-Flutter/actions/workflows/build-ios.yaml/badge.svg?branch=develop" />
<img src="https://github.com/BottleRocketStudios/TexasFarmBureau-Flutter/actions/workflows/build-android.yaml/badge.svg?branch=develop" />
</p>

------

A flutter project built for [Texas Farm Bureau Insurance](https://www.txfb-ins.com/).

An up to date development resource dashboard is available [in Confluence here](https://confluence.bottlerocketapps.com/display/TFB/Development+Dashboard).

The most recent client API documentation [can be found here](https://bottlerocketstudios.enterprise.slack.com/files/U04A8FB6YP5/F0516G3U6MB/external_apis__2_.pdf).

> Above links require access to BR Slack and Confluence.

## Project Dependencies and Versions

- Flutter: v3.13.6 - channel stable
- Cocoapods: v1.13.0
- Homebrew: v4.0.18
- XCode: v15.0
- Java v19.0.1
- Java SE Runtime Environment v19.0.1

## Project Scripts

A few scripts exist in the project's `makefile` to perform common project specific tasks.

- `make precommit` will run a series of formatting and analysis checks. Execute this script before posting a PR to quickly fix these common issues.
- `make testing` will run the project's test suite and report the coverage results in the `/coverage` folder.
- `make localizations` will execute the `flutter_localizations` package to generate/update our localization files.
- `make generate` will run the project `build_runner` and create all generated models/client files.

## PR Approval Rules

Before a PR is approved, a few conditions must be met:

- The PR must be reviewed by at least two other developers on the team
- All open converstaions on the PR must be resolved
- The unit test workflow should build, all the tests should pass, code coverage should be above 75%, and all Dart Code Metrics analysis should succeed without any errors.

Github will not allow you to merge a PR if any of these conditions are not met.

When all of these conditions are met, the developer who opened the PR should squash merge their PR into `develop`.

After the squash merge is complete, the dev should also delete their branch from the origin.

No code can be pushed directly to the `develop` or `main` branch. A PR must be created to merge code into either of these branches, even by a repository admin.

## Formatting and Lint Approach

Developers should use the built in flutter formatter with the format on save option enabled in their IDE.

The current linting approach is a custom extension of the default Flutter recommended and Dart core linting rules found in the `flutter_lints` package. The rules can be found in the `analysis_options.yaml` file located at the root of the project.

Developers should also use an IDE that integrates with the flutter analyzer (VSCode or Android Studio) that will warn them of any Flutter linting errors as they code.

All flutter formatting and analysis warnings should be resolved before committing code to the develop branch. If your IDE does not integrate with the flutter formatter or analyzer, the `dart format lib test` and `dart analyze` commands can be run manually before comitting, or run `make precommit` to run all formatting and analysis commands at once.

No analyzer issues should be present when committing code to develop. If absolutely necessary, an ignore command can be added to the preceding line to suppress the warning, but should be used sparingly.

## Branch Naming Strategy

Branches should be created with the following format: The type of ticket being worked on, eg. `feature`, `bug`, `fix`, `spike`; followed by a `/`; followed by the name of the ticket being worked on, eg. `TFBI-12`; followed by a short description of the ticket itself.

Spaces in the branch name should be separated by dashes.

Here are a few examples of potential branch names:

- feature/TFBI-12-Add-basic-auth-repository
- bug/TFBI-44-Fix-auth-token-expiry-issue
- spike/TFBI-31-Research-fiserv-apis

## Reusable Components

Favor the shared widgets in `/lib/shared/widgets` when possible.

- `TfbFilledButton` (Styled rounded button - see dashboard CTAs)
- `TfbBasicDialog` (Styled dialog with title, subtitle, and two action buttons)
- `TfbBrandLoadingIcon` (in place of CircularProgressIndicator)
- `TfbLoadingOverlay` Full page loading overlay
- `TfbAnimatedAppBar` (Default app bar that animates title in on scroll)
- `TfbDropShadowScrollWidget` (Wrap a scrollable widget to automatically create a drop shadow effect on scroll, used with TfbAnimatedAppBar)
- `AddressWidget` Multi-line text column for insured addresses
- `TextWithUrl` A link widget that opens an in-app browser
- `TextWithPhone` A phone display widget that opens the native tel: dialog on tap
- `TextWithEmail` An email display widget that opens the native mailto: dialog on tap
- `ValidatingFormField` A flexible validating form field widget for user form input

## Localizations & App Copy

App copy is currently set up to support localization in English and Spanish. To add new localized copy to display in the app, follow these steps:

1. Add the English copy to the `lib/resources/l10n/app_en.arb` file.
2. Add the Spanish copy to the `lib/resources/l10n/app_es.arb` file. Make sure to use the same key for your new string across the `app_en` and `app_es` files.
3. Run `flutter gen-l10n` or `make localizations` to generate the localization files.
4. Access the new localized copy using the `getLocalizationOf` extension on `BuildContext`. Eg. `context.getLocalizationOf.deleteModalSubtitle`.

## Shared Styles

### Text Styles

Common app text styles are configured in the `TfbTypography` class. They can be accessed anywhere in the widget tree using the `TypographyUtils` extension on `BuildContext`. Here are a few examples:

- `context.tfbText.header1`
- `context.tfbText.bodyMediumSmall`
- `context.tfbText.captionBold`

## Github Workflows

### Workflows

There are two main workflows: build-all.yaml and test-all.yaml. These flows get the configuration
settings and launch sub-flows to do builds (ios and Android) and unit_tests (for now just one sub-flow).

The two build workflows show up as 1) Build android (Production) and 2) Build ios -- (Production)
in Github actions.

### Configuration and Operation

The configuration settings are found in the '.env' file in the project root. If the file does not
exist, the values are taken from GitHub as 'not really secret' environment values as fail safe.

> Note: Don't put actual sensitive information such as API keys in the .env file.

The sub-flows can be run manually and with a 'deploy' setting to just build what is needed/required.
They are available in GitHub as found under the Actions tab.

deploy values:

deploy:  0: Just do Flutter build (default)
         1: Build primary app executable (e.g., .apk for android)
         2: Build store app bundles (.ipa and .aab)
         3: Upload appropriate artifacts to saucelabs
         4: Upload appropriate artifacts to stores (Testflight/Apple store or Play Store)
         In addition,
            push to develop is like deploy = "123"   build Flutter, deploy .apk, .aab, and saucelabs
            push to release is like deploy = "1234"

NOTE: Switch to branch 'manual' and make sure to merge from develop for manual releases
