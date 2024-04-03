// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

// MARK: - Preview
#Preview {
    ChartView(chartConfigurator: ChartConfigurator(
        chartType: .dynamic,
        chartData: [
            ChartDataSection(name: "Rent", value: 1000, color: .green),
            ChartDataSection(name: "Taxi", value: 400, color: .red),
            ChartDataSection(name: "Food", value: 200, color: .yellow),
        ],
        chartGestureType: .hold,
        showTitle: true,
        showPercents: false
    ))
}

#Preview {
    ChartView(chartConfigurator: ChartConfigurator(
        chartType: .fixed(innerRadiusFraction: 0.6),
        chartData: [
            ChartDataSection(name: "Rent", value: 300, color: .green),
            ChartDataSection(name: "Taxi", value: 500, color: .red),
            ChartDataSection(name: "Food", value: 1300, color: .yellow),
        ],
        showTitle: true,
        showPercents: true,
        titleFont: .title.bold(),
        percentFont: .title3,
        chartTitleColorType: .fixed(color: .black),
        percentColor: .white,
        formatter: { ("Sum", String(format: "%.2f руб", $0)) }
    ))
}

#Preview {
    ChartView(
        chartConfigurator:
            ChartConfigurator(
                chartType: .dynamic,
                chartData: [
                    .init(name: "Food", value: 500, color: .red),
                    .init(name: "Taxi", value: 250, color: .blue),
                ],
                showTitle: true,
                showPercents: false
            )
    )
}
