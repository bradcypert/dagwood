import './build.dart' as build;
import './create.dart' as create;
import './new.dart' as new_item;
import './help.dart' as help;
import './serve.dart' as serve;

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    help.printHelp();
  }

  var action = arguments[0];
  switch (action) {
    case 'new':
      new_item.newItem(arguments);
      break;
    case 'create':
      create.create(arguments);
      break;
    case 'build':
      build.build(arguments);
      break;
    case 'serve':
      serve.serveFiles(arguments);
      break;
    case 'help':
      help.printHelp();
      break;
    default:
      print('Available commands are create, build and help');
      break;
  }
}
