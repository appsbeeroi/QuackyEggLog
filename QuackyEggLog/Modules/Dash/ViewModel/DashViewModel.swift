import Foundation

final class DashViewModel: ObservableObject {
    
    private let realmManager = RealmManager.shared
    
    @Published private(set) var currentItem = DuckDashItem()
    @Published private(set) var favorites: [DuckDashItem] = []
    
    init() {
        loadFavorites()
    }
    
    func changeFavoriteStatus(of item: DuckDashItem) {
        var newItem = item
        
        newItem.isFavorite.toggle()
        currentItem.isFavorite.toggle()
        
        Task { @RealmActor [weak self] in
            guard let self else { return }
            
            let object = DuckDashObject(from: newItem)
            let newModel = newItem

            if newItem.isFavorite {
                await realmManager.add(object)
            } else {
                await realmManager.delete(DuckDashObject.self, forPrimaryKey: object.uuid)
            }
        
            await MainActor.run {
                if let index = self.favorites.firstIndex(of: item) {
                    self.favorites.remove(at: index)
                } else {
                    self.favorites.append(newModel)
                }
            }
        }
    }
    
    func loadFavorites() {
        Task{ @RealmActor [weak self] in
            guard let self else { return }
            
            let objects: [DuckDashObject] = await realmManager.getAll()
            let models = objects.map { DuckDashItem(from: $0) }
            
            await MainActor.run {
                self.favorites = models
                self.showRandomFact()
            }
        }
    }
    
    private func showRandomFact() {
        guard var fact = items.randomElement() else { return }
        
        if favorites.contains(where: { $0.id == fact.id }) {
            fact.isFavorite = true
        }
        
        currentItem = fact
    }
}

fileprivate let items: [DuckDashItem] = [
    DuckDashItem(id: "1", type: .fact, text: "Ducks can sleep with one eye open. So don’t be surprised if Quack is watching you even while napping."),
    DuckDashItem(id: "2", type: .fact, text: "Ducks can take up to 2000 steps a day — without a fitness tracker!"),
    DuckDashItem(id: "3", type: .fact, text: "Bread isn’t the best breakfast for ducks. They prefer grains and greens."),
    DuckDashItem(id: "4", type: .advice, text: "If Plump hides in the water, she’s just enjoying her VIP-style relaxation."),
    DuckDashItem(id: "5", type: .advice, text: "Introduce new types of feed gradually, or your duck might stage a protest quack."),
    DuckDashItem(id: "6", type: .advice, text: "Bathing water is like a spa for your duck. Do it at least once a week."),
    DuckDashItem(id: "7", type: .fact, text: "Ducks can turn their heads almost 360° to see everything around them."),
    DuckDashItem(id: "8", type: .advice, text: "Clean water containers regularly — nobody likes drinking dirty water, not even ducks!"),
    DuckDashItem(id: "9", type: .fact, text: "Ducks communicate with quacks, whistles, and chirps — each has a unique voice."),
    DuckDashItem(id: "10", type: .advice, text: "For a productive duck, provide shade and a sunny spot for rest.")
]
