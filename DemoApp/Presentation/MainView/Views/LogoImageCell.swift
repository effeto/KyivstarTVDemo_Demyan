import UIKit

class LogoImageCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let id = "LogoImageCell"
    
    var kyivstarLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .kyivstarLogo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupKyivstarLogoImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    private func setupKyivstarLogoImageView() {
        self.addSubview(kyivstarLogoImageView)
        kyivstarLogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        kyivstarLogoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    }
}



