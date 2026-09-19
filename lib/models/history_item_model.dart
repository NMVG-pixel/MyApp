import 'dart:convert';

class HistoryItemModel {
  final String id;
  final String documentId;
  final String documentTitle;
  final DateTime createdAt;
  final Map<String, String> formData;

  const HistoryItemModel({
    required this.id,
    required this.documentId,
    required this.documentTitle,
    required this.createdAt,
    required this.formData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'documentId': documentId,
      'documentTitle': documentTitle,
      'createdAt': createdAt.toIso8601String(),
      'formData': formData,
    };
  }

  factory HistoryItemModel.fromMap(
    Map<String, dynamic> map,
  ) {
    final rawFormData = map['formData'];

    final Map<String, String> convertedFormData = {};

    if (rawFormData is Map) {
      rawFormData.forEach((key, value) {
        convertedFormData[key.toString()] = value.toString();
      });
    }

    return HistoryItemModel(
      id: map['id']?.toString() ?? '',
      documentId: map['documentId']?.toString() ?? '',
      documentTitle: map['documentTitle']?.toString() ?? 'Document',
      createdAt:
          DateTime.tryParse(
            map['createdAt']?.toString() ?? '',
          ) ??
          DateTime.now(),
      formData: convertedFormData,
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory HistoryItemModel.fromJson(
    String source,
  ) {
    return HistoryItemModel.fromMap(
      jsonDecode(source) as Map<String, dynamic>,
    );
  }
}