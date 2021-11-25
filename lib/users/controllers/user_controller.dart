import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserController {
  final connection = PostgreSQLConnection(
      env['DB_HOST'], int.parse(env['DB_PORT']), env['DB_NAME'],
      username: env["DB_USER"], password: env["DB_PASS"]);

  FutureOr<Response> getAllUsers() async {
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
    await connection.open();
    print(args.data);
    var password = args.params["password"];
    var salt = env["API_SECRET"];
    var saltedPassword = "$salt$password";
    var bytes = utf8.encode(saltedPassword);
    var hash = sha256.convert(bytes);

    dynamic results = await connection.query("INSERT INTO users"
        " VALUES (DEFAULT,'${args.data["name"]}', '${args.data["email"]}', '$hash')");
    await connection.close();
    return Response.ok("Usuario inserido");
  }

  FutureOr<Response> updateUser(ModularArguments args) async {
    await connection.open();
    List<List<dynamic>> results = await connection.query(
        "UPDATE users SET name = '${args.data["name"]}' where id = @${args.params.values}");
    for (final row in results) {
      print(row);
    }
    await connection.close();
    return Response.ok("Usuario atualizado");
  }

  FutureOr<Response> deleteUser(ModularArguments args) async {
    await connection.open();
    List<List<dynamic>> results = await connection
        .query("DELETE FROM users WHERE id = @${args.params.values}");
    for (final row in results) {
      print(row);
    }
    await connection.close();
    return Response.ok("Usuario deletado");
  }
}
