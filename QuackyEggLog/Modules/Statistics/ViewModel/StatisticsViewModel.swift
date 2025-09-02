import SwiftUI

final class StatisticsViewModel: ObservableObject {
    
    private let realmManager = RealmManager.shared
    private let imageManager = ImageFileManager.shared
    
    @Published var isCloseActiveNavigation = false
    
    @Published private(set) var ducks: [Duck] = []
    @Published private(set) var weightEntries: [DuckWeightEntry] = []
    @Published private(set) var eventEntries: [DuckEventEntry] = []
    
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
                self.generateWeightEntries()
                self.generateEventEntries()
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
    
    private func generateWeightEntries() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let last7Days = (0..<7).compactMap { calendar.date(byAdding: .day, value: -$0, to: today) }
        
        var entries: [DuckWeightEntry] = []
        
        for duck in ducks {
            guard let baseWeight = Double(duck.weight) else { continue }
            
            var hasAnyFeedings = false
            
            for date in last7Days {
                let dayStart = calendar.startOfDay(for: date)
                
                let dayFeedings = duck.feedings.filter {
                    calendar.isDate($0.date, inSameDayAs: dayStart)
                }
                
                let totalFeedingChange = dayFeedings
                    .compactMap { Double($0.quantity) }
                    .reduce(0, +)
                
                if !dayFeedings.isEmpty {
                    let adjustedWeight = baseWeight + totalFeedingChange
                    entries.append(DuckWeightEntry(
                        duckId: duck.id,
                        duckName: duck.name,
                        date: dayStart,
                        weight: adjustedWeight
                    ))
                    hasAnyFeedings = true
                }
            }
            
            if !hasAnyFeedings {
                entries.append(DuckWeightEntry(
                    duckId: duck.id,
                    duckName: duck.name,
                    date: today,
                    weight: baseWeight
                ))
            }
        }
        
        weightEntries = entries
    }
    
    func generateEventEntries() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let last7Days = (0..<7).compactMap {
            calendar.date(byAdding: .day, value: -$0, to: today)
        }

        var entries: [DuckEventEntry] = []

        for duck in ducks {
            let recentEvents = duck.events.filter { event in
                last7Days.contains { calendar.isDate($0, inSameDayAs: event.eventDate) }
            }

            let sortedEvents = recentEvents.sorted { $0.eventDate < $1.eventDate }

            for (index, event) in sortedEvents.enumerated() {
                guard let icon = event.eventType?.icon else { continue }

                let level = min(10 + Double(index) * 15, 95)

                entries.append(DuckEventEntry(
                    duckId: duck.id,
                    duckName: duck.name,
                    date: event.eventDate,
                    iconName: icon,
                    productivity: level
                ))
            }
        }

        eventEntries = entries
    }
}
