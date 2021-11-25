
import 'package:api_check_in/guests/controllers/guests_controller.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/', () => getAllGuests()),
        Route.get('/:id', getGuest),
        //passed json body in request
        Route.post('/', addGuest),
        Route.put('/:id', updateGuest),
        Route.delete('/:id', deleteGuest),
      ];

}
