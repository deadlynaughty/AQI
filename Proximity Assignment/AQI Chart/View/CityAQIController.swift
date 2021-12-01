//
//  CityAQIController.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 01/12/21.
//

import UIKit
import Combine

class CityAQIController: UIViewController {

    var cityViewModal: CityViewModal?
    var subscribers = Set<AnyCancellable>()
    var cityAqi: CityAQI!
    
    var chart: AQIChart = {
        let chart = AQIChart()
        return chart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = cityAqi.city
        cityViewModal = CityViewModal.init(cityAqi: cityAqi, dataManager: DataManager.shared, dispatchInterval: DispatchTimeInterval.seconds(30))
        self.view.addSubview(chart)
        let margin = self.view.safeAreaLayoutGuide
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.topAnchor.constraint(equalTo: margin.topAnchor, constant: 80).isActive = true
        chart.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 20).isActive = true
        chart.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -20).isActive = true
        chart.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4).isActive = true
        observeChanges()
    }
    
    private func observeChanges() {
        cityViewModal?.update
            .receive(on: DispatchQueue.main)
            .sink { (completionStatus) in
                
            } receiveValue: {[weak self] (results) in
                if let results = results {
                    self?.chart.reloadChart(results)
                }
            }.store(in: &subscribers)
    }

    deinit {
        debugPrint("deinit CityAQIController")
    }
}
