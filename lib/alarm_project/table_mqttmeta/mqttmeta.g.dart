/// AUTO-GENERATED CODE - DO NOT MODIFY
/// Created: February 27,2020 20:22(utc)

import 'package:flutter/material.dart';
import 'package:flutter_sqlite_controller/flutter_sqlite_controller.dart' as SQL;
import 'package:sqflite/sqflite.dart';

import '../table_mqttcommands/mqttcommands.g.dart';

///- Class declaration
class MQTTMeta extends SQL.SQLParse<MQTTMeta> {
  /// Class and Column keys
  static const String columnParentTableName = 'parentTableName';
  static const String columnParentRowid = 'parentRowid';
  static const String columnAggregatedId = 'aggregatedId';
  static const String columnCommands = 'commands';
  static const String columnCreatedAt = 'createdAt';
  static const String columnUpdatedAt = 'updatedAt';

  ///- Property/Column declarations
  static bool _createTableIfNeeded = true; //Safety check to avoid repeatedly creating the MQTTMeta table

  String _aggregatedId;
  String get aggregatedId => _aggregatedId;
  setAggregatedId(String newValue) => _aggregatedId = newValue;

  List<MQTTCommands> _commands;
  List<MQTTCommands> get commands => _commands;
  setCommands(List<Map<String, dynamic>> newValue) => _commands = MQTTCommands.buildArray(newValue);

  String _createdAt;
  String get createdAt => _createdAt;
  setCreatedAt(String newValue) => _createdAt = newValue;

  String _updatedAt;
  String get updatedAt => _updatedAt;
  setUpdatedAt(String newValue) => _updatedAt = newValue;

