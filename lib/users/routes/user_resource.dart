
import 'package:api_check_in/users/controllers/user_controller.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/', () => UserController().getAllUsers()),
        Route.get('/:id', UserController().getUser),
        //passed json body in request
        Route.post('/', UserController().addUser),
        Route.put('/:id', UserController().updateUser),
        Route.delete('/:id', UserController().deleteUser),
      ];
}
