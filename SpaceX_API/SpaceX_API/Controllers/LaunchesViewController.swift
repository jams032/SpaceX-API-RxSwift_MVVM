//
//  LaunchesViewController.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

protocol LaunchesNavigationDelegate {
    func navigateToLaunchDetails(missionName: String, id:String, flightNumber: Int, rocketId: String, launch:LaunchModel)
}

class LaunchesViewController: UIViewController {

    @IBOutlet var sortSegmentedControl: UISegmentedControl!
    @IBOutlet var launchSuccessSegmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    private var activityIndicatorView: UIActivityIndicatorView!

    var viewModel: LaunchesViewModel!
    private let disposeBag = DisposeBag()

    var delegate: LaunchesNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.localFormat

        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, LaunchModel>>(
            configureCell: { dataSource, table, indexPath, item in
                guard let cell = table.dequeueReusableCell(withIdentifier: LaunchesTableViewCell.classIdentifier, for: indexPath) as? LaunchesTableViewCell else { return UITableViewCell() }
                cell.missionLabel.text = item.name
                cell.dateLabel.text = dateFormatter.date(from: item.launchDate)?.toString()
                return cell
            },
            titleForHeaderInSection: { dataSource, index in
                return dataSource.sectionModels[index].model
            }
        )

        viewModel.sections
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)

        tableView.rx.modelSelected(LaunchModel.self)
        .subscribe(onNext: { [weak self] cellViewModel in
            guard let self = self else { return }
            self.delegate?.navigateToLaunchDetails(missionName: cellViewModel.name,id: cellViewModel.id!, flightNumber: cellViewModel.flightNumber!, rocketId: cellViewModel.rocket!,launch: cellViewModel)
            if let indexPath = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }).disposed(by: disposeBag)

        viewModel.retrieveLaunches()

        if #available(iOS 13.0, *) {
            startLoading()
        }
    }

    // MARK: - Activity View

    @available(iOS 13.0, *)
    private func startLoading() {
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityIndicatorView
        tableView.separatorStyle = .none
        activityIndicatorView.startAnimating()
    }

    @available(iOS 13.0, *)
    private func stopLoading() {
        tableView.separatorStyle = .singleLine
        activityIndicatorView.stopAnimating()
    }

    // MARK: - IBActions

    @IBAction func sortSegmentedControl(_ sender: UISegmentedControl) {
        viewModel.sort(by: LaunchSortingOrder(rawValue: sender.selectedSegmentIndex))
    }

    @IBAction func successSegmentedControlSelected(_ sender: UISegmentedControl) {
        viewModel.filter(by: LaunchFilter(rawValue: sender.selectedSegmentIndex))
    }
}
