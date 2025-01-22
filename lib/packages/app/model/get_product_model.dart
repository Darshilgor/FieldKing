class Product {
  final String documentId; // To store the document ID (e.g., 250, 280)
  final Map<String, Cable> cables; // Cable map for 1MM, 1.5MM, etc.

  Product({required this.documentId, required this.cables});

  // Factory constructor to parse Firestore document data
  factory Product.fromMap(String id, Map<String, dynamic> data) {
    final cables = <String, Cable>{};
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        cables[key] = Cable.fromMap(value);
      }
    });

    return Product(
      documentId: id,
      cables: cables,
    );
  }
}

class Cable {
  final Map<String, Map<String, String>> subCable;

  Cable({required this.subCable});

  // Factory constructor to parse cable map
  factory Cable.fromMap(Map<String, dynamic> data) {
    final subCable = <String, Map<String, String>>{};
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        subCable[key] = Map<String, String>.from(value);
      }
    });

    return Cable(
      subCable: subCable,
    );
  }
}
