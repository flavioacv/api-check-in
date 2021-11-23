import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

FutureOr<Response> getAllUsers() async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results =
      await connection.query("SELECT  id,name,email FROM users ");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok(jsonEncode(results));
}

FutureOr<Response> getUser(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  List<List<dynamic>> results = await connection.query(
      "SELECT id,name,email FROM users where id = @${args.params.values}");
  for (final row in results) {
    print(row);
  }
  await connection.close();
  return Response.ok(jsonEncode(results));
}

FutureOr<Response> addUser(ModularArguments args) async {
  var connection = await PostgreSQLConnection("localhost", 5432, "checkin",
      username: "postgres", password: "root");
  await connection.open();
  print(args.data);
  var password = args.params["password"];
  var salt = 'UVocjgjgXg8P7zIsC93kKlRU8sPbTBhsAMFLnLUPDRYFIWAk';
  var saltedPassword = "$salt$password";
  var bytes = utf8.encode(saltedPassword);
  var hash = sha256.convert(bytes);

  dynamic results =
      await connection.query("INSERT INTO users"
      " VALUES (DEFAULT,'${args.data["name"]}', '${args.data["email"]}', '$hash')");
  await connection.close();
  return Response.ok("Usuario inserido");
}

FutureOr<Response> updateUser(ModularArguments args) =>
    Response.ok('Updated user id ${args.params['id']}');

FutureOr<Response> deleteUser(ModularArguments args) =>
    Response.ok('Deleted user id ${args.params['id']}');
