//
//  ViewController.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 23/11/21.
//

import UIKit
import Combine

class AQIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let aqiViewModal = AQIViewModal(dataManager: DataManager.shared)
    var info = [AqiInfo]()
    var subscribers = Set<AnyCancellable>()
    
    let aqiTable: UITableView = {
        let tableview = UITableView()
        tableview.separatorColor = .clear
        tableview.separatorEffect = .none
        tableview.register(AQICell.self, forCellReuseIdentifier: "AQICell")
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        aqiTable.backgroundColor = .white
        title = "Air Quality Index"
        self.view.addSubview(aqiTable)
        aqiTable.translatesAutoresizingMaskIntoConstraints = false
        let margin = self.view.safeAreaLayoutGuide
        aqiTable.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 20).isActive = true
        aqiTable.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -20).isActive = true
        aqiTable.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        aqiTable.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -20).isActive = true
        aqiTable.delegate = self
        aqiTable.dataSource = self
        observeChanges()
    }
    
    private func observeChanges() {
        aqiViewModal.update
            .receive(on: DispatchQueue.main)
            .sink { (completionStatus) in
                
            } receiveValue: {[weak self] (results) in
                if let results = results {
                    self?.info = results
                    self?.aqiTable.reloadData()
                }
            }.store(in: &subscribers)
    }
}

