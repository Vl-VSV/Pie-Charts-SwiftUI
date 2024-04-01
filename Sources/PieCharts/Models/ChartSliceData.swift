//
//  ChartSliceData.swift
//
//
//  Created by Vlad V on 30.03.2024.
//

import SwiftUI

internal struct ChartSliceData {
    let startAngle: Angle
    let endAngle: Angle
    let percent: Double
    let color: Color
    
    let showPercent: Bool
    let chartType: ChartType
    
    let percentColor: Color
    let percentFont: Font
    
}
