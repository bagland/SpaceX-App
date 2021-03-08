//
//  LauchDetailsController.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import UIKit
import RxSwift
import SDWebImage
import SafariServices

class LauchDetailsController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wikipedia: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel: LaunchDetailsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Rocket Details"
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
        resolveWikiTaps()
        resolveBindings()
        viewModel?.fetch()
    }
    
    private func resolveWikiTaps() {
        let tap = UITapGestureRecognizer()
        wikipedia.addGestureRecognizer(tap)
        wikipedia.isUserInteractionEnabled = true
        tap.rx.event.bind { [weak self] _ in
            guard let link = self?.viewModel?.wikiLink else { return }
            self?.routeToWiki(link: link)
        }.disposed(by: disposeBag)
    }
    
    private func resolveBindings() {
        // Bind isLoading
        viewModel?
            .isLoading
            .observeOn(MainScheduler.instance)
            .map { [weak self] in
                self?.showLoadingIndicator($0)
            }
            .subscribe()
            .disposed(by: disposeBag)
        // Subscribe to rocket model and update contents.
        viewModel?.rocket.subscribe(onNext: { [weak self] (rocket) in
            self?.nameLabel.text = rocket.name
            self?.descriptionLabel.text = rocket.descr
            self?.imgView.sd_setImage(with: URL(string: rocket.imgUrl ?? ""))
        }).disposed(by: disposeBag)
    }
    
    private func showLoadingIndicator(_ show: Bool) {
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    
    /// Opens wilki link in an in-app Safari Browser.
    /// - Parameter link: wiki link
    private func routeToWiki(link: String) {
        guard let url = URL(string: link) else { return }
        let safariCtrl = SFSafariViewController(url: url)
        present(safariCtrl, animated: true, completion: nil)
    }

}
