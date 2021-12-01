//
//  AQITableDelegate.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 27/11/21.
//

import Foundation
import UIKit
import Charts

extension AQIViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.aqiViewModal.showAQIChart(indexPath.row)
    }
}
