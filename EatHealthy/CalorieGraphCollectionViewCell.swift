//
//  CalorieGraphCollectionViewCell.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/12/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Charts

class CalorieGraphCollectionViewCell: UICollectionViewCell, ChartViewDelegate {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.delegate = self
        barChartView.noDataText = "No data scrub"
        barChartView.chartDescription?.text = ""
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelPosition = .bottom
        barChartView.backgroundColor = UIColor(red: 98/255, green: 156/255, blue: 194/255, alpha: 1)
        barChartView.animate(xAxisDuration: 3.0)
        barChartView.animate(yAxisDuration: 3.0)
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
    
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.legend.enabled = false
        barChartView.doubleTapToZoomEnabled = false
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            //print("\(i),\(dataPoints[i]),\(values[i])")
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [Double(values[i])])
            dataEntries.append(dataEntry)
            //print(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Calories")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        barChartView.data = chartData
    }
    
}
