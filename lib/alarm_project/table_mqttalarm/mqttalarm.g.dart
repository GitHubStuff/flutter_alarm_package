/// AUTO-GENERATED CODE - DO NOT MODIFY
/// Created: February 27,2020 20:22(utc)

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_sqlite_controller/flutter_sqlite_controller.dart' as SQL;

import '../table_mqttmeta/mqttmeta.g.dart';


///- Class declaration
class MQTTAlarm extends SQL.SQLParse<MQTTAlarm>{

   /// Class and Column keys
   static const String columnParentTableName = 'parentTableName';
   static const String columnParentRowid = 'parentRowid';
   static const String columnMetta = 'metta';
   static const String columnOriginator = 'originator';
   static const String columnOriginatorId = 'originatorId';
   static const String columnStatus = 'status';
   static const String columnUniqueQualifier = 'uniqueQualifier';

   ///- Property/Column declarations
   static bool _createTableIfNeeded = true;    //Safety check to avoid repeatedly creating the MQTTAlarm table

   MQTTMeta _metta;
   MQTTMeta get metta => _metta;
   setMetta(dynamic newValue) => _metta = MQTTMeta.build(newValue);

   String _originator;
   String get originator => _originator;
   setOriginator(String newValue) => _originator = newValue;

   String _originatorId;
   String get originatorId => _originatorId;
   setOriginatorId(String newValue) => _originatorId = newValue;

   String _status;
   String get status => _status;
   setStatus(String newValue) => _status = newValue;

   String _uniqueQualifier;
   String get uniqueQualifier => _uniqueQualifier;
   setUniqueQualifier(String newValue) => _uniqueQualifier = newValue;


   ///- ToJson
   Map<String, dynamic> toJson() => {
       'metta': metta.toJson(),
       'originator': originator,
       'originatorId': originatorId,
       'status': status,
       'uniqueQualifier': uniqueQualifier,
   };

   ///- ToCloud
   Map<String, dynamic> toCloud() => {
       'meta': metta.toJson(),
       'originator': originator,
       'originatorId': originatorId,
       'status': status,
       'uniqueQualifier': uniqueQualifier,
   };

///- Static constructors
  static MQTTAlarm build(dynamic data) {
    if (data == null) return null;
    if (data is Map) return MQTTAlarm.fromJson(data);
    if (data is MQTTAlarm) return data;
    throw Exception('static MQTTAlarmBuild could not parse: ${data.toString()}');
  }
  
  ///- buildArray
  static List<MQTTAlarm> buildArray(List<dynamic> array) {
    List<MQTTAlarm> result = List();
    if (array == null) return result;
    if (array is List<Map<String,dynamic>>) {
      for (Map<String,dynamic> item in array) {
         if (item['parentTableName'] == null) {
           result.add(MQTTAlarm.fromCloud(item));
         } else {
           result.add(MQTTAlarm.fromJson(item));
         }
      }
      return result;
    }
    if (array is List<MQTTAlarm>) {
      for (MQTTAlarm item in array) {
         result.add(item);
      }
      return result;
    }
    throw Exception('Unknown datatype $array');
  }


   ///- Constructor
   MQTTAlarm({
       int parentRowid,
       String parentTableName,
       dynamic metta,
       String originator,
       String originatorId,
       String status,
       String uniqueQualifier,
     }){
       this.parentRowid = parentRowid;
       this.parentTableName = parentTableName;
       setMetta(metta);
       setOriginator(originator);
       setOriginatorId(originatorId);
       setStatus(status);
       setUniqueQualifier(uniqueQualifier);
   }


   ///- Factory fromJson
   factory MQTTAlarm.fromJson(Map<String, dynamic> json) { 
       var _instance = MQTTAlarm(
         parentRowid : json['parentRowid'] ?? 0,
         parentTableName : json['parentTableName'] ?? '',
         metta : json['metta'],
         originator : json['originator'],
         originatorId : json['originatorId'],
         status : json['status'],
         uniqueQualifier : json['uniqueQualifier'],
       );
       return _instance;
   }

   ///- Factory from Cloud
   factory MQTTAlarm.fromCloud(Map<String, dynamic> json) { 
       var _instance = MQTTAlarm(
         metta : json['meta'],
         originator : json['originator'],
         originatorId : json['originatorId'],
         status : json['status'],
         uniqueQualifier : json['uniqueQualifier'],
       );
       return _instance;
   }
   ///- **************** BEGIN Sqlite C.R.U.D.  {Create, Read, Update, Delete}

   ///- SQLite Create 
   Future<int> create({@required SQL.SQLiteLink link}) async {
     await createTable();
     this.parentRowid = link.rowid;
     this.parentTableName = link.tableName;
     final sql = '''INSERT INTO MQTTALARM
     (
         parentRowid,
         parentTableName,
         originator,
         originatorId,
         status,
         uniqueQualifier
     )
     VALUES
     (
         ${link.rowid},
         "${link.tableName}",
         "$_originator",
         "$_originatorId",
         "$_status",
         "$_uniqueQualifier"
     )''';

     int newRowid = await SQL.SqliteController.database.rawInsert(sql);
     this.rowid = newRowid;
     return this.rowid;
   }

