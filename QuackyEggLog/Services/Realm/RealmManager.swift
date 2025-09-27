import Foundation

final class RealmManager: ObservableObject {
    
    static let shared = RealmManager()
    
    private let defaults = UserDefaults.standard
    private let storageKey = "RealmManagerStorage"
    
    private init() {}
    
    // MARK: - Add
    
    func add<T: Codable & Identifiable>(_ object: T) async {
        var currentObjects = await getAll(T.self)
        
        // Если объект с таким же id есть, обновляем
        if let index = currentObjects.firstIndex(where: { $0.id == object.id }) {
            currentObjects[index] = object
        } else {
            currentObjects.append(object)
        }
        
        save(currentObjects)
    }
    
    // MARK: - Get All
    
    func getAll<T: Codable & Identifiable>(_ type: T.Type) async -> [T] {
        guard let data = defaults.data(forKey: "\(storageKey)_\(String(describing: T.self))") else {
            return []
        }
        
        do {
            let decoded = try JSONDecoder().decode([T].self, from: data)
            return decoded
        } catch {
            print("🛑 Failed to decode objects: \(error)")
            return []
        }
    }
    
    // MARK: - Delete
    
    func delete<T: Codable & Identifiable>(_ type: T.Type, forPrimaryKey key: T.ID) async {
        var currentObjects = await getAll(T.self)
        currentObjects.removeAll { $0.id == key }
        save(currentObjects)
    }
    
    func deleteAll<T: Codable & Identifiable>(_ type: T.Type) async {
        defaults.removeObject(forKey: "\(storageKey)_\(String(describing: T.self))")
    }
    
    // MARK: - Private Save
    
    private func save<T: Codable & Identifiable>(_ objects: [T]) {
        do {
            let data = try JSONEncoder().encode(objects)
            defaults.set(data, forKey: "\(storageKey)_\(String(describing: T.self))")
        } catch {
            print("🛑 Failed to save objects: \(error)")
        }
    }
}
