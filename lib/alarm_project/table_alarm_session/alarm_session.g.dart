/// AUTO-GENERATED CODE - DO NOT MODIFY
/// Created: February 27,2020 20:22(utc)

import 'package:flutter/material.dart';
import 'package:flutter_sqlite_controller/flutter_sqlite_controller.dart' as SQL;
import 'package:sqflite/sqflite.dart';

import '../table_mqttalarm/mqttalarm.g.dart';

///- Class declaration
class AlarmSession extends SQL.SQLParse<AlarmSession> {
  /// Class and Column keys
  static const String columnParentTableName = 'parentTableName';
  static const String columnParentRowid = 'parentRowid';
  static const String columnAlarms = 'alarms';
  static const String columnCreated = 'created';

  ///- Property/Column declarations
  static bool _createTableIfNeeded = true; //Safety check to avoid repeatedly creating the AlarmSession table

  List<MQTTAlarm> _alarms;
  List<MQTTAlarm> get alarms => _alarms;
  setAlarms(List<Map<String, dynamic>> newValue) => _alarms = MQTTAlarm.buildArray(newValue);

  String _created;
  DateTime get created => SQL.getDateTime(_created);
  setCreated(dynamic newValue) => _created = SQL.dateString(newValue);

  ///- ToJson
  Map<String, dynamic> toJson() => {
        'alarms': jsonArray<MQTTAlarm>(alarms),
        'created': created,
      };

  ///- ToCloud
  Map<String, dynamic> toCloud() => {
        'alarms': jsonArray<MQTTAlarm>(alarms),
        'created': created,
      };

  ///- Static constructors
  static AlarmSession build(dynamic data) {
    if (data == null) return null;
    if (data is Map) return AlarmSession.fromJson(data);
    if (data is AlarmSession) return data;
    throw Exception('static AlarmSessionBuild could not parse: ${data.toString()}');
  }

  ///- buildArray
  static List<AlarmSession> buildArray(List<dynamic> array) {
    List<AlarmSession> result = List();
    if (array == null) return result;
    if (array is List<Map<String, dynamic>>) {
      for (Map<String, dynamic> item in array) {
        if (item['parentTableName'] == null) {
          result.add(AlarmSession.fromCloud(item));
        } else {
          result.add(AlarmSession.fromJson(item));
        }
      }
      return result;
    }
    if (array is List<AlarmSession>) {
      for (AlarmSession item in array) {
        result.add(item);
      }
      return result;
    }
    throw Exception('Unknown datatype $array');
  }

  ///- Constructor
  AlarmSession({
    int parentRowid,
    String parentTableName,
    List<Map<String, dynamic>> alarms,
    dynamic created,
  }) {
    this.parentRowid = parentRowid;
    this.parentTableName = parentTableName;
    setAlarms(alarms);
    setCreated(created);
  }

  ///- Factory fromJson
  factory AlarmSession.fromJson(Map<String, dynamic> json) {
    var _instance = AlarmSession(
      parentRowid: json['parentRowid'] ?? 0,
      parentTableName: json['parentTableName'] ?? '',
      alarms: json['alarms']?.cast<Map<String, dynamic>>(),
      created: json['created'],
    );
    return _instance;
  }

  ///- Factory from Cloud
  factory AlarmSession.fromCloud(Map<String, dynamic> json) {
    var _instance = AlarmSession(
      alarms: json['alarms']?.cast<Map<String, dynamic>>(),
      created: json['created'],
    );
    return _instance;
  }

  ///- **************** BEGIN Sqlite C.R.U.D.  {Create, Read, Update, Delete}

  ///- SQLite Create
  Future<int> create({@required SQL.SQLiteLink link}) async {
    await createTable();
    this.parentRowid = link.rowid;
    this.parentTableName = link.tableName;
    final sql = '''INSERT INTO ALARMSESSION
     (
         parentRowid,
         parentTableName,
         created
     )
     VALUES
     (
         ${link.rowid},
         "${link.tableName}",
         "$_created"
     )''';

    int newRowid = await SQL.SqliteController.database.rawInsert(sql);
    this.rowid = newRowid;
    return this.rowid;
  }

  ///- SQLite Read
  static Future<List<AlarmSession>> read({SQL.SQLiteLink link, String whereClause, String orderBy = 'rowid'}) async {
    await createTable();
    final clause = whereClause ?? link?.clause;
    String sql = 'SELECT rowid,* from ALARMSESSION';
    if (clause != null) sql += ' WHERE $clause';
    if (orderBy != null) sql += ' ORDER BY $orderBy';
    List<Map<String, dynamic>> maps = await SQL.SqliteController.database.rawQuery(sql).catchError((error, stack) {
      throw Exception(error.toString());
    });
    List<AlarmSession> results = List();
    for (Map<String, dynamic> map in maps) {
      final result = AlarmSession.fromJson(map);
      result.rowid = map['rowid'];
      results.add(result);
    }
    return results;
  }

