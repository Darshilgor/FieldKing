// class Product {
//   final String documentId; // This comes from the Firestore field
//   final Map<String, Cable> cables; // Cable map for 1MM, 1.5MM, etc.

//   Product({required this.documentId, required this.cables});

//   factory Product.fromMap(Map<String, dynamic> data) {
//     final docId = data['documentId'] as String? ?? '';

//     final cables = <String, Cable>{};
//     data.forEach((key, value) {
//       if (key != 'documentId' && value is Map<String, dynamic>) {
//         cables[key] = Cable.fromMap(value);
//       }
//     });

//     return Product(
//       documentId: docId,
//       cables: cables,
//     );
//   }
// }

// class Cable {
//   final Map<String, Map<String, String>> subCable;

//   Cable({required this.subCable});

//   factory Cable.fromMap(Map<String, dynamic> data) {
//     final subCable = <String, Map<String, String>>{};
//     data.forEach((key, value) {
//       if (value is Map<String, dynamic>) {
//         subCable[key] = value.map((subKey, subValue) =>
//             MapEntry(subKey, subValue.toString()));
//       }
//     });

//     return Cable(
//       subCable: subCable,
//     );
//   }
// }

class Product {
  final String documentId; // The Firestore document ID
  final Map<String, Cable> cables; // Map for "1MM", "1.5MM", etc.

  Product({required this.documentId, required this.cables});

  factory Product.fromMap(String documentId, Map<String, dynamic> data) {
    final cables = <String, Cable>{};
    if (data['cable'] is Map<String, dynamic>) {
      (data['cable'] as Map<String, dynamic>).forEach((key, value) {
        if (value is Map<String, dynamic>) {
          cables[key] = Cable.fromMap(value);
        }
      });
    }

    return Product(
      documentId: documentId,
      cables: cables,
    );
  }
}

class Cable {
  final Map<String, SubCable>? cableType;

  Cable({  this.cableType});

  factory Cable.fromMap(Map<String, dynamic> data) {
    final subCables = <String, SubCable>{};
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        subCables[key] = SubCable.fromMap(value);
      }
    });

    return Cable(cableType: subCables);
  }
}

class SubCable {
  final String? name;
  final String? price;
  final String? amp;
  final String? chipestPrice;
  final String? gej;

  SubCable({
      this.name,
      this.price,
       this.amp,
       this.chipestPrice,
      this.gej,
  });

  factory SubCable.fromMap(Map<String, dynamic> data) {
    return SubCable(
      name: data['name'] ?? 'Unknown',
      price: data['price'] ?? '0',
      amp: data['amp'] ?? '',
      chipestPrice: data['chipestPrice'],
      gej: data['gej'],
    );
  }
}
