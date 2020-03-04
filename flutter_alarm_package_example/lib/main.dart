import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_package/alarm_project.g.dart';
import 'package:flutter_alarm_package/flutter_alarm_package.dart';
import 'package:flutter_mqtt/flutter_mqtt.dart';
import 'package:flutter_sqlite_controller/flutter_sqlite_controller.dart';
import 'package:flutter_sqlite_developer/flutter_sqlite_developer.dart';
import 'package:flutter_theme_package/flutter_theme_package.dart';
import 'package:flutter_tracers/trace.dart' as Log;

const mqttBrokerUrl = '192.168.20.242'; //LBJ?
const mqttAlarmTopic = 'alarms/all';

void main() => runApp(AlarmExampleApp());

class AlarmExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModeTheme(
      data: (brightness) => (brightness == Brightness.light) ? ModeThemeData.bright() : ModeThemeData.dark(),
      defaultBrightness: Brightness.light,
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          home: SqliteScreenWidget(
            childWidget: AlarmExample(),
            sqliteIdentity: SQLiteIdentity(databaseName: 'alarmPackage.db'),
          ),
          initialRoute: '/',
          routes: {
            AlarmExample.route: (context) => AlarmExampleApp(),
            SqliteScreenWidget.route: (context) => SqliteScreenWidget(
                  childWidget: AlarmExample(),
                  sqliteIdentity: SQLiteIdentity(databaseName: 'alarmPackage.db'),
                ),
          },
          theme: theme,
          title: 'AlarmExampleApp Demo',
        );
      },
    );
  }
}

class AlarmExample extends StatefulWidget {
  const AlarmExample({Key key}) : super(key: key);
  static const route = '/alarmExample';

  @override
  _AlarmExample createState() => _AlarmExample();
}

class _AlarmExample extends State<AlarmExample> with WidgetsBindingObserver, AfterLayoutMixin<AlarmExample> {
  bool hideSpinner = true;

  // ignore: non_constant_identifier_names
  Size get ScreenSize => MediaQuery.of(context).size;

  AlarmSession _alarmSession;
  MQTTStream _mqttStream = MQTTStream();
  MQTTManager _mqttManager;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Log.t('alarmExample initState()');
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Log.t('alarmExample afterFirstLayout()');
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    Log.t('alarmExample didChangeDependencies()');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Log.t('alarmExample didChangeAppLifecycleState ${state.toString()}');
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
    ModeTheme.of(context).setBrightness(brightness);
    Log.t('alarmExample didChangePlatformBrightness ${brightness.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    Log.t('alarmExample build()');
    return HudScaffold.progressText(
      context,
      hide: hideSpinner,
      indicatorColors: Swatch(bright: Colors.purpleAccent, dark: Colors.greenAccent),
      progressText: 'AlarmExample Showable spinner',
      scaffold: Scaffold(
        appBar: AppBar(
          title: Text('Title: alarmExample'),
        ),
        body: body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              hideSpinner = false;
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  hideSpinner = true;
                });
              });
            });
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    Log.t('alarmExample didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    Log.t('alarmExample deactivate()');
    super.deactivate();
  }

  @override
  void dispose() {
    Log.t('alarmExample dispose()');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Scaffold body
  Widget body() {
    Log.t('alarmExample body()');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('AlarmExample Template', style: Theme.of(context).textTheme.display1),
          RaisedButton(
            child: Text('Toggle Mode'),
            onPressed: () {
              ModeTheme.of(context).toggleBrightness();
            },
          ),
          RaisedButton(
            child: Text('Get MQTT Alarms'),
            onPressed: () {
              //_getAlarms();
              _userAlarms();
            },
          ),
        ],
      ),
    );
  }

  MQTTAlarmStream mqttAlarmStream = MQTTAlarmStream();
  FlutterAlarmPackage flutterAlarmPackage;
  void _userAlarms() {
    flutterAlarmPackage = FlutterAlarmPackage(
      mqttBrokerUrl: mqttBrokerUrl,
      mqttAlarmTopic: mqttAlarmTopic,
      sink: mqttAlarmStream.sink,
    );
    mqttAlarmStream.stream.listen((MQTTReceivedAlarms mqttReceivedAlarms) {
      /// MQTT returned alarm data
      Log.v('${mqttReceivedAlarms.mqttAppConnectionState.toString()}');
      if (mqttReceivedAlarms.mqttAppConnectionState == MQTTAppConnectionState.data) {
        _loadAlarms(mqttReceivedAlarms.jsonAlarmData);
      }
    });
    flutterAlarmPackage.getAlarms();
  }

  void _loadAlarms(List<dynamic> alarms) async {
    final payload = {'created': '${DateTime.now().toUtc().toIso8601String()}', 'alarms': alarms};
    _alarmSession = AlarmSession.fromJson(payload);
    await _alarmSession.deleteLink();
    await _alarmSession.createLink();
    Log.t('<Main.dart> alarm database entry created');
  }
}
