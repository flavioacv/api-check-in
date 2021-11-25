import 'dart:async';
import 'dart:convert';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

FutureOr<Response> getAllGuests() async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results =
      await connection.query("SELECT  id,name,cpf,phone, id_event FROM guests ");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok(jsonEncode(results));
}

FutureOr<Response> getGuest(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results = await connection
      .query("SELECT id,name,cpf,phone, id_event FROM guests where id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok(jsonEncode(results));
}

FutureOr<Response> addGuest(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  dynamic results = await connection.query("INSERT INTO guests"
      " VALUES (DEFAULT,'${args.data["name"]}', '${args.data["cpf"]}', '${args.data["phone"]}', '${args.data["id_event"]}')");
  await connection.close();
  return Response.ok("Convidado inserido");
}

FutureOr<Response> updateGuest(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results = await connection.query(
      "UPDATE guests SET name = '${args.data["name"]}', name = '${args.data["cpf"]}' ,name = '${args.data["phone"]}' ,name = '${args.data["id_event"]}' where id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok("Convidado atualizado");
}

FutureOr<Response> deleteGuest(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results = await connection
      .query("DELETE FROM guests WHERE id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok("Convidado deletado");
}
