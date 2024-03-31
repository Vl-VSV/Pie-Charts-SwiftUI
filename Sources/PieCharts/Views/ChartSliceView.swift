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
                    path.move(to: center)
                    
                    path.addArc (
                        center: center,
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -90.0) + controller.chartSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + controller.chartSliceData.endAngle,
                        clockwise: false
                    )
                    
                    path.closeSubpath()
                }
                .fill(controller.chartSliceData.color)
                
                if !controller.chartSliceData.isStatic {
                    Path { path in
                        path.move(to: center)
                        
                        path.addArc(
                            center: center,
                            radius: width * controller.calculateInnerRadius(),
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 360),
                            clockwise: false
                        )
                        
                        path.closeSubpath()
                    }
                    .fill(controller.chartSliceData.backgroundColor)
                }
                
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
