//
//  ViewController.swift
//  Demo
//
//  Created by Lan Thien on 06/03/2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet private weak var tbvActivities: UITableView!
    private let viewModel = DownloadViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tbvActivities.delegate = self
        self.tbvActivities.dataSource = self
        
        self.viewModel.$activities
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tbvActivities.reloadData()
            }
        }
        .store(in: &subscriptions)
        
        self.viewModel.getActivities()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.activities[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.configTableViewCell(for: tableView, at: indexPath)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.viewModel.prepareMoveToDetail(from: indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.types[section].rawValue.capitalizingFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
