//
//  ChartSliceView.swift
//
//
//  Created by Vlad V on 30.03.2024.
//

import SwiftUI

internal struct ChartSliceView: View {
    // MARK: - Properties
    var controller: ChartSliceController
    
    // MARK: - Init
    internal init(chartSliceData: ChartSliceData) {
        self.controller = ChartSliceController(chartSliceData: chartSliceData)
    }
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let center = CGPoint(x: width * 0.5, y: height * 0.5)
                
                Path { path in
                    let startAngle = Angle(degrees: -90.0) + controller.chartSliceData.startAngle
                    let endAngle = Angle(degrees: -90.0) + controller.chartSliceData.endAngle
                    let outerRadius = width * 0.5
                    let innerRadius = width * controller.calculateInnerRadius()
                    
                    let innerEndPoint = CGPoint(x: center.x + CGFloat(cos(endAngle.radians)) * innerRadius, y: center.y + CGFloat(sin(endAngle.radians)) * innerRadius)
                    
                    path.addArc (
                        center: center,
                        radius: outerRadius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false
                    )
                    
                    path.addLine(to: innerEndPoint)
                    
                    path.addArc(
                        center: center,
                        radius: innerRadius,
                        startAngle: endAngle,
                        endAngle: startAngle,
                        clockwise: true
                    )
                    
                    path.closeSubpath()
                }
                .fill(controller.chartSliceData.color)
                
                if controller.chartSliceData.showPercent {
                    let textPosition = controller.calculateTextPosition(geometry)
                    Text(String(format: "%.0f%%", controller.chartSliceData.percent * 100))
                        .position(x: textPosition.x, y: textPosition.y)
                        .foregroundColor(controller.chartSliceData.percentColor)
                        .font(controller.chartSliceData.percentFont)
                }
            } //: ZSTACK
        } //: GEOMETRY
        .aspectRatio(1, contentMode: .fit)
    }
}
