//
//  CityAQI.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 01/12/21.
//

import Foundation

struct CityAQI: Codable {
    let city: String
    var currentAqi: Float
    var currentRating: AQICategory
    var time: Date
    
    enum CodingKeys : String, CodingKey {
        case city
        case currentAqi = "aqi"
    }
    
    init(_ aqiInfo: AqiInfo) {
        self.city = aqiInfo.city
        self.currentAqi = aqiInfo.currentAqi
        self.currentRating = aqiInfo.currentRating
        self.time = aqiInfo.time
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decode(String.self, forKey: .city)
        currentAqi = try values.decode(Float.self, forKey: .currentAqi)
        if currentAqi > 401 {
            currentRating = .severe
        } else if currentAqi > 301 {
            currentRating = .verypoor
        } else if currentAqi > 201 {
            currentRating = .poor
        } else if currentAqi > 101 {
            currentRating = .moderate
        } else if currentAqi > 51 {
            currentRating = .satifactory
        } else {
            currentRating = .good
        }
        time = Date.init()
    }
}
