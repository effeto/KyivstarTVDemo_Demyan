import UIKit

final class PromotionsCell: UICollectionViewCell {
    // MARK: - Variables
    static let id = "PromotionsCollectionViewCell"
    
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero)
        ])
    }
    
    func configure(promotion: Promotion)  {
        if let url = promotion.image {
            self.imageView.loadImage(url: url)
        }
    }
}
