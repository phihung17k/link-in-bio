abstract class IAppRepository<T> {
  Future<bool> initData();
  Future<List<Map<String, Object?>>> queryAll(String table, {String? orderBy});
  Future<int> insert(String table, Map<String, Object?> values);
  Future<bool> insertBatch(String table, List<Map<String, Object?>> valueList);
  Future<Map<String, Object?>> queryFromId(String table, int id);
  Future<bool> delete(String table, int id);
  Future<int> update(String table, Map<String, Object?> values);
  Future<bool> reorder(String table, Map<int, int> idOrdinalMap);
}
