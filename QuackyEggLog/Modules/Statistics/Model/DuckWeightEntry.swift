import Foundation

struct DuckWeightEntry: Identifiable {
    let id = UUID()
    let duckId: UUID
    let duckName: String
    let date: Date
    let weight: Double
}
