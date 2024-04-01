//
//  ChartConfigurator.swift
//
//
//  Created by Vlad V on 30.03.2024.
//

import SwiftUI

// MARK: - Chart Type
public enum ChartType {
    case fixed(innerRadiusFraction: CGFloat)
    case dynamic
}

// MARK: - Chart Title Color Type
public enum ChartTitleColorType {
    case fixed(color: Color)
    case dynamic(defaultColor: Color)
}

// MARK: - Chart Gesture Type
public enum ChartGestureType {
    case tap
    case hold
}

// MARK: - Chart Data Section
public struct ChartDataSection {
    let name: String
    let value: Double
    let color: Color
    
    // MARK: - Init
    public init(name: String, cost: Double, color: Color) {
        self.name = name
        self.value = cost
        self.color = color
    }
}

// MARK: - Chart Configurator
public struct ChartConfigurator {
    let chartType: ChartType
    var chartData: [ChartDataSection]
    
    let chartGestureType: ChartGestureType = .hold // Пока tap не реализовано
    
    var showTitle: Bool
    var showPercents: Bool
    
    var titleFont: Font
    var percentFont: Font
    
    var chartTitleColorType: ChartTitleColorType
    var percentColor: Color
    
    var formatter: (Double) -> String
    
    // MARK: - Init
    public init(chartType: ChartType,
                chartData: [ChartDataSection],
                showTitle: Bool,
                showPercents: Bool,
                titleFont: Font = .title,
                percentFont: Font = .body,
                chartTitleColorType: ChartTitleColorType = .dynamic(defaultColor: .black),
                percentColor: Color = .black,
                formatter: @escaping (Double) -> String = { String(format: "%.2f $", $0) }) {
        self.chartType = chartType
        self.chartData = chartData
        self.showTitle = showTitle
        self.showPercents = showPercents
        self.titleFont = titleFont
        self.percentFont = percentFont
        self.chartTitleColorType = chartTitleColorType
        self.percentColor = percentColor
        self.formatter = formatter
    }
}
