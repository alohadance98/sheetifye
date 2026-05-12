import 'dart:collection';

class DependencyGraph {
  // Key: Cell that IS depended on. Value: Set of cells that DEPEND ON the key.
  final Map<String, Set<String>> _dependents = {};
  
  // Key: Cell that HAS dependencies. Value: Set of cells that it DEPENDS ON.
  final Map<String, Set<String>> _dependencies = {};

  void updateDependencies(String cellAddress, Set<String> newDependencies) {
    // Clear old dependencies
    final oldDependencies = _dependencies[cellAddress] ?? {};
    for (final dep in oldDependencies) {
      _dependents[dep]?.remove(cellAddress);
    }

    // Add new dependencies
    _dependencies[cellAddress] = newDependencies;
    for (final dep in newDependencies) {
      _dependents.putIfAbsent(dep, () => {}).add(cellAddress);
    }
  }

  List<String> getRecalculationOrder(String startCell) {
    final order = <String>[];
    final visited = <String>{};
    final stack = <String>{};

    void visit(String node) {
      if (stack.contains(node)) {
        throw CircularDependencyException("Circular dependency detected at $node");
      }
      if (!visited.contains(node)) {
        visited.add(node);
        stack.add(node);
        
        final children = _dependents[node] ?? {};
        for (final child in children) {
          visit(child);
        }
        
        stack.remove(node);
        order.insert(0, node);
      }
    }

    visit(startCell);
    // The first item is the startCell itself, which we usually want to skip or handle separately
    return order.reversed.toList();
  }

  Set<String> getAllDependents(String cellAddress) {
    final result = <String>{};
    final queue = Queue<String>()..add(cellAddress);
    
    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      final dependents = _dependents[current] ?? {};
      for (final dep in dependents) {
        if (!result.contains(dep)) {
          result.add(dep);
          queue.add(dep);
        }
      }
    }
    return result;
  }
}

class CircularDependencyException implements Exception {
  final String message;
  CircularDependencyException(this.message);
}
