//
//  DetailViewController.swift
//  Demo
//
//  Created by Lan Thien on 07/03/2022.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    @IBOutlet private weak var lblActivity: UILabel!
    @IBOutlet private weak var lblAccessibility: UILabel!
    @IBOutlet private weak var lblType: UILabel!
    @IBOutlet private weak var lblParticipants: UILabel!
    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var lblKey: UILabel!
    
    private var subscriptions: Set<AnyCancellable> = []
    
    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel.$activity
            .assign(to: \.text, on: lblActivity)
            .store(in: &subscriptions)
        self.viewModel.$accessibility
            .assign(to: \.text, on: lblAccessibility)
            .store(in: &subscriptions)
        self.viewModel.$type
            .assign(to: \.text, on: lblType)
            .store(in: &subscriptions)
        self.viewModel.$participants
            .assign(to: \.text, on: lblParticipants)
            .store(in: &subscriptions)
        self.viewModel.$price
            .assign(to: \.text, on: lblPrice)
            .store(in: &subscriptions)
        self.viewModel.$key
            .assign(to: \.text, on: lblKey)
            .store(in: &subscriptions)
        
        self.viewModel.$key
            .map { $0 == nil }
            .assign(to: \.isHidden, on: lblKey)
            .store(in: &subscriptions)
    }
}
