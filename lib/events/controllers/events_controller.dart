import 'dart:async';
import 'dart:convert';
import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

FutureOr<Response> getAllEvents() async {
   var connection = await PostgreSQLConnection(env['DB_HOST'], int.parse(env['DB_PORT']), env['DB_NAME'],
      username: env["DB_USER"], password: env["DB_PASS"]);
  await connection.open();
  List<List<dynamic>> results =
      await connection.query("SELECT  id,name FROM events ");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok(jsonEncode(results));
}

FutureOr<Response> getEvent(ModularArguments args) async {
 var connection = await PostgreSQLConnection(env['DB_HOST'], int.parse(env['DB_PORT']), env['DB_NAME'],
      username: env["DB_USER"], password: env["DB_PASS"]);
  await connection.open();
  List<List<dynamic>> results = await connection.query(
      "SELECT id,name FROM events where id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok(jsonEncode(results));
}

FutureOr<Response> addEvent(ModularArguments args) async {
  var connection = await PostgreSQLConnection(env['DB_HOST'], int.parse(env['DB_PORT']), env['DB_NAME'],
      username: env["DB_USER"], password: env["DB_PASS"]);
  await connection.open();
  dynamic results = await connection.query("INSERT INTO events"
      " VALUES (DEFAULT,'${args.data["name"]}')");
  await connection.close();
  return Response.ok("Evento inserido");
}

FutureOr<Response> updateEvent(ModularArguments args) async {
 var connection = await PostgreSQLConnection(env['DB_HOST'], int.parse(env['DB_PORT']), env['DB_NAME'],
      username: env["DB_USER"], password: env["DB_PASS"]);
  await connection.open();
  List<List<dynamic>> results = await connection.query(
      "UPDATE events SET name = '${args.data["name"]}' where id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok("Evento atualizado");
}

FutureOr<Response> deleteEvent(ModularArguments args) async {
 var connection = await PostgreSQLConnection(env['DB_HOST'], int.parse(env['DB_PORT']), env['DB_NAME'],
      username: env["DB_USER"], password: env["DB_PASS"]);
  await connection.open();
  List<List<dynamic>> results = await connection
      .query("DELETE FROM events WHERE id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok("Evento deletado");
}
