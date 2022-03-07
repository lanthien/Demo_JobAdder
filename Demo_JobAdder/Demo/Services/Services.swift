//
//  Services.swift
//  Demo
//
//  Created by Lan Thien on 06/03/2022.
//

import Foundation
import Combine

class Services: BaseServices {
    static let instance: Services = Services()
    
    private override init() {
        super.init()
    }
    
    func getActivityByType(_ type: ActivityType) -> AnyPublisher<ActivityModel, Error> {
        self.makeRequest(path: .activityByType(type), body: nil, method: .get).tryMap { data -> ActivityModel in
            return try JSONDecoder().decode(ActivityModel.self, from: data)
        }
        .eraseToAnyPublisher()
    }
}
