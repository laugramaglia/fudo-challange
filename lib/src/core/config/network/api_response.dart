class ApiResponse<T> {
  final int statusCode;
  final T? data;

  ApiResponse({required this.statusCode, required this.data});

  @override
  String toString() => 'statusCode=$statusCode\ndata=$data';

  factory ApiResponse.empty() => ApiResponse(
        statusCode: 0,
        data: null,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiResponse &&
        other.statusCode == statusCode &&
        other.data == data;
  }

  @override
  int get hashCode => statusCode.hashCode ^ data.hashCode;
}
