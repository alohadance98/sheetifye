import 'dart:async';

abstract class SheetifyeEvent {
  final DateTime timestamp = DateTime.now();
}

class WorkbookMutationEvent extends SheetifyeEvent {
  final String action;
  final dynamic details;
  WorkbookMutationEvent(this.action, this.details);
}

class ViewportScrollEvent extends SheetifyeEvent {
  final double scrollX;
  final double scrollY;
  ViewportScrollEvent(this.scrollX, this.scrollY);
}

class SheetifyeEventBus {
  final _controller = StreamController<SheetifyeEvent>.broadcast();

  Stream<T> on<T extends SheetifyeEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  void fire(SheetifyeEvent event) {
    _controller.add(event);
  }

  void dispose() {
    _controller.close();
  }
}
