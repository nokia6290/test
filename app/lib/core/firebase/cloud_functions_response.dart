typedef CloudFunctionsResponseSuccessCallback<T> = T Function(
  Map<String, dynamic> data,
);
typedef CloudFunctionsResponseFailureCallback<T> = T Function(
  String error,
);

sealed class CloudFunctionsResponse {
  CloudFunctionsResponse.success({
    required this.functionName,
    required this.status,
    required Map<String, dynamic> data,
  })  : _data = data,
        _error = null;

  CloudFunctionsResponse.failure({
    required this.functionName,
    required this.status,
    required String error,
  })  : _data = null,
        _error = error;

  factory CloudFunctionsResponse.fromJson(
    String functionName,
    Map<String, dynamic> json,
  ) {
    final status = json['status'] as int;

    if (status >= 200 && status < 300) {
      // Success
      return CloudFunctionsResponseSuccess(
        functionName: functionName,
        status: status,
        data: Map<String, dynamic>.from(json['data'] as Map<dynamic, dynamic>),
      );
    }

    // Error
    return CloudFunctionsResponseFailure(
      functionName: functionName,
      status: status,
      error: json['error'] as String,
    );
  }

  final String functionName;
  final int status;
  final Map<String, dynamic>? _data;
  final String? _error;

  T when<T>({
    required CloudFunctionsResponseSuccessCallback<T> success,
    required CloudFunctionsResponseFailureCallback<T> error,
  }) {
    final t = this;
    return switch (t) {
      CloudFunctionsResponseSuccess() => success(t.data),
      CloudFunctionsResponseFailure() => error(t.error),
    };
  }

  @override
  String toString() {
    return '$runtimeType{functionName: $functionName, status: $status, '
        '_data: $_data, _error: $_error}';
  }
}

class CloudFunctionsResponseSuccess extends CloudFunctionsResponse {
  CloudFunctionsResponseSuccess({
    required super.functionName,
    required super.status,
    required super.data,
  }) : super.success();

  Map<String, dynamic> get data => _data!;
}

class CloudFunctionsResponseFailure extends CloudFunctionsResponse {
  CloudFunctionsResponseFailure({
    required super.functionName,
    required super.status,
    required super.error,
  }) : super.failure();

  CloudFunctionsResponseFailure.internalError({
    required super.functionName,
  }) : super.failure(status: 500, error: 'internal-error');

  String get error => _error!;
}

extension CloudFunctionsResponseExtension on Future<CloudFunctionsResponse> {
  Future<bool> toSuccessBool() {
    return then(
      (value) => value.when(
        success: (_) => true,
        error: (_) => false,
      ),
    );
  }
}
