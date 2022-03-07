//
//  DetailViewModel.swift
//  Demo
//
//  Created by Lan Thien on 07/03/2022.
//

import Foundation
import Combine

class DetailViewModel {
    @Published var activity: String?
    @Published var accessibility: String?
    @Published var type: String?
    @Published var participants: String?
    @Published var price: String?
    @Published var key: String?
    
    init(model: ActivityModel) {
        activity = "Activity: \(model.activity)"
        accessibility = "Accessibility: \(model.accessibility)"
        type = "Type: \(model.type.rawValue)"
        participants = "Participants: \(model.participants)"
        price = "Price: \(model.price)"
        key = model.key != nil ? "Key: \(model.key!)" : nil
    }
}
