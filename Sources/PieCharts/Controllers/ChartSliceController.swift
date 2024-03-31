//
//  File.swift
//  
//
//  Created by Vlad V on 31.03.2024.
//

import SwiftUI

final internal class ChartSliceController {
    // MARK: - Properties
    let chartSliceData: ChartSliceData
    
    internal var midRadians: Double {
        return Double.pi / 2.0 - (chartSliceData.startAngle + chartSliceData.endAngle).radians / 2.0
    }
    
    // MARK: - Init
    init(chartSliceData: ChartSliceData) {
        self.chartSliceData = chartSliceData
    }
    
    // MARK: - Functions
    internal func calculateInnerRadius() -> CGFloat {
        let innerRadius = 0.25 + (1 - chartSliceData.percent) * (0.4 - 0.25) / (1 - 0)
        return min(max(innerRadius, 0.25), 0.4)
    }

    internal func calculateTextPosition(_ geometry: GeometryProxy) -> CGPoint {
        let x = geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(midRadians))
        let y = geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(midRadians))
        return CGPoint(x: x, y: y)
    }
}
