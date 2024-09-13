# Scalable Flutter App Pro

👋 Hey, welcome to Scalable Flutter App.

Watch/star this repo to be notified when updates are pushed.

## Table of Contents

<!-- TOC -->
* [Scalable Flutter App Pro](#scalable-flutter-app-pro)
  * [Table of Contents](#table-of-contents)
  * [What is Scalable Flutter App?](#what-is-scalable-flutter-app)
  * [About the Author](#about-the-author)
  * [Get Started](#get-started)
    * [Option 1 - Template](#option-1---template)
    * [Option 2 - Fork](#option-2---fork)
    * [Option 3 - Cherry-Pick](#option-3---cherry-pick)
  * [Requirements](#requirements)
* [Features](#features)
  * [Backlog](#backlog)
* [Docs](#docs)
  * [Firebase](#firebase)
  * [Google Sign In](#google-sign-in)
  * [Apple Sign In](#apple-sign-in)
  * [Notifications](#notifications)
  * [RevenueCat](#revenuecat)
  * [Mixpanel](#mixpanel)
  * [Code Architecture](#code-architecture)
  * [Styling](#styling)
  * [Google Fonts](#google-fonts)
  * [Localization](#localization)
  * [Android Release Signing](#android-release-signing)
  * [Useful GitHub Pull Request Settings](#useful-github-pull-request-settings)
* [FAQ](#faq)
  * [Why bloc and not X?](#why-bloc-and-not-x)
  * [Where to learn Flutter basics?](#where-to-learn-flutter-basics)
  * [What if I don't need a specific feature?](#what-if-i-dont-need-a-specific-feature)
* [Resources](#resources)
* [Support](#support)
<!-- TOC -->

## What is Scalable Flutter App?

Scalable Flutter App is a starter template for Flutter & Firebase apps.

It's designed to be scalable and easy to maintain. And should save you months of development time.

## About the Author

I'm Milos Jokic and I:

- built my first mobile app in 2007
- grew my apps to 214k users and $106,140 revenue.
- built apps for 10 Toptal clients.

And now I run a 6-figure devs agency where we launch MVPs in 4 weeks using Flutter & Firebase.

You can find me on:

- [LinkedIn](https://www.linkedin.com/in/milos-jokic/)
- [Twitter](https://twitter.com/miloshjokic)
- [Newsletter](http://flutterpreneur.com/)

## Get Started

There are 3 ways to get started: Template, Fork, and Cherry-Pick.

### Option 1 - Template

_Best if you want to start a new project from scratch with all the SFA features included.
And you don't care about keeping your project up to date with the SFA repo._

To get started with Option 1: Template, click the green "Use this template" button above.

### Option 2 - Fork

_Best if you want to start a new project from scratch with all the SFA features included.
And you want to keep your repo up to date with the SFA repo._

To get started with Option 2: Fork, fork the repo and follow the instructions below.

[Here's how to keep your fork up to date.](https://twitter.com/github/status/1390382527588798477)

### Option 3 - Cherry-Pick

_Best if you have an existing project and want to manually pick the SFA features you want.
Or if you want better control over what features you want._

To get started with Option 3: Cherry-Pick simple use this GitHub repo as a guide.

And cherry-pick (copy & paste) the features and files you want to use into your own project.

## Requirements

Always keep up to date:

- Flutter
- Cocoapods
- Firebase CLI

# Features

| Feature                                                              | Pro |
|----------------------------------------------------------------------|-----|
| Platforms: Android, iOS, web                                         | ✅   |
| Scalable Architecture using [flutter_bloc](https://bloclibrary.dev/) | ✅   |
| Navigation using [go_router](https://pub.dev/packages/go_router)     | ✅   |
| Scalable App Styling                                                 | ✅   |
| GitHub Actions - code and formatting check                           | ✅   |
| Responsive Design                                                    | ✅   |
| Profile Page                                                         | ✅   |
| Settings Page: sign out, app version...                              | ✅   |
| Legal: Terms, Policy, Data Deletion                                  | ✅   |
| Google Fonts                                                         | ✅   |
| Sign in and Sign Up Pages                                            | ✅   |
| Input Validators                                                     | ✅   |
| Cached network image                                                 | ✅   |
| Email Support                                                        | ✅   |
| Lifetime Updates                                                     | ✅   |
| Firebase Project Integration                                         | ✅️  |
| Firebase Cloud Functions                                             | ✅️  |
| Firebase Authentication                                              | ✅ ️ |
| Firebase Remote Config                                               | ✅ ️ |
| Firebase Crashlytics                                                 | ✅ ️ |
| Firebase Firestore                                                   | ✅ ️ |
| Firebase Analytics                                                   | ✅   |
| Firebase Hosting                                                     | ✅   |
| Firebase Storage                                                     | ✅️  |
| Google Sign In                                                       | ✅ ️ |
| Apple Sign In                                                        | ✅ ️ |
| Common Cubits                                                        | ✅ ️ |
| In App Purchases (RevenueCat)                                        | ✅ ️ |
| App Store Review Request                                             | ✅ ️ |
| Local Notifications                                                  | ✅ ️ |
| Remote Notifications (Firebase)                                      | ✅ ️ |
| HTTP Requests (dio)                                                  | ✅ ️ |
| Local Storage                                                        | ✅ ️ |
| Permissions                                                          | ✅ ️ |
| Environments                                                         | ✅ ️ |
| Localization                                                         | ✅️  |
| Dark Mode                                                            | ✅ ️ |
| Connectivity check                                                   | ✅ ️ |
| Hive - local database                                                | ✅ ️ |
| MixPanel - analytics                                                 | ✅ ️ |
| Android - Release Signing                                            | ✅ ️ |
| Onboarding                                                           | ✅ ️ |
| Forgot Password                                                      | ✅ ️ |
| Send Feedback Message                                                | ✅ ️ |
| 🎉 BONUS: Scalable Firebase Backend Template                         | ✅ ️ |

## Backlog

- Sign in with Google (web)
- Sentry integration for web crash reports
- Email link sign in
- Scheduled notifications (local & remote)
- Remote notifications (web)

# Docs

## Firebase

Firebase Console project set up ([video explanation](https://www.loom.com/share/b40ae21860fa448ebc82e4ff0729a41f)):

1. Create a new Firebase project (if you don't already have one)
2. Enable Firestore
3. Enable Auth
4. Enable Email/Password sign-in method
5. Switch to Blaze plan (pay as you go)
6. Enable Cloud Functions
7. Enable Storage (if needed)
8. Enable Hosting (if needed)
9. Enable Remote Config (if needed) ([video explanation](https://www.loom.com/share/d3a215e75fcd4c7393bde143bef450ed))

If you're using Flutter web with Firebase Storage, you'll need to enable CORS: [video explanation](https://www.loom.com/share/0ea25d89c7f9419fbe2113936224037e).

If you want to deploy your Flutter web app:

1. Run `firebase init`
2. Select `Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys`
3. Select your Firebase project
4. Enter `build/web` as the public directory
5. Enter `Y` for single-page app
6. Enter `N` for automatic builds and deploys with GitHub Actions

After that's done, you can deploy your Flutter web app with:

1. `flutter build web`, then
2. `firebase deploy`.

To set up Firebase in the `/app` project:

1. Run `cd app`
2. Run `flutterfire configure` in the terminal
3. Select your Firebase project
4. Select platforms you want to support (Android, iOS, web)
5. If asked to update files, select `y` (yes)

To set up Firebase in the `/firebase` project:

1. Run `cd firebase`
2. Run `firebase login` in the terminal
3. Run `firebase projects:list` to see your Firebase projects
4. Find your project ID (i.e. `scalable-flutter-app`)
5. Run `firebase use <project-id>` (i.e. `firebase use scalable-flutter-app` to set your Firebase project
6. Run `cd functions`
7. Run `npm install` 
8. Run `cd ..`
9. Run `firebase deploy` to deploy Firestore rules and Cloud Functions to your Firebase project

## Google Sign In

Here's how to set up Google Sign In: [video explanation](https://www.loom.com/share/69ff9a9132dd4bed866b9f5a8ddd8e45)

## Apple Sign In

Here's how to set up Apple Sign In: [video explanation](https://www.loom.com/share/3325069427b84c24ac97842dca076688)

## Notifications

Notifications on iOS require additional setup: [docs](https://firebase.flutter.dev/docs/messaging/apple-integration/)

## RevenueCat

To integrate RevenueCat:

1. Set up RevenueCat: https://www.revenuecat.com/docs/getting-started
2. Update `_androidApiKey` and `_iosApiKey` in `app/feature/payment/provider/revenue_cat_provider.dart`
3. Update `Paywall` in `app/feature/payment/model/paywall.dart` to fit your needs
4. Update `PaywallPage` in `app/feature/payment/ui/page/paywall_page.dart` to fit your needs
5. Update `_ProviderDI` to use `RevenueCatProvider` instead of `MockPaywallProvider`

## Mixpanel

To integrate Mixpanel:

1. Set up Mixpanel: https://mixpanel.com
2. Update `_mixpanelToken` in `app/lib/feature/analytics/provider/mixpanel_analytics_provider.dart`

## Code Architecture

The code architecture is based on
[flutter_bloc architecture proposal](https://bloclibrary.dev/#/architecture).

There are 4 layers:

1. UI (Flutter Widgets)
2. BLoC (stateful business logic)
3. Repository (high-level API)
4. Provider (low-level implementation)

And there's only 1 communication rule that we must follow:

_**The layer can only call the one layer below it.**_

That means that:

- UI can only call BLoC
- BLoC can only call Repository
- Repository can only call Provider
- Provider can only call external services (Firebase, HTTP, etc.)

And we avoid same-layer communication (as it creates interdependencies):

- `UserRepository` calling `AuthRepository` is _**not**_ allowed.
- `UserCubit` calling `UserRepository` and `AuthRepository` is allowed.

When creating Providers, Repositories, and Cubits we follow this rule:

- Providers are created top-level (so that they can be used in multiple Repositories)
- Repositories are created top-level (so that they can be used in multiple Cubits)
- Cubits are created in the router builder callbacks (so that they're accessible only where needed)
- Cubits that are used in multiple screens are created top-level

## Styling

Styling is based on [Google's Material Design](https://material.io/design).

App-wide styling is defined in `core/app/style.dart` and is easy to update.

Here's a quick tip on custom Widget params. There are 2 Widget param types:

- data (user, title, ...)
- style (colors, paddings, ...)

Our custom Widgets should only hava data params.

And the style should be done app-wide (in `style.dart`).

That way all of our UI is consistent and easy to update.

## Google Fonts

To change the font:

1. Go to [Google Fonts](https://fonts.google.com/) and select a font.
2. Download the font files.
3. Add the font files to `assets/fonts` (remove the old ones).
4. Update `style.dart` with the new font (i.e. `return GoogleFonts.rubikTextTheme(textTheme)`).

## Localization

Localized string files are in `lib/l10n`.

To remove a language, just remove it's `.arb` file.

To add a language, duplicate `app_en.arb` and rename it to `app_xx.arb`
(where `xx` is the language code). Then translate the strings.

## Android Release Signing

1. Create a keystore file (if you don't already have one): 
```
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
-keysize 2048 -validity 10000 -alias upload
```
2. Create `app/android/key.properties` file with the following content:
```
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
```
3. To build the release bundle, run `flutter build appbundle`

## Useful GitHub Pull Request Settings

I've found that turning on these 2 settings in GitHub repo settings helps a lot:

1. `Always suggest updating pull request branches`
2. `Automatically delete head branches`

# FAQ

## Why bloc and not X?

While GetX, Provider, Riverpod, MobX, Redux, etc. are all great solutions,
most of them are too forgiving. They allow us to access and change state globally.

Whereas [flutter_bloc](https://bloclibrary.dev/) forces us to have `BuildContext`
in order to access and change the state. The stricter the rules, the harder it is to make mistakes.

And flutter_bloc has a great [architecture proposal](https://bloclibrary.dev/#/architecture) that
scales well.

## Where to learn Flutter basics?

I can only recommend what I've used myself:

- [Flutter Codelabs](https://docs.flutter.dev/codelabs)
- [Flutter YouTube](https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- and just keep building apps and getting better with each one :)

## What if I don't need a specific feature?

If you don't need a feature:

- delete its imported package in `pubspec.yaml`
- delete the code that uses the feature

# Resources

Build your app icon in minutes (free): [Icon Kitchen](https://icon.kitchen/)

Cool illustrations that match your app's colors (free): [unDraw](https://undraw.co/illustrations)

CI/CD for mobile apps (free & paid): [Codemagic](https://codemagic.io/)

Want me to launch your MVP in 4 weeks (premium)?
[Go to App Launch Program](https://applaunchprogram.com/)

Need a Flutter Expert (paid)? [Go to Flutter Devs Board](https://flutterdevsboard.com/)

# Support

Found an issue or want to request a feature? Open
an [issue](https://github.com/Gradoid/scalable_flutter_app_pro/issues)

Have a question? Ask me on [LinkedIn](https://www.linkedin.com/in/milos-jokic/)
or [Twitter](https://twitter.com/miloshjokic). Or send me an email at milos@gradoid.com

Enjoying Scalable Flutter App? [Leave a testimonial](https://testimonial.to/scalable-flutter-app)
