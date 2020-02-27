/// AUTO-GENERATED CODE - DO NOT MODIFY
/// Created: February 27,2020 20:22(utc)

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_sqlite_controller/flutter_sqlite_controller.dart' as SQL;

///- Class declaration
class MQTTCommands extends SQL.SQLParse<MQTTCommands>{

   /// Class and Column keys
   static const String columnParentTableName = 'parentTableName';
   static const String columnParentRowid = 'parentRowid';
   static const String columnAggregate = 'aggregate';
   static const String columnAggregateId = 'aggregateId';
   static const String columnId = 'id';
   static const String columnName = 'name';

   ///- Property/Column declarations
   static bool _createTableIfNeeded = true;    //Safety check to avoid repeatedly creating the MQTTCommands table

   String _aggregate;
   String get aggregate => _aggregate;
   setAggregate(String newValue) => _aggregate = newValue;

   String _aggregateId;
   String get aggregateId => _aggregateId;
   setAggregateId(String newValue) => _aggregateId = newValue;

   String _id;
   String get id => _id;
   setId(String newValue) => _id = newValue;

   String _name;
   String get name => _name;
   setName(String newValue) => _name = newValue;


   ///- ToJson
   Map<String, dynamic> toJson() => {
       'aggregate': aggregate,
       'aggregateId': aggregateId,
       'id': id,
       'name': name,
   };

   ///- ToCloud
   Map<String, dynamic> toCloud() => {
       'aggregate': aggregate,
       'aggregateId': aggregateId,
       'id': id,
       'name': name,
   };

///- Static constructors
  static MQTTCommands build(dynamic data) {
    if (data == null) return null;
    if (data is Map) return MQTTCommands.fromJson(data);
    if (data is MQTTCommands) return data;
    throw Exception('static MQTTCommandsBuild could not parse: ${data.toString()}');
  }
  
  ///- buildArray
  static List<MQTTCommands> buildArray(List<dynamic> array) {
    List<MQTTCommands> result = List();
    if (array == null) return result;
    if (array is List<Map<String,dynamic>>) {
      for (Map<String,dynamic> item in array) {
         if (item['parentTableName'] == null) {
           result.add(MQTTCommands.fromCloud(item));
         } else {
           result.add(MQTTCommands.fromJson(item));
         }
      }
      return result;
    }
    if (array is List<MQTTCommands>) {
      for (MQTTCommands item in array) {
         result.add(item);
      }
      return result;
    }
    throw Exception('Unknown datatype $array');
  }


   ///- Constructor
   MQTTCommands({
       int parentRowid,
       String parentTableName,
       String aggregate,
       String aggregateId,
       String id,
       String name,
     }){
       this.parentRowid = parentRowid;
       this.parentTableName = parentTableName;
       setAggregate(aggregate);
       setAggregateId(aggregateId);
       setId(id);
       setName(name);
   }


   ///- Factory fromJson
   factory MQTTCommands.fromJson(Map<String, dynamic> json) { 
       var _instance = MQTTCommands(
         parentRowid : json['parentRowid'] ?? 0,
         parentTableName : json['parentTableName'] ?? '',
         aggregate : json['aggregate'],
         aggregateId : json['aggregateId'],
         id : json['id'],
         name : json['name'],
       );
       return _instance;
   }

   ///- Factory from Cloud
   factory MQTTCommands.fromCloud(Map<String, dynamic> json) { 
       var _instance = MQTTCommands(
         aggregate : json['aggregate'],
         aggregateId : json['aggregateId'],
         id : json['id'],
         name : json['name'],
       );
       return _instance;
   }
   ///- **************** BEGIN Sqlite C.R.U.D.  {Create, Read, Update, Delete}

   ///- SQLite Create 
   Future<int> create({@required SQL.SQLiteLink link}) async {
     await createTable();
     this.parentRowid = link.rowid;
     this.parentTableName = link.tableName;
     final sql = '''INSERT INTO MQTTCOMMANDS
     (
         parentRowid,
         parentTableName,
         aggregate,
         aggregateId,
         id,
         name
     )
     VALUES
     (
         ${link.rowid},
         "${link.tableName}",
         "$_aggregate",
         "$_aggregateId",
         "$_id",
         "$_name"
     )''';

     int newRowid = await SQL.SqliteController.database.rawInsert(sql);
     this.rowid = newRowid;
     return this.rowid;
   }

