//
//  ChartSliceView.swift
//
//
//  Created by Vlad V on 30.03.2024.
//

import SwiftUI

struct ChartSliceView: View {
    @Binding var activeIndex: Int
    var controller: ChartSliceController
    
    init(activeIndex: Binding<Int>, chartSliceData: ChartSliceData) {
        self._activeIndex = activeIndex
        self.controller = ChartSliceController(chartSliceData: chartSliceData)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let path = createPath(geometry: geometry)
                path.fill(controller.chartSliceData.color)
                
                if controller.chartSliceData.showPercent {
                    Text(String(format: "%.0f%%", controller.chartSliceData.percent * 100))
                        .position(controller.calculateTextPosition(geometry))
                        .foregroundColor(controller.chartSliceData.percentColor)
                        .font(controller.chartSliceData.percentFont)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func createPath(geometry: GeometryProxy) -> Path {
        let width = min(geometry.size.width, geometry.size.height)
        let height = width
        let center = CGPoint(x: width * 0.5, y: height * 0.5)
        
        var path = Path()
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
        
        return path
    }
}
