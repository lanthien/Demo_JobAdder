//
//  BaseServices.swift
//  Demo
//
//  Created by Lan Thien on 06/03/2022.
//

import Foundation
import Combine

enum RequestPath {
    case activityByType(ActivityType)
    
    func genratePath() -> String {
        switch self {
        case .activityByType(let type):
            return "/api/activity?type=\(type.rawValue)"
        }
    }
}

class BaseServices {
    private let baseUrl = "http://www.boredapi.com"
    private let defaultSession: URLSession
    
    init () {
        defaultSession = URLSession(configuration: .default)
    }
    
    func makeRequest(path: RequestPath, body: [String : Any]?, method: HttpMethod) -> AnyPublisher<Data, Error>{
        guard let url = URL(string: baseUrl + path.genratePath()) else {
            return Empty(completeImmediately: false).eraseToAnyPublisher()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        }
        return defaultSession.dataTaskPublisher(for: urlRequest)
            .tryMap { output -> Data in
                return output.data
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
