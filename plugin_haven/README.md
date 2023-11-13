# plugin_haven

A plugin for haven: BottleRocketStudios Flutter Foundation for App Development

## Getting Started

Lorem

## Important Components

### HavenApp

The `HavenApp` widget is the main entry point for your app. You should extend the `HavenApp` widget for your app, and take advantage of its features, such as automatic splash screens, dynamic environment configuration, and more.

#### HavenApp Init Configuration

HavenApp takes in an `InitConfiguration` object. This configuration object is used to configure your app, one time, at launch. It should be independent of the environment. See the `Environment Configuration` section below for more information on how to configure your app for different environments.

1. `environmentConfigurationFactory` - This is a function that returns an `EnvironmentConfiguration` object. This object is used to configure your app for a specific environment. For example, you may want to use a different `SplashConfiguration` depending on whether you are in `dev` or `prod`. You can also use this to configure your `AuthRepository` to use a different url for each environment. Anything that can be configured on a per-environment basis should be setup using this function.
2. `onInitialize` - This is a function that is called automatically by HavenApp on launch. Use it to configure environment independent pieces of your app.
3. `initialEnvironment` - This is the initial environment that the app will be configured for. This is used to configure the app for the first time, and is not used again after that.

<details>
<summary>Show me an example! </summary>

<br>

```dart
InitConfiguration(
  initialEnvironment: Environment.dev,
  environmentConfigurationFactory: createEnvironmentConfiguration,
  onInitialize: () async {
    print('Running one time initialization');
  },
)
```

</details>

<br>

#### HavenApp Environment Configuration

HavenApp also provides a way to change the environment that the app is configured for. This is useful for things like switching between `dev` and `prod` environments on the fly.

To configure the environment, pass in the `environmentConfigurationFactory` function to HavenApp. This function passes you an `Environment` object, and you can use it to return an `EnvironmentConfiguration` object. Anything that can be configured on a per-environment basis should be setup using this function, such as splash configuration, auth repository, etc.

This environment is then automatically passed down the widget tree so you can access it anywhere in your app using the `context.getEnvironment()` getter. You can also update the environment anywhere using the environment setter `context.environment = yourEnvironmentObject`.

<details>
<summary>Show me an example! </summary>

<br>

```dart
InitConfiguration(
  initialEnvironment: ExampleApp.dev,
  environmentConfigurationFactory: (Environment environment) {
    if (environment is Environment.dev) {
      return EnvironmentConfiguration(
        splashConfiguration: SplashConfiguration(
          lottiePath: 'assets/lottie/dev.json',
        ),
        onChangeEnvironment: () {
          print('Changing environment to dev');
        }
      );
    } else if (environment is Environment.prod) {
      return EnvironmentConfiguration(
        splashConfiguration: SplashConfiguration(
          lottiePath: 'assets/lottie/prod.json',
        ),
        onChangeEnvironment: () {
          print('Changing environment to prod');
        }
      );
    }
  },
  onInitialize: () async {
    print('Running one time initialization');
  },
)
```

</details>

<br>

#### HavenApp AuthBloc

HavenApp also provides a way to automatically handle authentication for your app. This is done using the `AuthBloc`, which HavenApp will automatically create for you and pass down the widget tree.

To configure the `AuthBloc`, specify an `AuthRepository` inside of the `environmentConfigurationFactory` function when you return your `EnvironmentConfiguration` object. HavenApp will automatically listen to the `AuthRepository` and update the `AuthBloc` when the auth state changes.

To read information from the `AuthBloc` state, just use a `BlocBuilder` and listen to the `AuthBloc` state.

To update the auth state, use the `AuthBloc`'s `add` method. For example, to log the user in, use `BlocProvider.of<AuthBloc>(context).add(AuthSignInEvent())`.

<details>
<summary>Show me an example! </summary>

<br>

```dart
// Your app InitConfiguration
InitConfiguration(
  environmentConfigurationFactory: (Environment environment) {
    return EnvironmentConfiguration(
      authRepository: AuthRepository(),
    );
  },
)

// Your widget
class AuthBlocExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitState) {
          return Center(
            child: RaisedButton(
              child: Text('Sign In'),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context, listen: false).add(AuthSignInEvent());
              },
            ),
          );
        } else if (state is AuthSignedIn) {
          return Center(
            child: Text('User is logged in'),
          );
        } else if (state is AuthProcessing) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
```

