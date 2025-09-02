import Foundation
import RealmSwift

final class RealmManager: ObservableObject {
    
    static let shared = RealmManager()
    
    private var realm: Realm?
    
    private init() {
        Task {
            await configureRealm()
        }
    }
    
    @RealmActor
    private func configureRealm() async {
        do {
            realm = try await Realm(actor: RealmActor.shared)
        } catch {
            print("🛑 Failed to configure Realm: \(error)")
        }
    }
        
    @RealmActor
    func add<T: Object>(_ object: T) async {
        guard let realm else {
            print("🛑 Realm not initialized")
            return
        }
        
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print("🛑 Failed to add object: \(error)")
        }
    }
    
    @RealmActor
    func getAll<T: Object>() async -> [T] {
        while realm == nil {
            await Task.yield()
        }
        
        guard let realm else {
            print("🛑 Realm not initialized")
            return []
        }
        
        return Array(realm.objects(T.self))
    }
    
    @RealmActor
    func delete<T: Object>(_ type: T.Type, forPrimaryKey key: UUID) async {
        guard let realm else {
            print("🛑 Realm not initialized")
            return
        }
        
        guard let object = realm.object(ofType: type, forPrimaryKey: key) else {
            print("⚠️ Object not found for key: \(key)")
            return
        }
        
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("🛑 Failed to delete object: \(error)")
        }
    }
    
    @RealmActor
    func deleteAll() async {
        guard let realm else {
            print("🛑 Realm not initialized")
            return
        }
        
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("🛑 Failed to delete all objects: \(error)")
        }
    }
}
