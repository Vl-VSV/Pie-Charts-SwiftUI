//
//  SwiftUIView.swift
//  
//
//  Created by Vlad V on 30.03.2024.
//

import SwiftUI

// MARK: - CharView
internal struct ChartView: View {
    //MARK: - Properties
    @ObservedObject var controller: ChartController
    
    //MARK: - Init
    public init(chartConfigurator: ChartConfigurator) {
        self.controller = ChartController(chartConfigurator: chartConfigurator)
    }
    
    // MARK: - Body
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ChartContentView(activeIndex: $controller.activeIndex, slices: controller.slices, geometry: geometry, chartConfigurator: controller.chartConfigurator)
                    
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
    // MARK: - Properties
    @Binding var activeIndex: Int
    let slices: [ChartSliceData]
    let geometry: GeometryProxy
    let chartConfigurator: ChartConfigurator
    
    private let scaleCoefficient: CGFloat = 1.03
    
    // MARK: - Body
    var body: some View {
        ZStack {
            ForEach(0 ..< slices.count) { i in
                ChartSliceView(chartSliceData: slices[i])
                    .scaleEffect(activeIndex == i ? scaleCoefficient : 1)
                    .animation(.spring, value: activeIndex)
            }
            .frame(width: geometry.size.width, height: geometry.size.width)
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    handleDragGesture(value)
                }
                .onEnded { _ in
                    activeIndex = -1
                }
            )
        }
    }
    
    // MARK: - Functions
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
        
        if (radians < 0) {
            radians = 2 * Double.pi + radians
        }
        
        for (i, slice) in slices.enumerated() {
            if (radians < slice.endAngle.radians) {
                activeIndex = i
                break
            }
        }
    }
}

// MARK: - TitleView
private struct TitleView: View {
    // MARK: - Properties
    @Binding var activeIndex: Int
    let chartConfigurator: ChartConfigurator
    
    private var titleText: String {
        return activeIndex == -1 ? "Total" : chartConfigurator.chartData[activeIndex].name
    }
    
    private var valueText: String {
        return chartConfigurator.formatter(activeIndex == -1 ? chartConfigurator.chartData.reduce(0) { $0 + $1.value } : chartConfigurator.chartData[activeIndex].value)
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(titleText)
            Text(valueText)
        }
        .font(chartConfigurator.titleFont)
        .foregroundColor(getTitleColor())
    }
    
    // MARK: - Functions
    private func getTitleColor() -> Color {
        switch chartConfigurator.chartTitleColorType {
        case .fixed(let color):
            return color
        case .dynamic(let defaultColor):
            return activeIndex == -1 ? defaultColor : chartConfigurator.chartData[activeIndex].color
        }
    }
}
