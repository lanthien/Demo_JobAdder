//
//  Constants.swift
//  Demo
//
//  Created by Lan Thien on 06/03/2022.
//

import Foundation

enum ActivityType: String, Codable, CaseIterable {
    case education, recreational, social, diy, charity, cooking, relaxation, music, busywork
}

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}
