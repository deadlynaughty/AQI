//
//  AQIViewModal.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 28/11/21.
//

import Foundation
import Combine
import UIKit

class AQIViewModal {
    
    var update = PassthroughSubject<[AqiInfo]?, Error>()
    let manager: DataManager!
    var aqiInfo = [AqiInfo]()
    var subscribers = [AnyCancellable]()
    
    public init(dataManager: DataManager) {
        self.manager = dataManager
        fetchData()
    }
    
    private func fetchData() {
        let url = "ws://city-ws.herokuapp.com/"
        manager.continuousDataFetch(url: url, dispatchInterval: DispatchTimeInterval.seconds(5)) {[weak self] (result: Result<[AqiInfo], Error>) in
            switch result {
            case .success(let info):
                self?.updateAQI(info)
                self?.update.send(self?.aqiInfo)
            case .failure(let error):
                self?.update.send(completion: .failure(error))
            }
        }
    }
    
    private func updateAQI(_ info: [AqiInfo]) {
        info.forEach { item in
            if let index = self.aqiInfo.firstIndex(where:{$0.city == item.city}) {
                let lastInstatnce = self.aqiInfo[index]
                var currentInstance = item
                currentInstance.previousAqi = lastInstatnce.currentAqi
                currentInstance.previousRating = lastInstatnce.currentRating
                self.aqiInfo[index] = currentInstance
            } else {
                self.aqiInfo.append(item)
            }
        }
        
        for index in self.aqiInfo.indices {
            var item = self.aqiInfo[index]
            item.updateText = self.updateText(item.time)
            self.aqiInfo[index] = item
        }
    }
    
    private func updateText(_ date: Date) -> String {
        var text = ""
        let timeElapsed = Date().timeIntervalSince(date)
        if timeElapsed < 60 {
            text = "A few seconds ago"
        } else if timeElapsed < 120 {
            text = "A minute ago"
        } else {
            let formatter = DateFormatter.init()
            formatter.timeStyle = .short
            text = formatter.string(from: date)
        }
        return text
    }
    
    //MARK: Public functions to get user interactions
    public func updateRating(_ index: Int) {
        var item = self.aqiInfo[index]
        item.previousRating = item.currentRating
        self.aqiInfo[index] = item
    }
    
    public func showAQIChart(_ index: Int) {
        let info = self.aqiInfo[index]
        let cityController = CityAQIController()
        let aqi = CityAQI.init(info)
        cityController.cityAqi = aqi
        let navController = UIApplication.shared.windows.first!.rootViewController as! UINavigationController
        navController.pushViewController(cityController, animated: true)
    }
}
