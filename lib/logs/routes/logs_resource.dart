import 'dart:async';
import 'package:api_check_in/logs/controllers/logs_controller.dart';
import 'package:api_check_in/users/controllers/user_controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/', () => getAllLogs()),
        Route.get('/:id', getLogs),
        //passed json body in request
        Route.post('/', addLog),
        Route.put('/:id', updateLog),
        Route.delete('/:id', deleteLog),
      ];

}
