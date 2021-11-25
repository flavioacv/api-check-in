import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

FutureOr<Response> getAllEvents() async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
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
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
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
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  print(args.data);
  var password = args.params["password"];
  var salt = 'UVocjgjgXg8P7zIsC93kKlRU8sPbTBhsAMFLnLUPDRYFIWAk';
  var saltedPassword = "$salt$password";
  var bytes = utf8.encode(saltedPassword);
  var hash = sha256.convert(bytes);

  dynamic results = await connection.query("INSERT INTO events"
      " VALUES (DEFAULT,'${args.data["name"]}')");
  await connection.close();
  return Response.ok("Evento inserido");
}

FutureOr<Response> updateEvent(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
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
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results = await connection
      .query("DELETE FROM events WHERE id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok("Evento deletado");
}
