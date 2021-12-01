//
//  CityViewModal.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 01/12/21.
//

import Foundation
import Combine

class CityViewModal {
    
    var update = PassthroughSubject<[CityAQI]?, Error>()
    let manager: DataManager!
    let dispatchInterval: DispatchTimeInterval!
    let city: String!
    var subscribers = [AnyCancellable]()
    var cityInfo = [CityAQI]()
    
    public init(cityAqi: CityAQI, dataManager: DataManager, dispatchInterval: DispatchTimeInterval) {
        self.manager = dataManager
        self.dispatchInterval = dispatchInterval
        self.city = cityAqi.city
        self.cityInfo.append(cityAqi)
        fetchData()
    }
    
    private func fetchData() {
        let url = "ws://city-ws.herokuapp.com/"
        manager.continuousDataFetch(url: url, dispatchInterval: dispatchInterval) {[weak self] (result: Result<[CityAQI], Error>) in
            switch result {
            case .success(let info):
                if let cityAQI = self?.updateAQI(info) {
                    self?.cityInfo.append(cityAQI)
                    self?.update.send(self?.cityInfo)
                }
            case .failure(let error):
                self?.update.send(completion: .failure(error))
            }
        }
    }
    
    private func updateAQI(_ info: [CityAQI]) -> CityAQI? {
        guard let cityItem = info.filter({$0.city == city}).first else {
            return nil
        }
        return cityItem
    }
    
    deinit {
        debugPrint("deinit CityViewModal")
    }
}
