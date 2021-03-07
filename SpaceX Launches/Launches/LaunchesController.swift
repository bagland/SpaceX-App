//
//  LaunchesController.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class LaunchesController: UIViewController {
    enum CellIdentifiers {
        static let launch = "Launch"
        static let plain = "Plain"
        static let error = "Error"
    }
    private let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    private let viewModel: LaunchesViewModelProtocol = LaunchesViewModel(
        networking: Injection.container.resolve(NetworkServiceProtocol.self)!,
        mapper: Injection.container.resolve(LaunchMapperProtocol.self)!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SpaceX Launches"
        configureTable()
        resolveBindings()
        viewModel.fetch()
    }
    
    private func configureTable() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "LaunchCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.launch)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifiers.plain)
        tableView.register(UINib(nibName: "ErrorCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.error)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func resolveBindings() {
        resolveLoadingBindings()
        resolveTableBindings()
        resolveTableSelection()
    }
    
    private func resolveLoadingBindings() {
        viewModel
            .isLoading
            .observeOn(MainScheduler.instance)
            .map { [weak self] in self?.showLoadingIndicator($0) }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func resolveTableBindings() {
        viewModel
            .launches
            .observeOn(MainScheduler.instance)
            .bind(to: self.tableView.rx.items) { [weak self] table, index, item in
                let indexPath = IndexPath(row: index, section: 0)
                switch item {
                case .items(let launch):
                    let cell = table.dequeueReusableCell(withIdentifier: CellIdentifiers.launch, for: indexPath) as! LaunchCell
                    cell.update(with: launch)
                    return cell
                case .empty:
                    let cell = table.dequeueReusableCell(withIdentifier: CellIdentifiers.plain, for: indexPath)
                    cell.textLabel?.text = "No data"
                    return cell
                case .error(let message):
                    let cell = table.dequeueReusableCell(withIdentifier: CellIdentifiers.error, for: indexPath) as! ErrorCell
                    cell.separatorInset = .zero
                    cell.errorLabel.text = message
                    guard let strSelf = self else { return cell }
                    cell.reloadButton.rx.tap.subscribe { _ in
                        strSelf.viewModel.fetch()
                    }.disposed(by: strSelf.disposeBag)
                    return cell
                }
        }.disposed(by: disposeBag)
    }
    
    private func resolveTableSelection() {
        tableView
            .rx
            .modelSelected(LaunchesViewType.self)
            .subscribe(onNext:  { [weak self] (viewType: LaunchesViewType) in
                switch viewType {
                case .items(let launch):
                    self?.routeToDetails(launch.rocket)
                default: break
                }
                if let selectedIndexPath = self?.tableView.indexPathForSelectedRow {
                    self?.tableView.deselectRow(at: selectedIndexPath, animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
    
    /// Show/Hide indicator
    /// - Parameter show: if true starts loading animation, if false hides it.
    private func showLoadingIndicator(_ show: Bool) {
        show ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
    
    
    /// Routes to rocket details
    /// - Parameter rocketId: rocket id to be fetched.
    private func routeToDetails(_ rocketId: String) {
        let storyboard = UIStoryboard(name: "LaunchDetails", bundle: nil)
        let detailsController = storyboard.instantiateViewController(identifier: "LauchDetailsController") as! LauchDetailsController
        let navController = UINavigationController(
            rootViewController: detailsController)
        let vm = Injection.container.resolve(
            LaunchDetailsViewModelProtocol.self,
            argument: rocketId)
        detailsController.viewModel = vm
        present(navController, animated: true, completion: nil)
    }

}