  ///- SQLite Update Class
  Future<int> update({SQL.SQLiteLink link}) async {
    final clause = link.clause;
    await createTable();
    this.parentRowid = link.rowid;
    this.parentTableName = link.tableName;
    final sql = '''UPDATE ALARMSESSION
     SET
       parentRowid = $parentRowid,
       parentTableName = "$parentTableName",
       created = "$created"
     WHERE $clause''';

    return await SQL.SqliteController.database.rawUpdate(sql);
  }

  ///- Create Delete
  Future<int> delete({SQL.SQLiteLink link, String where}) async {
    await createTable();
    final clause = where ?? link?.clause;
    String sql = 'DELETE FROM ALARMSESSION ';
    if (where != null) sql = '$sql WHERE $clause';
    return await SQL.SqliteController.database.rawDelete(sql);
  }

  ///- **************** END Sqlite C.R.U.D.  {Create, Read, Update, Delete}
  ///- **************** BEGINS Sqlite C.R.U.D. for linked records

  ///- SQLCreate Creates Linked Records
  Future<SQL.SQLiteLink> createLink({SQL.SQLiteLink sqlLink}) async {
    sqlLink ??= SQL.SQLiteLink(tableName: 'AlarmSession');
    this.rowid = await create(link: sqlLink);
    final childLink = SQL.SQLiteLink(rowid: this.rowid, tableName: className);
    alarms.forEach((rec) async => await rec.createLink(sqlLink: childLink));

    return childLink; //- Returning link to root/base object (aka "key" for future use)
  }

  ///- SQLRead Read all linked records
  static Future<List<AlarmSession>> readLink({SQL.SQLiteLink sqlLink, String whereClause, String orderBy}) async {
    String where = (sqlLink?.tableName == 'AlarmSession') ? '(rowid = ${sqlLink.rowid})' : sqlLink?.clause;
    where ??= whereClause;
    List<AlarmSession> list = await read(whereClause: where, orderBy: orderBy);
    for (AlarmSession item in list) {
      final SQL.SQLiteLink newLink = SQL.SQLiteLink(rowid: item.rowid, tableName: item.className);
      item._alarms = await MQTTAlarm.readLink(sqlLink: newLink);
    }
    return list;
  }

  ///- SQLReadRoot Read all linked records based on root-key
  static Future<AlarmSession> readRoot({SQL.SQLiteLink sqlLink}) async {
    assert(sqlLink != null);
    String clause = '(rowid = ${sqlLink.rowid})';
    List<AlarmSession> list = await readLink(whereClause: clause);
    if (list == null || list.length != 1) throw SQL.SQLiteRecordNotFoundException('Cannot find record: $clause', 400);
    return list[0];
  }

  ///- SQLUpdate update all linked records
  Future<void> updateLink({SQL.SQLiteLink sqlLink}) async {
    await update(link: sqlLink);
    final childLink = SQL.SQLiteLink(rowid: this.rowid, tableName: this.className);
    alarms.forEach((rec) async => await rec.updateLink(sqlLink: childLink));

    return null;
  }

  ///- SQLDelete delete all linked records
  Future<void> deleteLink({SQL.SQLiteLink sqlLink}) async {
    await delete(link: sqlLink);
    final childLink = SQL.SQLiteLink(rowid: this.rowid, tableName: className);

    alarms.forEach((rec) async => await rec.deleteLink(sqlLink: childLink));
    return null;
  }

  ///- **************** END Sqlite C.R.U.D. for linked records

  ///- **********
  ///- SQLite Create Table
  static Future<dynamic> createTable() async {
    if (!_createTableIfNeeded) return null;
    _createTableIfNeeded = false;
    final create = '''CREATE TABLE IF NOT EXISTS ALARMSESSION (
          parentRowid INTEGER DEFAULT 0,
          parentTableName TEXT DEFAULT '',
          created TEXT
          )''';

    await SQL.SqliteController.database.execute(create);
    return null;
  }

  //- ******** Helpers
  //- Utility helpers

  ///- SQL Count of records
  ///- Return count of records in AlarmSession
  static Future<int> count(String clause) async {
    await createTable();
    final whereClause = (clause == null) ? '' : 'WHERE $clause';
    final sql = 'SELECT COUNT("rowid") FROM AlarmSession $whereClause';
    return Sqflite.firstIntValue(await SQL.SqliteController.database.rawQuery(sql));
  }

  ///- SQL First record of query
  ///- Return first record of sql query
  static Future<AlarmSession> firstRecord({String where, String orderBy = 'rowid asc limit 1'}) async {
    await createTable();
    if (orderBy == null) throw Exception('static first - orderBy string null');
    List<AlarmSession> results = await readLink(whereClause: where, orderBy: orderBy);
    return (results != null && results.length > 0) ? results[0] : null;
  }
}
