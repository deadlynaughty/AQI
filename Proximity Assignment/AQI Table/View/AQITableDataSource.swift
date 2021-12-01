//
//  AQITableDataSource.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 27/11/21.
//

import Foundation
import UIKit

extension AQIViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.aqiViewModal.aqiInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AQICell = tableView.dequeueReusableCell(withIdentifier: "AQICell", for: indexPath) as! AQICell
        let information = self.aqiViewModal.aqiInfo[indexPath.row]
        cell.information = information
        cell.updateInfo {[weak self] (needsUpdate) in
            if needsUpdate {
                self?.aqiViewModal.updateRating(indexPath.row)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        let width = (tableView.bounds.width - 120) * 0.5
        let firstColumn = createHeaderLabel("City")
        firstColumn.frame = CGRect.init(x: 10, y: 0, width: width, height: 60)
        firstColumn.textAlignment = .left
        view.addSubview(firstColumn)
        
        let secondColumn = createHeaderLabel("Current AQI")
        secondColumn.frame = CGRect.init(x: firstColumn.frame.origin.x + firstColumn.frame.width, y: 0, width: 100, height: 60)
        secondColumn.textAlignment = .center
        view.addSubview(secondColumn)
        
        let thirdColumn = createHeaderLabel("Last Updated")
        thirdColumn.frame = CGRect.init(x: secondColumn.frame.origin.x + secondColumn.frame.width + 10, y: 0, width: width, height: 60)
        thirdColumn.textAlignment = .left
        view.addSubview(thirdColumn)
        
        let firstSeparator = UIView.init(frame: CGRect.init(x: (tableView.frame.width - 100) * 0.5, y: 0, width: 1, height: 60))
        firstSeparator.backgroundColor = .black
        let secondSeparator = UIView.init(frame: CGRect.init(x: (tableView.frame.width - (tableView.frame.width - 100) * 0.5), y: 0, width: 1, height: 60))
        secondSeparator.backgroundColor = .black
        view.addSubview(firstSeparator)
        view.addSubview(secondSeparator)
        
        return view
    }
    
    func createHeaderLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .darkText
        label.text = text
        label.font = UIFont.italicSystemFont(ofSize: 17)
        return label
    }
    
    func layoutFirstColumn(_ label: UILabel, _ headerView: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: (aqiTable.frame.width - 120) * 0.5).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
