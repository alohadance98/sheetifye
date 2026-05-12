import 'dart:isolate';

abstract class SpreadsheetWorkerRequest {
  final String id;
  SpreadsheetWorkerRequest(this.id);
}

abstract class SpreadsheetWorkerResponse {
  final String id;
  SpreadsheetWorkerResponse(this.id);
}

class SpreadsheetWorker {
  static Future<T> runInBackground<T>(T Function() computation) async {
    return Isolate.run(computation);
  }

  // More complex worker pool architecture for streaming XLSX etc.
  Future<void> spawnWorker() async {
    // Isolate.spawn implementation for long-running workers
  }
}
