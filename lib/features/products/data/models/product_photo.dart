enum PhotoStatus { ready, uploading, error }

class ProductPhoto {
  final String? localPath;
  final String? url;
  final PhotoStatus status;

  const ProductPhoto({this.localPath, this.url, this.status = PhotoStatus.ready})
    : assert(
        localPath != null || url != null,
      );
}
