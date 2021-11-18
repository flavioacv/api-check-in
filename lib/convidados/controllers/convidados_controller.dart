import 'dart:async';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

FutureOr<Response> getAllUsers() => Response.ok('All users');

FutureOr<Response> getUser(ModularArguments args) =>
    Response.ok('user id ${args.params['id']}');

FutureOr<Response> addUser(ModularArguments args) =>
    Response.ok('New user added: ${args.data}');

FutureOr<Response> updateUser(ModularArguments args) =>
    Response.ok('Updated user id ${args.params['id']}');
    
FutureOr<Response> deleteUser(ModularArguments args) =>
    Response.ok('Deleted user id ${args.params['id']}');
