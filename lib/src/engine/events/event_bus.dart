import 'dart:async';

abstract class SheetifyEvent {
  final DateTime timestamp = DateTime.now();
}

class WorkbookMutationEvent extends SheetifyEvent {
  final String action;
  final dynamic details;
  WorkbookMutationEvent(this.action, this.details);
}

class ViewportScrollEvent extends SheetifyEvent {
  final double scrollX;
  final double scrollY;
  ViewportScrollEvent(this.scrollX, this.scrollY);
}

class SheetifyEventBus {
  final _controller = StreamController<SheetifyEvent>.broadcast();

  Stream<T> on<T extends SheetifyEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  void fire(SheetifyEvent event) {
    _controller.add(event);
  }

  void dispose() {
    _controller.close();
  }
}
