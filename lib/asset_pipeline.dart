import 'package:dagwood/asset.dart';
import 'package:dagwood/content_writeable_writer.dart';
import 'package:sass/sass.dart' as sass;

class AssetPipeline {
  static Asset processAsset(Asset asset) {
    if (asset.status == AssetStatus.Processed) {
      print(
          'Warning: re-processing an already processed asset: ${asset.file.path}');
    }

    switch (asset.assetType) {
      case AssetType.Style:
        asset.contents =
            sass.compile(asset.file.path, style: sass.OutputStyle.compressed);
        break;

      case AssetType.Other:
        asset.contents = asset.file.readAsStringSync();
        break;
    }

    asset.status = AssetStatus.Processed;
    return asset;
  }

  static void writeAsset(Asset asset) {
    if (asset.status != AssetStatus.Processed) {
      print(
          'Warning: writing unprocessed asset to disc. This may be intentional but is unlikely: ${asset.file.path}');
    }

    var path = asset.file.path;
    if (asset.assetType == AssetType.Style) {
      print(path);
      path = path.replaceFirst(RegExp(r'[^.]+$'), 'css');
    }

    ContentWriteableWriter.write(asset, outputFilename: path);
  }
}
