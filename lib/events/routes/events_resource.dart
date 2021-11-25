import 'dart:async';

import 'package:api_check_in/events/controllers/events_controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/', () => getAllEvents()),
        Route.get('/:id', getEvent),
        //passed json body in request
        Route.post('/', addEvent),
        Route.put('/:id', updateEvent),
        Route.delete('/:id', deleteEvent),
      ];

}
