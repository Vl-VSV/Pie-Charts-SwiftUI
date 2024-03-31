// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

// MARK: - Preview
#Preview {
    ChartView(chartController: ChartController(chartConfigurator: ChartConfigurator(
        chartType: .dynamic,
        chartData: [ChartDataSection(name: "Rent", cost: 500, color: .green),
                    ChartDataSection(name: "Taxi", cost: 1000, color: .red),
                    ChartDataSection(name: "Food", cost: 2000, color: .yellow),
                   ],
        showTitle: true,
        showPercents: false
    )))
}

#Preview {
    ChartView(chartController: ChartController(chartConfigurator: ChartConfigurator(
        chartType: .fixed(innerRadiusFraction: 0.6),
        chartData: [ChartDataSection(name: "Rent", cost: 300, color: .green),
                    ChartDataSection(name: "Taxi", cost: 500, color: .red),
                    ChartDataSection(name: "Food", cost: 1300, color: .yellow),
                   ],
        showTitle: true,
        showPercents: true,
        titleFont: .title.bold(),
        percentFont: .title3,
        backgroundColor: .cyan,
        chartTitleColorType: .fixed(color: .white),
        percentColor: .white,
        formatter: { String(format: "%.2f руб", $0) }
    )))
}
