import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/network/network_connectivity_bloc/network_connectivity_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:plugin_haven/remote_config/haven_remote_config_repository.dart';
import 'package:plugin_haven_example/example_app.dart';
import 'package:provider/provider.dart';

class ExampleHomeScreen extends StatefulWidget {
  const ExampleHomeScreen({super.key});

  @override
  State<ExampleHomeScreen> createState() => _ExampleHomeScreenState();
}

class _ExampleHomeScreenState extends State<ExampleHomeScreen> {
  String passId = '';
  String _platformVersion = 'Unknown';
  final _pluginHavenPlugin = PluginHaven();

  Future<String> _handleAdd() async {
    const String iosPath = 'assets/wallet/txfb.pass';
    const String googlePath = 'assets/wallet/txfb.gpass.json';
    const Map<String, dynamic> androidConfig = {
      'cardTitle/defaultValue/value': 'TFBI Auto Insurance Card',
      'hexBackgroundColor': '#ffffff',
      'subheader/defaultValue/value': 'Policy Owner',
      'header/defaultValue/value': 'Tom S. Customer',
      'textModulesData/0/header': 'NOT PROOF OF COVERAGE',
      'textModulesData/0/body': 'View Official ID Card in App',
      'textModulesData/1/header': 'VALID THRU',
      'textModulesData/1/body': '07/28/2023',
      'textModulesData/2/header': 'POLICY NUMBER',
      'textModulesData/2/body': '3986742247',
      'textModulesData/3/header': 'VEHICLE',
      'textModulesData/3/body': '2002 Ford F-150',
    };
    const Map<String, dynamic> iosConfig = {
      'organizationName': 'TFBI',
      'description': 'Texas Farm Bureau Insurance',
      'logoText': 'TFBI Auto Insurance Card',
      'foregroundColor': 'rgb(0, 45, 90)',
      'backgroundColor': 'rgb(255, 255, 255)',
      'generic/primaryFields/0/value': 'Tom S. Customer', // from API data
      'generic/secondaryFields/0/label': 'NOT PROOF OF COVERAGE',
      'generic/secondaryFields/0/value':
          'View Official ID Card in App', // from API data
      'generic/secondaryFields/1/label': 'VALID THRU',
      'generic/secondaryFields/1/value': '07/28/2023', // from API data
      'generic/auxiliaryFields/0/label': 'POLICY NUMBER',
      'generic/auxiliaryFields/0/value': '3986742211', // from API data
      'generic/auxiliaryFields/1/label': 'VEHICLE',
      'generic/auxiliaryFields/1/value': '2022 Ford F-350',
    };
    final String jsonTemplatePath = Platform.isIOS ? iosPath : googlePath;
    final Map<String, dynamic> configurationPaths =
        Platform.isIOS ? iosConfig : androidConfig;

    return WalletCardPlatform.instance.createPassFromTemplate(
      jsonTemplatePath: jsonTemplatePath,
      templateValues: configurationPaths,
    );
  }

  Future<bool?> _handleDelete() async {
    return WalletCardPlatform.instance.deletePass(deleteItem: passId);
  }

  void _initWalletCard() {
    WalletCardPlatform.serviceUrl(
      newUrl:
          Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://localhost:8000',
    );
  }

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    _initWalletCard();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _pluginHavenPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Haven Plugin epp example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  context.environment = ExampleApp.prod;
                },
                child: const Text('Switch to prod'),
              ),
              TextButton(
                onPressed: () {
                  context.environment = ExampleApp.stage;
                },
                child: const Text('Switch to stage'),
              ),
              TextButton(
                onPressed: () {
                  context.environment = ExampleApp.dev;
                },
                child: const Text('Switch to dev'),
              ),
              TextButton(
                onPressed: () {
                  context.environment = ExampleApp.qa;
                },
                child: const Text('Switch to qa'),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context)
                      .add(const AuthSignInEvent());
                },
                child: const Text('Sign in'),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(AuthSignOutEvent());
                },
                child: const Text('Sign out'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Text('Auth state: ${state.runtimeType}');
                  },
                ),
              ),
              Text(
                'Environment: ${context.getEnvironment()}',
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Platform version: $_platformVersion',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: WalletCardPlatform.instance.getWalletIcon(),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 5)),
                      const FittedBox(
                        child: Text(
                          'Must run CA service!',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    passId = await _handleAdd();
                    debugPrint('passId returned: "$passId"');
                    if (passId.isNotEmpty) {
                      setState(() {});
                    }
                  },
                ),
              ),
              if (passId.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: CupertinoButton(
                    child: const Text('Delete test pass'),
                    onPressed: () async {
                      bool? ok = await _handleDelete();
                      debugPrint('Delete result: ${ok ?? false}');
                      if (ok ?? false) {
                        setState(() {
                          passId = '';
                        });
                      }
                    },
                  ),
                ),
              BlocListener<NetworkConnectivityBloc, NetworkConnectivityState>(
                listener: (context, state) {
                  if (state is NetworkConnectivityConnectedState) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  } else if (state is NetworkConnectivityDisconnectedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(days: 1),
                        content: Text('Disconnected from the internet'),
                      ),
                    );
                  }
                },
                child: const SizedBox.shrink(),
              ),
              ValueListenableBuilder(
                valueListenable: Provider.of<
                    ValueNotifier<HavenRemoteConfigurationRepository?>>(
                  context,
                ),
                builder: (context, value, child) => Text(
                  "Remote config value: ${value?.getString("hello_world")}",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
