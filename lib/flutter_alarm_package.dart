library flutter_alarm_package;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_abstract_package/flutter_abstract_package.dart';
import 'package:flutter_alarm_package/alarm_project.g.dart';
import 'package:flutter_mqtt/flutter_mqtt.dart';
import 'package:flutter_tracers/trace.dart' as Log;

export 'alarm_project.g.dart';

///++
class MQTTReceivedAlarms {
  final AlarmSession alarmSession;
  final MQTTAppConnectionState mqttAppConnectionState;
  final List<dynamic> jsonAlarmData;
  MQTTReceivedAlarms({this.alarmSession, this.mqttAppConnectionState, this.jsonAlarmData});
}

///++
class MQTTAlarmStream extends BroadcastStream<MQTTReceivedAlarms> {
  @override
  void dispose() {
    close();
  }
}

/// Package to use mqtt to receive alarm data from mqtt-server.
/// This class and it methods use Flutter Streams to publish data when it is available.
/// As part of the creating an instance an Flutter-sink Sink<MQTTReceivedAlarms> has to be
/// provided, MQTTReceivedAlarms is class (above) that has the information about alarms,
/// and various mqtt connection state information, and raw alarm data to use as payloads
/// back to the server for alarm state management.
///
/// AlarmSession is class that can use a SQLite backend store to save alarm data (the returned
/// session, by default, DOES NOT SAVE alarm data in the SQLite store {a call to 'session.createLink();'
/// will create a sqlite entry.
class FlutterAlarmPackage {
  MQTTStream _mqttStream = MQTTStream();
  MQTTManager _mqttManager;

  /// the address of the broker
  final String mqttBrokerUrl;

  /// the name of the alarm topic to subscribe to
  final String mqttAlarmTopic;

  /// The stream-sink that will get alarm data returned to
  final Sink<MQTTReceivedAlarms> sink;
  FlutterAlarmPackage({@required this.mqttBrokerUrl, @required this.mqttAlarmTopic, @required this.sink});

  /// After the instance has been created this method will
  void getAlarms() {
    _mqttStream.stream.listen((mqttResponse) async {
      Log.v('flutter_alarm_package.dart: MQTT ${mqttResponse.mqttAppConnectionState.toString()}');
      Log.t('-> ${mqttResponse.topic}');
      Log.t('-> ${(mqttResponse.data ?? '').substring(0, 30)}....');
      if (mqttResponse.mqttAppConnectionState == MQTTAppConnectionState.data) {
        dynamic alarmJson = await jsonDecode(mqttResponse.data);
        final payload = {'created': '${DateTime.now().toUtc().toIso8601String()}', 'alarms': alarmJson};
        final session = AlarmSession.fromJson(payload);
        final receivedAlarms = MQTTReceivedAlarms(
          alarmSession: session,
          jsonAlarmData: alarmJson,
          mqttAppConnectionState: MQTTAppConnectionState.data,
        );
        sink.add(receivedAlarms);
      } else {
        sink.add(MQTTReceivedAlarms(mqttAppConnectionState: mqttResponse.mqttAppConnectionState));
      }
    });

    _mqttManager = MQTTManager(host: mqttBrokerUrl, sink: _mqttStream.sink, topic: mqttAlarmTopic)
      ..initializeMQTTClient()
      ..connect();
  }

  /// Good housekeeping and to avoid memory leaks or inconsistent mqtt server connections, the
  /// call app should 'disconnect' when listening to mqtt is not needed.
  void disconnect() {
    _mqttManager.disconnect();
  }
}
