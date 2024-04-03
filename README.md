# PieCharts SwiftUI

A simple library for creating customizable Pie Charts in SwiftUI with various settings and options.
![MainDemo.gif](Demo%20Images%2FMainDemo.gif)

## Installation

To integrate PieCharts into your Xcode project, simply follow these steps:

1. In Xcode, navigate to File -> Swift Packages -> Add Package Dependency.
2. Paste the repository's URL.

## Usage

Here's a basic example demonstrating how to use PieCharts:

```swift
import PieCharts

let chartConfigurator = ChartConfigurator(
    chartType: .dynamic,
    chartData: [
        ChartDataSection(name: "First", value: 500, color: .red),
        ChartDataSection(name: "Second", value: 1000, color: .blue),
        ChartDataSection(name: "Third", value: 300, color: .green)
    ],
    showTitle: true,
    showPercents: false
)

ChartView(chartConfigurator: chartConfigurator)
```

## Customization Options

### Chart Type

You can choose chart type:

* **Dynamic**

```swift
chartType: .dynamic
```

![Dynamic.png](Demo%20Images%2FDynamic.png)

* **Fixed**

```swift
chartType: .fixed(innerRadiusFraction: 0.6)
```

You can adjust the inner radius fraction.

![Fixed.png](Demo%20Images%2FFixed.png)

### Gesture Type

You can select tap gesture types:

* **Hold**

```swift
chartGestureType: .hold
```

* **Tap**

```swift
chartGestureType: .tap
```

Demonstration

![Gesture.gif](Demo%20Images%2FGesture.gif)

### Font Customization

You can customize the font for both the percentage and title.

```swift
titleFont: .title,
percentFont: .title3
```

### Colors

#### Title

You have the option to set the color of the main label:

* **Signle color**

```swift
chartTitleColorType: .fixed(color: .black)
```

* **Dynamic Color**

```swift
chartTitleColorType: .dynamic(defaultColor: .black)
```

You can specify the default color and it varies depending on the selected category.

#### Percentage

You can change the color of the percentage text.

```swift
percentColor: .black
```

### Custom Title:

You can customize the label text using a formatter closure that takes a Double value as input, representing either the
value of the selected category or the total sum of all values when no category is selected. The closure returns a tuple
with two strings:

* **1st String:** The top line when none of the categories are highlighted.
* **2nd String:** The bottom line with the value.

```swift
formatter: (Double) -> (String, String)
```

*Example:*

```swift
formatter: { ("Total Amount", String(format: "%.2f €", $0)) }
```

![Formatter.png](Demo%20Images%2FFormatter.png)

## Issues

If you encounter any issues or have suggestions for improvements, please feel free to open an issue on the GitHub
repository.

## Contact
For any further assistance or inquiries, feel free to reach out via any method listed in my profile.

Your feedback is highly appreciated! Thank you for using PieCharts SwiftUI.