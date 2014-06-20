library worker.test.construction;

import 'dart:io';
import 'package:worker/worker.dart';
import 'package:unittest/unittest.dart';

void constructionTest() {
  // The default number of processors the Worker starts with
  final numberOfProcessors = 1;
  
  group('Worker construction:', () {
    Worker worker;

    test('with empty constructor', () {
      worker = new Worker();
      expect(worker.poolSize, equals(numberOfProcessors));
      expect(worker.isolates, isEmpty);
      expect(worker.availableIsolates, isEmpty);
      expect(worker.workingIsolates, isEmpty);
      worker.close();
    });

    test('with poolSize parameter constructor', () {
      int poolSize = Platform.numberOfProcessors;
      worker = new Worker(poolSize: poolSize);
      expect(worker.poolSize, equals(poolSize));
      expect(worker.isolates, isEmpty);
      expect(worker.availableIsolates, isEmpty);
      expect(worker.workingIsolates, isEmpty);
      worker.close();
    });

    test('with spawnLazily parameter constructor', () {
      worker = new Worker(spawnLazily: false);
      expect(worker.poolSize, equals(numberOfProcessors));
      expect(worker.isolates, hasLength(numberOfProcessors));
      expect(worker.availableIsolates, hasLength(numberOfProcessors));
      expect(worker.workingIsolates, isEmpty);
      worker.close();
    });

    test('with poolSize and spawnLazily parameters constructor', () {
      int poolSize = Platform.numberOfProcessors;
      worker = new Worker(poolSize: poolSize, spawnLazily: false);
      expect(worker.poolSize, poolSize);
      expect(worker.isolates, hasLength(poolSize));
      expect(worker.availableIsolates, hasLength(poolSize));
      expect(worker.workingIsolates, isEmpty);
      worker.close();
    });
  });
}