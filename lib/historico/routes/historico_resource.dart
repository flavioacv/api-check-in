import 'dart:async';
import 'package:api_check_in/users/controllers/user_controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/', () => getAllUsers()),
        Route.get('/:id', getUser),
        //passed json body in request
        Route.post('/', addUser),
        Route.put('/:id', updateUser),
        Route.delete('/:id', deleteUser),
      ];

}
