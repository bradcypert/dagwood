import 'dart:io';
import 'package:http_server/http_server.dart';

Future serveFiles(List<String> arguments) async {
  if (arguments[1] == '--help') {
    print('''
      serve
      --------
      serves your already built dagwood app so that its accessible on your local network.
      --------
      options
      - port (default: 8080)
      --------
      examples
      - Serve your built dagwood site on port 4000
        dagwood serve --port=4000
    ''');

    return Future.value(true);
  }

  var flagIndex = arguments.indexWhere((element) => element.contains('--'));
  var flags = {};
  if (flagIndex > 0) {
    flags = arguments
        .sublist(flagIndex)
        .join(' ')
        .split('--')
        .where((element) => element != '')
        .fold({}, (acc, element) {
      var kv = element.split('=');
      acc[kv[0]] = kv[1];
      return acc;
    });
  }

  var staticFiles = VirtualDirectory('build');
  staticFiles.allowDirectoryListing = true;
  staticFiles.directoryHandler = (dir, request) {
    var indexUri = Uri.file(dir.path).resolve('index.html');
    staticFiles.serveFile(File(indexUri.toFilePath()), request);
  };

  var port = int.parse(flags['port']) ?? 8080;

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  print('Listening on port ${port}');
  await server.forEach(staticFiles.serveRequest);
}
