import Foundation
import UIKit
import SwiftUI
import Combine

class AssetDetailsViewController: UIViewController {
    typealias Coordinator = MainCoordinator
    typealias ViewModel = AssetDetailsViewModel
    
    private let coordinator: Coordinator
    
    private var viewModel: AssetDetailsViewModel
    private var detailView: AssetDetailsView
    private var cancellable = Set<AnyCancellable>()

    //MARK: - Init
    init(_ viewModel: AssetDetailsViewModel, _ coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.detailView = .init(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupHostingController()
        bindHostingOutput()
    }
    
    // MARK: - View setup
    private func setupHostingController() {
        let hostingController = UIHostingController(rootView: detailView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(hostingController)
        view.addSubview(hostingController.view)
    
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    private func bindHostingOutput() {
        detailView.hostingOutputSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                switch action {
                case .dismiss:
                    self?.coordinator.goBack()
                case .play:
                    print("play")
                case .favorite:
                    self?.viewModel.favoriteAction()
                }
            }.store(in: &cancellable)
    }
}


enum AssetDetailsViewHostingAction {
    case dismiss
    case play
    case favorite
}