</details>

---

### Splash Bloc

> Note: Generally, if you use HavenApp as your root widget, you won't need to worry about this. HavenApp will automatically create a `SplashBloc` for you. You can use the `SplashBloc` to create your own implementation of the splash screen functionality if you don't like the one provided in `HavenApp`.

Typically, your app will want to do some initialization work on app startup before displaying the main screen.

For example, you may want to check if the user is already logged in, and route them to the correct screen based on their auth state.

Here is where the `SplashBloc` comes in.

`SplashBloc` can register multiple `waiters` using the `AddSplashWaiterEvent` event. Adding these `waiters` will tell the `SplashBloc` not to hide the splash screen until the `waiters` are done. You can mark a waiter as done using the `RemoveSplashWaiterEvent` event. Once all `waiters` are done, the `SplashBloc` will emit a `DoneSplashState` event, which you can listen to in your app to know when to show the main screen.

The `HavenApp` widget will automatically create a `SplashBloc` for you, which you can pass a list of `waiters` to through the `EnvironmentConfiguration.splashConfiguration.waiters`. Generally, if you are providing an `AuthRespository` to HavenApp, you will want to include it in the `waiters` list so that the splash screen will wait until the auth state is known before showing the main screen.

<details>
<summary>Show me an example!</summary>
<br>

```dart
class SplashBlocExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is DoneSplashState) {
            return AppView();
          } else if (state is LottieSplashState) {
            return LottieSplashView();
          } else if (state is ImageSplashState) {
            return ImageSplashView();
          } else if (state is TextSplashState) {
            return TextSplashView();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
```

</details>

---
#### Haven Wallet Integration

The wallet module facilitates the creation of a generic pass (card) for insertion
into the Apple or Google Wallet applications. It provides 3 calls to manage the process
(create, list, and delete) as well as access to the Apple/Google specific icon to 
be displayed in the UI conformance with rules established by Apple and Google for interacting
with the wallet apps. Not that a CA service running remotely is required to authenticate
and sign the cards which allows placement in the wallets. 

Note that the two json configure files need to be placed in the assets directory and
referenced in the pubspec.yaml file for the app using the wallet card.

<details?
To use the wallet platform module, look in the example/ folder, specifically in the
example_home_screen.dart file for an example of how to use the code. As always,
remember to include the haven export file. 

```dart
import 'package:plugin_haven/plugin_haven.dart';

// Initialize before usage. If not using localhost, usually use a single service for signing.
void _initWalletCard() {
  WalletCardPlatform.serviceUrl(
    newUrl:
    Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://localhost:8000',
  );
}

// Function to respond to wallet card button 
  Future<String> _handleAdd() async {
    const String iosPath = 'assets/wallet/txfb.pass';
    const String googlePath = 'assets/wallet/txfb.gpass.json';
    const Map<String, dynamic> androidConfig = {
      'textModulesData/3/body': 'Christmas'
    };
    const Map<String, dynamic> iosConfig = {
      'generic/secondaryFields/0/value': '2023'
    };
    final String jsonTemplatePath = Platform.isIOS ? iosPath : googlePath;
    final Map<String, dynamic> configurationPaths =
    Platform.isIOS ? iosConfig : androidConfig;

    return WalletCardPlatform.instance.createPassFromTemplate(
      jsonTemplatePath: jsonTemplatePath,
      templateValues: configurationPaths,
    );
  }
  
  // Function to delete a wallet card
  Future<bool?> _handleDelete() async {
    return WalletCardPlatform.instance.deletePass(deleteItem: passId);
  }
  
  // Code to get wallet icon and deploy card to wallet app
  child: CupertinoButton(
    child: WalletCardPlatform.instance.getWalletIcon(),
      onPressed: () async {
      passId = await _handleAdd();
      debugPrint('passId returned: "$passId"');
      if (passId.isNotEmpty) {
        setState(() {});
      }
    },
  ),

```

</details?