//
//  ActivityModel.swift
//  Demo
//
//  Created by Lan Thien on 06/03/2022.
//

import Foundation

struct ActivityModel: Codable {
    let activity: String
    let accessibility: Float
    let type: ActivityType
    let participants: Int
    let price: Double
    let key: String?
}

