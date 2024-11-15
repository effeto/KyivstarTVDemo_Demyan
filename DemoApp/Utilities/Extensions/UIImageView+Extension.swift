import UIKit
import Nuke

extension UIImageView {
    func loadImage(url: URL) {
        ImagePipeline.shared.loadImage(with: url) { [weak self] in
            guard let self, case .success(let response) = $0 else { return }
            self.image = response.image
        }
    }
}
