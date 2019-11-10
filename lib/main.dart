import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themingdemo/app_state.dart';

import 'app_theme.dart';

void main() => runApp(
      ChangeNotifierProvider<AppState>(
        builder: (context) => AppState(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: TaskPage(),
        );
      },
    );
  }
}

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  value: Provider.of<AppState>(context).isDarkModeOn,
                  onChanged: (booleanValue) {
                    Provider.of<AppState>(context).updateTheme(booleanValue);
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