   ///- SQLite Read
   static Future<List<MQTTCommands>> read({SQL.SQLiteLink link, String whereClause, String orderBy = 'rowid'}) async {
    await createTable();
    final clause = whereClause ?? link?.clause;
    String sql = 'SELECT rowid,* from MQTTCOMMANDS';
    if (clause != null) sql += ' WHERE $clause';
    if (orderBy != null) sql += ' ORDER BY $orderBy';
    List<Map<String,dynamic>> maps = await SQL.SqliteController.database.rawQuery(sql).catchError((error, stack) {
       throw Exception(error.toString());
    });
    List<MQTTCommands> results = List();
    for (Map<String,dynamic> map in maps) {
       final result = MQTTCommands.fromJson(map);
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
     final sql = '''UPDATE MQTTCOMMANDS
     SET
       parentRowid = $parentRowid,
       parentTableName = "$parentTableName",
       aggregate = "$aggregate",
       aggregateId = "$aggregateId",
       id = "$id",
       name = "$name"
     WHERE $clause''';

     return await SQL.SqliteController.database.rawUpdate(sql);
   }

   ///- Create Delete
   Future<int> delete({SQL.SQLiteLink link, String where}) async {
      await createTable();
      final clause = where ?? link?.clause;
      String sql = 'DELETE FROM MQTTCOMMANDS ';
      if (where != null) sql = '$sql WHERE $clause';
      return await SQL.SqliteController.database.rawDelete(sql);
   }
   ///- **************** END Sqlite C.R.U.D.  {Create, Read, Update, Delete}
   ///- **************** BEGINS Sqlite C.R.U.D. for linked records

   ///- SQLCreate Creates Linked Records
   Future<SQL.SQLiteLink> createLink({SQL.SQLiteLink sqlLink}) async {
      sqlLink ??= SQL.SQLiteLink(tableName: 'MQTTCommands');
      this.rowid = await create(link: sqlLink);
      final childLink = SQL.SQLiteLink(rowid:this.rowid, tableName: className);
      return childLink;  //- Returning link to root/base object (aka "key" for future use)
   }

   ///- SQLRead Read all linked records
   static Future<List<MQTTCommands>> readLink({SQL.SQLiteLink sqlLink, String whereClause, String orderBy}) async {
      String where = (sqlLink?.tableName == 'MQTTCommands') ? '(rowid = ${sqlLink.rowid})' : sqlLink?.clause;
      where ??= whereClause;
      List<MQTTCommands> list = await read(whereClause: where, orderBy: orderBy);
      return list;
   }

   ///- SQLReadRoot Read all linked records based on root-key
   static Future<MQTTCommands> readRoot({SQL.SQLiteLink sqlLink}) async {
      assert(sqlLink != null);
      String clause = '(rowid = ${sqlLink.rowid})';
      List<MQTTCommands> list = await readLink(whereClause: clause);
      if (list == null || list.length != 1) throw SQL.SQLiteRecordNotFoundException('Cannot find record: $clause', 400);
      return list[0];
   }

   ///- SQLUpdate update all linked records
   Future<void> updateLink({SQL.SQLiteLink sqlLink}) async {
      await update(link: sqlLink);
      return null;
   }

   ///- SQLDelete delete all linked records
   Future<void> deleteLink({SQL.SQLiteLink sqlLink}) async {
      await delete(link: sqlLink);
      return null;
   }
   ///- **************** END Sqlite C.R.U.D. for linked records

   ///- **********
   ///- SQLite Create Table
   static Future<dynamic> createTable() async {
       if (!_createTableIfNeeded) return null;
       _createTableIfNeeded = false;
       final create = '''CREATE TABLE IF NOT EXISTS MQTTCOMMANDS (
          parentRowid INTEGER DEFAULT 0,
          parentTableName TEXT DEFAULT '',
          aggregate TEXT,
          aggregateId TEXT,
          id TEXT,
          name TEXT
          )''';

       await SQL.SqliteController.database.execute(create);
       return null;
   }

   //- ******** Helpers
   //- Utility helpers

   ///- SQL Count of records
   ///- Return count of records in MQTTCommands
  static Future<int> count(String clause) async {
    await createTable();
    final whereClause = (clause == null) ? '' : 'WHERE $clause';
    final sql = 'SELECT COUNT("rowid") FROM MQTTCommands $whereClause';
    return Sqflite.firstIntValue(await SQL.SqliteController.database.rawQuery(sql));
  }

   ///- SQL First record of query
   ///- Return first record of sql query
  static Future<MQTTCommands> firstRecord({String where, String orderBy = 'rowid asc limit 1'}) async {
    await createTable();
    if (orderBy == null) throw Exception('static first - orderBy string null');
    List<MQTTCommands> results = await readLink(whereClause: where, orderBy: orderBy);
    return (results != null && results.length > 0) ? results[0] : null;
  }
}
