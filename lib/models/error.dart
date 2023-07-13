// @JsonSerializable()

class DjauError {
  String detail = "";
  String error = "";

  static String detailField = 'detail';
  static String errorField = 'error';

  DjauError(this.detail, this.error);

  factory DjauError.fromJson(dynamic json) {
    String errorText = json[errorField].join(',') ?? "";
    String detail = json[detailField] ?? "";
    return DjauError(detail, errorText);
  }

  @override
  toString() {
    var errorText = error;
    if (detail.isNotEmpty) {
      errorText = detail;
    }
    return errorText;
  }
}
