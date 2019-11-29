import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:themingdemo/app_state.dart';

import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(AppStateAdapter(), 0);
  final appStateBox = await Hive.openBox('appStateBox');
  if (appStateBox.get("appState") == null) {
    appStateBox.put("appState", AppState());
  }
  runApp(
    WatchBoxBuilder(
      box: Hive.box('appStateBox'),
      builder: (context, box) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final AppState appState = Hive.box("appStateBox").get("appState");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
      home: TaskPage(),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState appState = Hive.box("appStateBox").get("appState");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(Icons.menu),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 32, top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Today",
                  style: Theme.of(context).textTheme.headline,
                ),
                Icon(Icons.add_circle_outline),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Icon(
                  Icons.call,
                  color: Theme.of(context).iconTheme.color,
                ),
                title: Text(
                  "Conference Call",
                  style: Theme.of(context).textTheme.body1,
                ),
                subtitle: Text("30 mins", style: Theme.of(context).textTheme.body2),
                trailing: Icon(Icons.check_circle, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text('Dark Mode', style: Theme.of(context).textTheme.body2),
                Spacer(),
                Switch(
                  value: appState.isDarkModeOn,
                  onChanged: (booleanValue) {
                    appState.updateTheme(booleanValue);
                    Hive.box('appStateBox').put("appState", appState);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