  ///- ToJson
  Map<String, dynamic> toJson() => {
        'aggregatedId': aggregatedId,
        'commands': jsonArray<MQTTCommands>(commands),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  ///- ToCloud
  Map<String, dynamic> toCloud() => {
        'aggregatedId': aggregatedId,
        'commands': jsonArray<MQTTCommands>(commands),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  ///- Static constructors
  static MQTTMeta build(dynamic data) {
    if (data == null) return null;
    if (data is Map) return MQTTMeta.fromJson(data);
    if (data is MQTTMeta) return data;
    throw Exception('static MQTTMetaBuild could not parse: ${data.toString()}');
  }

  ///- buildArray
  static List<MQTTMeta> buildArray(List<dynamic> array) {
    List<MQTTMeta> result = List();
    if (array == null) return result;
    if (array is List<Map<String, dynamic>>) {
      for (Map<String, dynamic> item in array) {
        if (item['parentTableName'] == null) {
          result.add(MQTTMeta.fromCloud(item));
        } else {
          result.add(MQTTMeta.fromJson(item));
        }
      }
      return result;
    }
    if (array is List<MQTTMeta>) {
      for (MQTTMeta item in array) {
        result.add(item);
      }
      return result;
    }
    throw Exception('Unknown datatype $array');
  }

  ///- Constructor
  MQTTMeta({
    int parentRowid,
    String parentTableName,
    String aggregatedId,
    List<Map<String, dynamic>> commands,
    String createdAt,
    String updatedAt,
  }) {
    this.parentRowid = parentRowid;
    this.parentTableName = parentTableName;
    setAggregatedId(aggregatedId);
    setCommands(commands);
    setCreatedAt(createdAt);
    setUpdatedAt(updatedAt);
  }

  ///- Factory fromJson
  factory MQTTMeta.fromJson(Map<String, dynamic> json) {
    var _instance = MQTTMeta(
      parentRowid: json['parentRowid'] ?? 0,
      parentTableName: json['parentTableName'] ?? '',
      aggregatedId: json['aggregatedId'],
      commands: json['commands']?.cast<Map<String, dynamic>>(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
    return _instance;
  }

  ///- Factory from Cloud
  factory MQTTMeta.fromCloud(Map<String, dynamic> json) {
    var _instance = MQTTMeta(
      aggregatedId: json['aggregatedId'],
      commands: json['commands']?.cast<Map<String, dynamic>>(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
    return _instance;
  }

  ///- **************** BEGIN Sqlite C.R.U.D.  {Create, Read, Update, Delete}

  ///- SQLite Create
  Future<int> create({@required SQL.SQLiteLink link}) async {
    await createTable();
    this.parentRowid = link.rowid;
    this.parentTableName = link.tableName;
    final sql = '''INSERT INTO MQTTMETA
     (
         parentRowid,
         parentTableName,
         aggregatedId,
         createdAt,
         updatedAt
     )
     VALUES
     (
         ${link.rowid},
         "${link.tableName}",
         "$_aggregatedId",
         "$_createdAt",
         "$_updatedAt"
     )''';

    int newRowid = await SQL.SqliteController.database.rawInsert(sql);
    this.rowid = newRowid;
    return this.rowid;
  }

  ///- SQLite Read
  static Future<List<MQTTMeta>> read({SQL.SQLiteLink link, String whereClause, String orderBy = 'rowid'}) async {
    await createTable();
    final clause = whereClause ?? link?.clause;
    String sql = 'SELECT rowid,* from MQTTMETA';
    if (clause != null) sql += ' WHERE $clause';
    if (orderBy != null) sql += ' ORDER BY $orderBy';
    List<Map<String, dynamic>> maps = await SQL.SqliteController.database.rawQuery(sql).catchError((error, stack) {
      throw Exception(error.toString());
    });
    List<MQTTMeta> results = List();
    for (Map<String, dynamic> map in maps) {
      final result = MQTTMeta.fromJson(map);
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
    final sql = '''UPDATE MQTTMETA
     SET
       parentRowid = $parentRowid,
       parentTableName = "$parentTableName",
       aggregatedId = "$aggregatedId",
       createdAt = "$createdAt",
       updatedAt = "$updatedAt"
     WHERE $clause''';

    return await SQL.SqliteController.database.rawUpdate(sql);
  }

  ///- Create Delete
  Future<int> delete({SQL.SQLiteLink link, String where}) async {
    await createTable();
    final clause = where ?? link?.clause;
    String sql = 'DELETE FROM MQTTMETA ';
    if (where != null) sql = '$sql WHERE $clause';
    return await SQL.SqliteController.database.rawDelete(sql);
  }

  ///- **************** END Sqlite C.R.U.D.  {Create, Read, Update, Delete}
  ///- **************** BEGINS Sqlite C.R.U.D. for linked records

  ///- SQLCreate Creates Linked Records
  Future<SQL.SQLiteLink> createLink({SQL.SQLiteLink sqlLink}) async {
    sqlLink ??= SQL.SQLiteLink(tableName: 'MQTTMeta');
    this.rowid = await create(link: sqlLink);
    final childLink = SQL.SQLiteLink(rowid: this.rowid, tableName: className);
    commands.forEach((rec) async => await rec.createLink(sqlLink: childLink));

    return childLink; //- Returning link to root/base object (aka "key" for future use)
  }

  ///- SQLRead Read all linked records
  static Future<List<MQTTMeta>> readLink({SQL.SQLiteLink sqlLink, String whereClause, String orderBy}) async {
    String where = (sqlLink?.tableName == 'MQTTMeta') ? '(rowid = ${sqlLink.rowid})' : sqlLink?.clause;
    where ??= whereClause;
    List<MQTTMeta> list = await read(whereClause: where, orderBy: orderBy);
    for (MQTTMeta item in list) {
      final SQL.SQLiteLink newLink = SQL.SQLiteLink(rowid: item.rowid, tableName: item.className);
      item._commands = await MQTTCommands.readLink(sqlLink: newLink);
    }
    return list;
  }

  ///- SQLReadRoot Read all linked records based on root-key
  static Future<MQTTMeta> readRoot({SQL.SQLiteLink sqlLink}) async {
    assert(sqlLink != null);
    String clause = '(rowid = ${sqlLink.rowid})';
    List<MQTTMeta> list = await readLink(whereClause: clause);
    if (list == null || list.length != 1) throw SQL.SQLiteRecordNotFoundException('Cannot find record: $clause', 400);
    return list[0];
  }

  ///- SQLUpdate update all linked records
  Future<void> updateLink({SQL.SQLiteLink sqlLink}) async {
    await update(link: sqlLink);
    final childLink = SQL.SQLiteLink(rowid: this.rowid, tableName: this.className);
    commands.forEach((rec) async => await rec.updateLink(sqlLink: childLink));

    return null;
  }

  ///- SQLDelete delete all linked records
  Future<void> deleteLink({SQL.SQLiteLink sqlLink}) async {
    await delete(link: sqlLink);
    final childLink = SQL.SQLiteLink(rowid: this.rowid, tableName: className);

    commands.forEach((rec) async => await rec.deleteLink(sqlLink: childLink));
    return null;
  }

  ///- **************** END Sqlite C.R.U.D. for linked records

  ///- **********
  ///- SQLite Create Table
  static Future<dynamic> createTable() async {
    if (!_createTableIfNeeded) return null;
    _createTableIfNeeded = false;
    final create = '''CREATE TABLE IF NOT EXISTS MQTTMETA (
          parentRowid INTEGER DEFAULT 0,
          parentTableName TEXT DEFAULT '',
          aggregatedId TEXT,
          createdAt TEXT,
          updatedAt TEXT
          )''';

    await SQL.SqliteController.database.execute(create);
    return null;
  }

  //- ******** Helpers
  //- Utility helpers

  ///- SQL Count of records
  ///- Return count of records in MQTTMeta
  static Future<int> count(String clause) async {
    await createTable();
    final whereClause = (clause == null) ? '' : 'WHERE $clause';
    final sql = 'SELECT COUNT("rowid") FROM MQTTMeta $whereClause';
    return Sqflite.firstIntValue(await SQL.SqliteController.database.rawQuery(sql));
  }

  ///- SQL First record of query
  ///- Return first record of sql query
  static Future<MQTTMeta> firstRecord({String where, String orderBy = 'rowid asc limit 1'}) async {
    await createTable();
    if (orderBy == null) throw Exception('static first - orderBy string null');
    List<MQTTMeta> results = await readLink(whereClause: where, orderBy: orderBy);
    return (results != null && results.length > 0) ? results[0] : null;
  }
}
