//
//  ChartController.swift
//
//
//  Created by Vlad V on 30.03.2024.
//

import SwiftUI

final internal class ChartController: ObservableObject {
    // MARK: - Properties
    @Published var chartConfigurator: ChartConfigurator
    @Published var activeIndex: Int
    
    var slices: [ChartSliceData] {
        let sum = chartConfigurator.chartData.reduce(0) { $0 + $1.cost }
        var endDeg: Double = 0
        var tempSlices: [ChartSliceData] = []
        
        for data in chartConfigurator.chartData {
            let degrees: Double = data.cost * 360 / sum
            tempSlices.append(ChartSliceData(
                startAngle: Angle(degrees: endDeg),
                endAngle: Angle(degrees: endDeg + degrees),
                percent: data.cost / sum,
                color: data.color,
                backgroundColor: chartConfigurator.backgroundColor,
                showPercent: chartConfigurator.showPercents,
                isStatic: isChartStatic(),
                percentColor: chartConfigurator.percentColor,
                percentFont: chartConfigurator.percentFont
            ))
            endDeg += degrees
        }
        return tempSlices
    }

    // MARK: - Init
    init(chartConfigurator: ChartConfigurator) {
        self.chartConfigurator = chartConfigurator
        self.activeIndex = -1
        
        self.sortChartData()
    }

    // MARK: - Functions
    func isChartStatic() -> Bool {
        if case .fixed = chartConfigurator.chartType {
            return true
        }
        return false
    }
    
    private func sortChartData() {
        chartConfigurator.chartData.sort { $0.cost < $1.cost }
    }
}
