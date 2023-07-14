// @JsonSerializable()

class DjauError {
  String error = "";

  static String detailField = 'detail';
  static String errorField = 'error';
  static String nonErrorField = 'non_field_errors';

  DjauError(this.error);

  factory DjauError.fromJson(dynamic json) {
    var nonFieldArray = json[nonErrorField] ?? [];
    String non = nonFieldArray.join(',');
    if (non.isNotEmpty) {
      return DjauError(non);
    }

    var errorArray = json[errorField] ?? [];
    String errorText = errorArray.join(',');
    if (errorText.isNotEmpty) {
      return DjauError(errorText);
    }

    String detail = json[detailField] ?? "";
    if (detail.isNotEmpty) return DjauError(detail);

    return DjauError("El servidor retorna error");
  }

  @override
  toString() {
    return error;
  }
}
