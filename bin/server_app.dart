import 'package:api_check_in/app_module.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_modular/shelf_modular.dart';

void main(List<String> arguments) async {
  load();
  final server = await io.serve(Modular(module: AppModule()), env['API_HOST'], int.parse(env['API_POT']));
  print('Server started: ${server.address.address}:${server.port}');
}
