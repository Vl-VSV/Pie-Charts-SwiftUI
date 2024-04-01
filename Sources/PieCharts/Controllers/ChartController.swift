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
        let sum = chartConfigurator.chartData.reduce(0) { $0 + $1.value }
        var endDeg: Double = 0
        var tempSlices: [ChartSliceData] = []
        
        for data in chartConfigurator.chartData {
            let degrees: Double = data.value * 360 / sum
            tempSlices.append(ChartSliceData(
                startAngle: Angle(degrees: endDeg),
                endAngle: Angle(degrees: endDeg + degrees),
                percent: data.value / sum,
                color: data.color,
                showPercent: chartConfigurator.showPercents,
                chartType: chartConfigurator.chartType,
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
    }

    // MARK: - Functions
    func isChartStatic() -> Bool {
        if case .fixed = chartConfigurator.chartType {
            return true
        }
        return false
    }
}
