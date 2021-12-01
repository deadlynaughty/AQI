//
//  AQIChart.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 01/12/21.
//

import UIKit
import XYChart

class AQIChart: UIView, XYChartDataSource {
    
    private var items = [CityAQI]()
    private var xyChart: XYChart!
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xyChart = XYChart.init(frame: .zero, chartType: .bar)
        xyChart.dataSource = self
        self.addSubview(xyChart)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        xyChart.translatesAutoresizingMaskIntoConstraints = false
        xyChart.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        xyChart.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        xyChart.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        xyChart.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func reloadChart(_ items: [CityAQI]) {
        self.items = items
        xyChart.reloadData(true)
    }
    
    func numberOfSections(in chart: XYChart) -> UInt {
        return 1
    }
    
    func numberOfRows(in chart: XYChart) -> UInt {
        return UInt(items.count)
    }
    
    func chart(_ chart: XYChart, titleOfRowAt index: UInt) -> NSAttributedString {
        let row = Int(bitPattern: index)
        let cityInfo = items[row]
        let text = dateFormatter.string(from: cityInfo.time)
        let title = NSMutableAttributedString.init(string: text)
        title.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange.init(location: 0, length: text.count))
        title.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 8)], range: NSRange.init(location: 0, length: text.count))
        return title
    }
    
    func chart(_ chart: XYChart, titleOfSectionAtValue sectionValue: CGFloat) -> NSAttributedString {
        let text = NSString.init(format: "%.0f", sectionValue) as String
        let title = NSMutableAttributedString.init(string: text)
        title.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange.init(location: 0, length: text.count))
        title.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 8)], range: NSRange.init(location: 0, length: text.count))
        return title
    }
    
    func chart(_ chart: XYChart, itemOfIndex index: IndexPath) -> XYChartItemProtocol {
        let cityInfo = items[index.row]
        let item = XYChartItem.init()
        item.value = NSNumber(value: cityInfo.currentAqi)
        item.duration = 0.25
        item.color = cityInfo.currentRating.getColorFromAQI
        item.showName = NSString.init(format: "%.02f", cityInfo.currentAqi) as String
        return item
    }
    
    func visibleRange(in chart: XYChart) -> XYRange {
        let max = items.max { (first, second) in
            first.currentAqi > second.currentAqi
        }
        guard let max = max else {
            return XYRange.init(min: 0, max: 500)
        }
        let maxRange = CGFloat(10 * ceil(Float(max.currentAqi+10)/10))
        return XYRange.init(min: 0, max: maxRange)
    }
    
    func numberOfLevel(in chart: XYChart) -> UInt {
        return 4
    }
    
    func rowWidth(of chart: XYChart) -> CGFloat {
        return 60
    }
    
    func autoSizingRow(in chart: XYChart) -> Bool {
        return false
    }
    
    deinit {
        debugPrint("deinit AQIChart")
    }
}
