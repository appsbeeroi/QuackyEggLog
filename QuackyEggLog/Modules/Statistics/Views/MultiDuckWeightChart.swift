import SwiftUI
import Charts

struct MultiDuckWeightChart: View {
    
    let data: [DuckWeightEntry]
    
    var groupedData: [UUID: [DuckWeightEntry]] {
        Dictionary(grouping: data, by: { $0.duckId })
    }
    
    var body: some View {
        let maxWeight = (data.map(\.weight).max() ?? 0)
        let yMax = maxWeight * 1.2

        Chart {
            ForEach(Array(groupedData.keys), id: \.self) { duckId in
                if let entries = groupedData[duckId],
                   let duckName = entries.first?.duckName {

                    let sortedEntries = entries.sorted { $0.date < $1.date }

                    ForEach(sortedEntries) { entry in
                        LineMark(
                            x: .value("Date", entry.date),
                            y: .value("Weight", entry.weight)
                        )
                        .symbol(by: .value("Duck", duckName))
                        .foregroundStyle(by: .value("Duck", duckName))
                    }
                }
            }
        }
        .chartYAxis {
            let safeMax = max(yMax, 1)
            let step = safeMax * 0.25
            let steps = Array(stride(from: 0, through: safeMax, by: step))

            AxisMarks(position: .leading, values: steps) { value in
                AxisGridLine()
                AxisValueLabel {
                    Text("\(Int(value.as(Double.self) ?? 0))")
                        .font(.brust(with: 12))
                        .foregroundStyle(.baseDarkGray)
                }
            }
        }
        .chartXAxis {
            AxisMarks(preset: .aligned, values: .automatic(desiredCount: 7)) { value in
                AxisValueLabel {
                    if let date = value.as(Date.self) {
                        Text(date.formatted(.dateTime.day().month(.twoDigits)))
                            .font(.brust(with: 11))
                            .foregroundStyle(.baseDarkGray)
                    }
                }
            }
        }
        .chartYScale(domain: 0...yMax)
        .frame(height: 250)
        .padding()
    }
}
