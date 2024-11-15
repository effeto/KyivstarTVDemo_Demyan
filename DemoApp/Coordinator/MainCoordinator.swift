import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Variables
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    let window = UIWindow()
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal
    func start() {
        let vm = MainViewModel()
        let vc = MainViewController(vm, self)
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openAsset(asset: Asset) {
        let vm = AssetDetailsViewModel(asset: asset)
        let vc = AssetDetailsViewController(vm, self)
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
