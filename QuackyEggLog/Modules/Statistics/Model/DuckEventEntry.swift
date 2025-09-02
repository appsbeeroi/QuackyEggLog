import UIKit

struct DuckEventEntry: Identifiable {
    let id = UUID()
    let duckId: UUID
    let duckName: String
    let date: Date
    let iconName: ImageResource
    let productivity: Double
}
