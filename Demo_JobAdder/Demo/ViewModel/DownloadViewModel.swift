//
//  DownloadViewModel.swift
//  Demo
//
//  Created by Lan Thien on 06/03/2022.
//

import Foundation
import Combine
import UIKit

class DownloadViewModel: ObservableObject {
    @Published private(set) var activities: [[ActivityModel]] = []
    let types = ActivityType.allCases
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        self.activities = Array(repeating: [ActivityModel](), count: types.count)
    }
    
    func getActivities() {
        let count = types.count
        for index in 0..<count {
            for _ in 0..<5 {
                Services.instance.getActivityByType(types[index]).sink { completion in
                    switch completion {
                    case .failure(_):
                        break
                    case .finished:
                        break
                    }
                } receiveValue: { [weak self] activity in
                    guard let self = self else {
                        return
                    }
                    self.activities[index].append(activity)
                }
                .store(in: &subscriptions)

            }
        }
    }
    
    func configTableViewCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewControllerTableViewCell", for: indexPath) as! ViewControllerTableViewCell
        cell.setModel(activity: self.activities[indexPath.section][indexPath.row])
        return cell
    }
    
    func prepareMoveToDetail(from indexPath: IndexPath) -> UIViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.viewModel = DetailViewModel(model: self.activities[indexPath.section][indexPath.row])
        return viewController
    }
}
