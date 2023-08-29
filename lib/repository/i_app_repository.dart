abstract class IAppRepository<T> {
  Future<int> insert(String table, Map<String, Object?> values);
  Future<bool> insertBatch(String table, List<Map<String, Object?>> valueList);
  Future queryAll();
}
