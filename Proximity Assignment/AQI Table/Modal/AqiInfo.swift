//
//  CityInfo.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 24/11/21.
//

import Foundation

struct AqiInfo: Codable {
    let city: String
    var currentAqi: Float
    var currentRating: AQICategory
    var time: Date
    var updateText: String
    var previousAqi: Float
    var previousRating: AQICategory
    
    enum CodingKeys : String, CodingKey {
        case city
        case currentAqi = "aqi"
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
        previousRating = currentRating
        updateText = ""
        previousAqi = currentAqi
    }
}
