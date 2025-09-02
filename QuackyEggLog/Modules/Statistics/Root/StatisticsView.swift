import SwiftUI

struct StatisticsView: View {
    
    @StateObject private var viewModel = StatisticsViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var isShowEventView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .scaleToFillAndCropp()
                
                VStack(spacing: 16) {
                    navigationView
                    
                    if viewModel.ducks.isEmpty {
                        stumb
                    } else {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 24) {
                                weightChart
                                eventChart
                                eventButton
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 35)
                .padding(.bottom, 96)
                .animation(.easeInOut, value: viewModel.ducks)
                
                NavigationLink(isActive: $isShowEventView) {
                    AddEventListView(ducs: viewModel.ducks)
                } label: {
                    EmptyView()
                }
            }
            .onAppear {
                isShowTabBar = true
                viewModel.loadDucs()
            }
            .onChange(of: viewModel.isCloseActiveNavigation) { isClose in
                if isClose {
                    isShowEventView = false
                    viewModel.isCloseActiveNavigation = false 
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigationView: some View {
        VStack {
            Text("STATISTICS &\nPRODUCTIVITY")
                .font(.brust(with: 35))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .lineLimit(2)
        }
    }
    
    private var stumb: some View {
        Text("You have no data\nyet")
            .frame(maxHeight: .infinity)
            .font(.brust(with: 40))
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
    }
    
    private var weightChart: some View {
        VStack {
            StrokeText("Weight chart", fontSize: 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            MultiDuckWeightChart(data: viewModel.weightEntries)
        }
        .padding(10)
        .background(.white)
        .cornerRadius(18)
    }
    
    private var eventChart: some View {
        VStack {
            StrokeText("ACTIVITY", fontSize: 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            MultiDuckEventChart(data: viewModel.eventEntries)
        }
        .padding(10)
        .background(.white)
        .cornerRadius(18)
    }
    
    private var eventButton: some View {
        Button {
            isShowTabBar = false
            isShowEventView = true
        } label: {
            Image(.Images.baseWood)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 45)
                .overlay {
                    Text("Add event")
                        .font(.brust(with: 25))
                        .foregroundStyle(.white)
                }
        }
    }
}

#Preview {
    StatisticsView(isShowTabBar: .constant(false))
}

import SwiftUI
import Charts

struct MultiDuckEventChart: View {
    let data: [DuckEventEntry]

    var groupedData: [UUID: [DuckEventEntry]] {
        Dictionary(grouping: data, by: { $0.duckId })
    }

    var body: some View {
        Chart {
            ForEach(Array(groupedData.keys), id: \.self) { duckId in
                if let entries = groupedData[duckId],
                   let duckName = entries.first?.duckName {

                    let sorted = entries.sorted { $0.date < $1.date }

                    ForEach(sorted) { entry in
                        LineMark(
                            x: .value("Date", entry.date),
                            y: .value("Productivity", entry.productivity)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(by: .value("Duck", duckName))

                        PointMark(
                            x: .value("Date", entry.date),
                            y: .value("Productivity", entry.productivity)
                        )
                        .annotation(position: .top, alignment: .center) {
                            Image(entry.iconName)
                                .resizable()
                                .frame(width: 10, height: 10)
                        }
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 25, 50, 75, 100]) { val in
                AxisGridLine()
                AxisValueLabel {
                    Text("\(Int(val.as(Double.self) ?? 0))%")
                        .font(.brust(with: 12))
                        .foregroundStyle(.baseDarkGray)
                }
            }
        }
        .chartXAxis {
            let today = Calendar.current.startOfDay(for: Date())
            let last7Days = (0..<7).compactMap {
                Calendar.current.date(byAdding: .day, value: -$0, to: today)
            }.sorted()

            AxisMarks(preset: .aligned, values: last7Days) { value in
                AxisValueLabel {
                    if let date = value.as(Date.self) {
                        Text(date.formatted(.dateTime.day().month(.twoDigits)))
                            .font(.brust(with: 11))
                            .foregroundStyle(.baseDarkGray)
                    }
                }
            }
        }
        .chartYScale(domain: 0...100)
        .frame(height: 250)
        .padding()
    }
}
