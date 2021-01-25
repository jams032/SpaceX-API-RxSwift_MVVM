//
//  LaunchDetailViewController.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import RxSwift

protocol LaunchDetailNavigationDelegate {
    func presentRocketInformation(url: URL)
}

class LaunchDetailViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var rocketImageContainer: UIView!
    @IBOutlet var rocketImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var missionDetailsTextView: UITextView!
    @IBOutlet var launchDateLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var rocketDescriptionTextView: UITextView!
    @IBOutlet var moreInformationButton: UIButton!

    var viewModel: LaunchDetailViewModel!
    private let disposeBag = DisposeBag()
    private let dateFormatter = DateFormatter()
    private var wikipediaURLString: String?

    var delegate: LaunchDetailNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        if let launch  = viewModel.currentLaunch  {
            self.setupUI(from: launch)
        } else {
            self.stackView.isHidden = true
        }
        
        if viewModel.currentRocket != nil {
            self.setupUI(from: viewModel.currentRocket)
            self.wikipediaURLString = viewModel.currentRocket.wikipedia
        } else {
            self.stackView.isHidden = true
        }
        
        
        // As the Launch detaul API is not working properly , i just kept the structre
//        viewModel.launch.subscribe(onNext: { [weak self] launch in
//            guard let self = self, launch.name.count > 0 else { return }
//            self.setupUI(from: launch)
//        }, onError: { _ in
//            self.stackView.isHidden = true
//        }).disposed(by: disposeBag)

//        viewModel.rocket.subscribe(onNext: { [weak self] rocket in
//            guard let self = self, rocket.rocketName.count > 0 else { return }
//            self.setupUI(from: rocket)
//            self.wikipediaURLString = rocket.wikipedia
//        }, onError: { _ in
//            self.stackView.isHidden = true
//        }).disposed(by: disposeBag)
        

    }

    // MARK: - Setup UI

    private func setup() {
        dateFormatter.dateFormat = Date.localFormat
        moreInformationButton.layer.cornerRadius = 8.0
    }

    private func setupUI(from launch: LaunchModel) {
        DispatchQueue.main.async {
            self.stackView.isHidden = false // launch.links.missionPatch
            if let missionPatch = launch.links?.patch?.small, let patchURL = URL(string: missionPatch) {
                self.activityIndicator.startAnimating()
                self.rocketImageContainer.isHidden = false
                self.rocketImageView.load(url: patchURL, completion: { [weak self] success in
                    guard let self = self else { return }
                    self.activityIndicator.stopAnimating()
                    if success {
                        self.rocketImageContainer.isHidden = false
                    } else {
                        self.rocketImageContainer.isHidden = true
                    }
                })

            } else {
                self.rocketImageContainer.isHidden = true
                self.activityIndicator.stopAnimating()
            }

            if let launchDetails = launch.details { // launch.details
                self.missionDetailsTextView.text = launchDetails
                self.missionDetailsTextView.isHidden = false
            } else {
                self.missionDetailsTextView.isHidden = true
            }

            if let launchDate = self.dateFormatter.date(from: launch.dateLocal)?.toString(dateStyle: .medium) { // launch.launchDate
                let launchDatePrefix: String
                if let launchSuccess = launch.success {
                    if launchSuccess {
                        launchDatePrefix = "Successful launch on"
                    } else {
                        launchDatePrefix = "Failed launch on"
                    }
                } else {
                    launchDatePrefix = "To be launched on"
                }
                self.launchDateLabel.text = "\(launchDatePrefix) \(launchDate)"
                self.launchDateLabel.isHidden = false
            } else {
                self.launchDateLabel.isHidden = true
            }
        }
    }

    private func setupUI(from rocket: RocketModel) {
        DispatchQueue.main.async {
            self.stackView.isHidden = false
            self.costLabel.text = ""
            self.countryLabel.text = rocket.country
            self.companyLabel.text = rocket.company
            self.rocketDescriptionTextView.text = rocket.description
            self.moreInformationButton.setTitle("\(rocket.rocketName) 🚀", for: .normal)
            self.moreInformationButton.isHidden = false
        }
    }

    // MARK: - IBAction

    @IBAction func moreInformationButtonPressed(_ sender: Any) {
        guard let urlString = wikipediaURLString, let url = URL(string: urlString) else { return }
        delegate?.presentRocketInformation(url: url)
    }
}
