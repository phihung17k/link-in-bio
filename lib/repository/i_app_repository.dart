abstract class IAppRepository<T> {
  Future<List<Map<String, Object?>>> queryAll(String table);
  Future<int> insert(String table, Map<String, Object?> values);
  Future<bool> insertBatch(String table, List<Map<String, Object?>> valueList);
}
