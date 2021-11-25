import 'dart:async';
import 'dart:convert';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

FutureOr<Response> getAllLogs() async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results = await connection
      .query("SELECT  id,date_log,id_guest, id_event FROM logs ");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok(jsonEncode(results));
}

FutureOr<Response> getLogs(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results = await connection.query(
      "SELECT id,date_log,id_guest, id_event FROM logs where id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok(jsonEncode(results));
}

FutureOr<Response> addLog(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  dynamic results = await connection.query("INSERT INTO logs"
      " VALUES (DEFAULT,'${args.data["date_log"]}', '${args.data["id_guest"]}', '${args.data["id_event"]}')");
  await connection.close();
  return Response.ok("LOG inserido");
}

FutureOr<Response> updateLog(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results = await connection.query(
      "UPDATE logs SET date_log = '${args.data["date_log "]}', id_guest = '${args.data["id_guest"]}' ,id_event = '${args.data["id_event"]}' where id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok("LOG atualizado");
}

FutureOr<Response> deleteLog(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results = await connection
      .query("DELETE FROM logs WHERE id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok("LOG deletado");
}
