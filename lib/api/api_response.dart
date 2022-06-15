/// Emmagatzema les respostes de l'API
///
/// Entre les respostes hi ha el contigunt [data], l'estat en que es troba
/// la petició [status] i el corresponent missatge [message]
class ApiResponse<T> {
  Status status;
  T data;
  String message = "";

  ApiResponse.loading(this.message, this.data) : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message, this.data) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { loading, completed, error }