   ///- SQLite Read
   static Future<List<MQTTAlarm>> read({SQL.SQLiteLink link, String whereClause, String orderBy = 'rowid'}) async {
    await createTable();
    final clause = whereClause ?? link?.clause;
    String sql = 'SELECT rowid,* from MQTTALARM';
    if (clause != null) sql += ' WHERE $clause';
    if (orderBy != null) sql += ' ORDER BY $orderBy';
    List<Map<String,dynamic>> maps = await SQL.SqliteController.database.rawQuery(sql).catchError((error, stack) {
       throw Exception(error.toString());
    });
    List<MQTTAlarm> results = List();
    for (Map<String,dynamic> map in maps) {
       final result = MQTTAlarm.fromJson(map);
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
     final sql = '''UPDATE MQTTALARM
     SET
       parentRowid = $parentRowid,
       parentTableName = "$parentTableName",
       originator = "$originator",
       originatorId = "$originatorId",
       status = "$status",
       uniqueQualifier = "$uniqueQualifier"
     WHERE $clause''';

     return await SQL.SqliteController.database.rawUpdate(sql);
   }

   ///- Create Delete
   Future<int> delete({SQL.SQLiteLink link, String where}) async {
      await createTable();
      final clause = where ?? link?.clause;
      String sql = 'DELETE FROM MQTTALARM ';
      if (where != null) sql = '$sql WHERE $clause';
      return await SQL.SqliteController.database.rawDelete(sql);
   }
   ///- **************** END Sqlite C.R.U.D.  {Create, Read, Update, Delete}
   ///- **************** BEGINS Sqlite C.R.U.D. for linked records

   ///- SQLCreate Creates Linked Records
   Future<SQL.SQLiteLink> createLink({SQL.SQLiteLink sqlLink}) async {
      sqlLink ??= SQL.SQLiteLink(tableName: 'MQTTAlarm');
      this.rowid = await create(link: sqlLink);
      final childLink = SQL.SQLiteLink(rowid:this.rowid, tableName: className);
      await metta.createLink(sqlLink: childLink);

      return childLink;  //- Returning link to root/base object (aka "key" for future use)
   }

   ///- SQLRead Read all linked records
   static Future<List<MQTTAlarm>> readLink({SQL.SQLiteLink sqlLink, String whereClause, String orderBy}) async {
      String where = (sqlLink?.tableName == 'MQTTAlarm') ? '(rowid = ${sqlLink.rowid})' : sqlLink?.clause;
      where ??= whereClause;
      List<MQTTAlarm> list = await read(whereClause: where, orderBy: orderBy);
      for (MQTTAlarm item in list) {
         final SQL.SQLiteLink newLink = SQL.SQLiteLink(rowid: item.rowid, tableName: item.className);
         /// Since read returns a List<>, only the first element is used (should be only one)
         List<MQTTMeta> _mqttmeta = await MQTTMeta.readLink(sqlLink: newLink);
         if (_mqttmeta == null || _mqttmeta.length > 1) throw Exception('Missing data for MQTTMeta');
         item._metta = _mqttmeta[0];

      }
      return list;
   }

   ///- SQLReadRoot Read all linked records based on root-key
   static Future<MQTTAlarm> readRoot({SQL.SQLiteLink sqlLink}) async {
      assert(sqlLink != null);
      String clause = '(rowid = ${sqlLink.rowid})';
      List<MQTTAlarm> list = await readLink(whereClause: clause);
      if (list == null || list.length != 1) throw SQL.SQLiteRecordNotFoundException('Cannot find record: $clause', 400);
      return list[0];
   }

   ///- SQLUpdate update all linked records
   Future<void> updateLink({SQL.SQLiteLink sqlLink}) async {
      await update(link: sqlLink);
         final childLink = SQL.SQLiteLink(rowid:this.rowid, tableName: this.className);
         await metta.updateLink(sqlLink: childLink);

      return null;
   }

   ///- SQLDelete delete all linked records
   Future<void> deleteLink({SQL.SQLiteLink sqlLink}) async {
      await delete(link: sqlLink);
      final childLink = SQL.SQLiteLink(rowid:this.rowid, tableName: className);

      await metta.deleteLink(sqlLink: childLink);
      return null;
   }
   ///- **************** END Sqlite C.R.U.D. for linked records

   ///- **********
   ///- SQLite Create Table
   static Future<dynamic> createTable() async {
       if (!_createTableIfNeeded) return null;
       _createTableIfNeeded = false;
       final create = '''CREATE TABLE IF NOT EXISTS MQTTALARM (
          parentRowid INTEGER DEFAULT 0,
          parentTableName TEXT DEFAULT '',
          originator TEXT,
          originatorId TEXT,
          status TEXT,
          uniqueQualifier TEXT
          )''';

       await SQL.SqliteController.database.execute(create);
       return null;
   }

   //- ******** Helpers
   //- Utility helpers

   ///- SQL Count of records
   ///- Return count of records in MQTTAlarm
  static Future<int> count(String clause) async {
    await createTable();
    final whereClause = (clause == null) ? '' : 'WHERE $clause';
    final sql = 'SELECT COUNT("rowid") FROM MQTTAlarm $whereClause';
    return Sqflite.firstIntValue(await SQL.SqliteController.database.rawQuery(sql));
  }

   ///- SQL First record of query
   ///- Return first record of sql query
  static Future<MQTTAlarm> firstRecord({String where, String orderBy = 'rowid asc limit 1'}) async {
    await createTable();
    if (orderBy == null) throw Exception('static first - orderBy string null');
    List<MQTTAlarm> results = await readLink(whereClause: where, orderBy: orderBy);
    return (results != null && results.length > 0) ? results[0] : null;
  }
}
