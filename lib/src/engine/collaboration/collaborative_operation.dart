enum OperationType { updateCell, insertRow, deleteRow, mergeCells }

class CollaborativeOperation {
  final String userId;
  final OperationType type;
  final Map<String, dynamic> data;
  final int timestamp;
  final int revision;

  CollaborativeOperation({
    required this.userId,
    required this.type,
    required this.data,
    required this.timestamp,
    required this.revision,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'type': type.name,
    'data': data,
    'timestamp': timestamp,
    'revision': revision,
  };
}

class OperationTransformer {
  CollaborativeOperation transform(
    CollaborativeOperation op,
    CollaborativeOperation concurrentOp,
  ) {
    // Implement OT logic to resolve conflicts
    // e.g., if both insert at same row, shift indexes
    return op;
  }
}
