import UIKit

final class NutritionViewModel: ObservableObject {
    
    private let realmManager = RealmManager.shared
    private let imageManager = ImageFileManager.shared
    
    @Published var isCloseActiveNavigation = false
    
    @Published private(set) var ducks: [Duck] = []
    
    func loadDucs() {
        Task { @RealmActor [weak self] in
            guard let self else { return }
            
            let objects: [DuckObject] = await realmManager.getAll()
            
            let models: [Duck] = await withTaskGroup(of: Duck?.self) { @RealmActor [weak self] group in
                guard let self else { return [] }
                
                var ducks: [Duck] = []
                
                for object in objects {
                    group.addTask { @RealmActor in
                        if let image = await self.imageManager.retrieveImage(named: object.id.uuidString) {
                            let model = Duck(from: object, and: image)
                            
                            return model
                        } else {
                            return nil
                        }
                    }
                    
                    for await duck in group {
                        if let duck {
                            ducks.append(duck)
                        }
                    }
                }
                
                return ducks
            }
            
            await MainActor.run {
                self.ducks = models
            }
        }
    }
    
    func save(_ duck: Duck) {
        Task { @RealmActor [weak self] in
            guard let self,
                  let image = duck.image,
                  let imagePath = await self.imageManager.storeImage(image, for: duck.id) else { return }
            
            let object = DuckObject(from: duck, and: imagePath)
            
            await self.realmManager.add(object)
            
            await MainActor.run {
                if let index = self.ducks.firstIndex(where: { $0.id == duck.id }) {
                    self.ducks[index] = duck
                } else {
                    self.ducks.append(duck)
                }
                
                self.isCloseActiveNavigation = true
            }
        }
    }
    
    func remove(_ duck: Duck) {
        guard let index = ducks.firstIndex(where: { $0.id == duck.id }) else { return }

        Task { @RealmActor [weak self] in
            guard let self else { return }
            
            let object = DuckObject(from: duck, and: "")
            
            await self.realmManager.delete(DuckObject.self, forPrimaryKey: object.id)
            await self.imageManager.removeImage(for: object.id)
            
            await MainActor.run {
                self.ducks.remove(at: index)
                self.isCloseActiveNavigation = true
            }
        }
    }
}
