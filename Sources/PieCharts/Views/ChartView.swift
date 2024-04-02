//
//  SwiftUIView.swift
//  
//
//  Created by Vlad V on 30.03.2024.
//

import SwiftUI

// MARK: - Chart View

public struct ChartView: View {
    @ObservedObject var controller: ChartController
    
    public init(chartConfigurator: ChartConfigurator) {
        self.controller = ChartController(chartConfigurator: chartConfigurator)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ChartContentView(
                        activeIndex: $controller.activeIndex,
                        slices: controller.slices,
                        geometry: geometry,
                        chartConfigurator: controller.chartConfigurator
                    )
                    if controller.chartConfigurator.showTitle {
                        TitleView(activeIndex: $controller.activeIndex, chartConfigurator: controller.chartConfigurator)
                    }
                }
            }
        }
    }
}

// MARK: - ChartContentView

private struct ChartContentView: View {
    @Binding var activeIndex: Int
    
    let slices: [ChartSliceData]
    let geometry: GeometryProxy
    let chartConfigurator: ChartConfigurator
    
    var body: some View {
        ZStack {
            ForEach(0..<slices.count, id: \.self) { i in
                ChartSliceView(activeIndex: $activeIndex, chartSliceData: slices[i])
                    .scaleEffect(activeIndex == i ? chartConfigurator.scaleCoefficient : 1)
                    .animation(.spring, value: activeIndex)
            }
            .frame(width: geometry.size.width, height: geometry.size.width)
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    handleDragGesture(value)
                }
                .onEnded { _ in
                    if chartConfigurator.chartGestureType == .hold {
                        activeIndex = -1
                    }
                }
            )
        }
    }
    
    private func handleDragGesture(_ value: DragGesture.Value) {
        let radius = 0.5 * geometry.size.width
        let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
        let distance = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
        if case .fixed(let innerRadiusFraction) = chartConfigurator.chartType {
            if distance > radius || distance < radius * innerRadiusFraction {
                activeIndex = -1
                return
            }
        }
        
        var radians = Double(atan2(diff.x, diff.y))
        
        if radians < 0 {
            radians = 2 * Double.pi + radians
        }
        
        for (i, slice) in slices.enumerated() {
            if radians < slice.endAngle.radians {
                switch chartConfigurator.chartGestureType {
                case .tap:
                    if activeIndex == i {
                        activeIndex = -1
                    } else {
                        activeIndex = i
                    }
                case .hold:
                    activeIndex = i
                }
                break
            }
        }
    }
}

// MARK: - TitleView

private struct TitleView: View {
    @Binding var activeIndex: Int
    let chartConfigurator: ChartConfigurator
    
    var body: some View {
        VStack {
            Text(titleText)
            Text(valueText)
        }
        .font(chartConfigurator.titleFont)
        .foregroundColor(getTitleColor())
    }
    
    private var titleText: String {
        activeIndex == -1 ? chartConfigurator.formatter(0).0 : chartConfigurator.chartData[activeIndex].name
    }
    
    private var valueText: String {
        chartConfigurator.formatter(activeIndex == -1 ? chartConfigurator.chartData.reduce(0) { $0 + $1.value } : chartConfigurator.chartData[activeIndex].value).1
    }
    
    private func getTitleColor() -> Color {
        switch chartConfigurator.chartTitleColorType {
        case .fixed(let color):
            return color
        case .dynamic(let defaultColor):
            return activeIndex == -1 ? defaultColor : chartConfigurator.chartData[activeIndex].color
        }
    }
}

