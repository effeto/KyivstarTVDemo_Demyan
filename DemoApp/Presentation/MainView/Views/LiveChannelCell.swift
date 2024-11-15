import UIKit

class LiveChannelCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let id = "LiveChannelCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    private let lockIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .icLockedContent)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    // MARK: - Setup
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(lockIconView)
        contentView.addSubview(titleLabel)
        contentView.layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        lockIconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            lockIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .zero),
            lockIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .zero),
            lockIconView.widthAnchor.constraint(equalToConstant: 32),
            lockIconView.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configure
    func configure(with asset: Asset) {
        if let url = asset.image {
            imageView.loadImage(url: url)
        } else {
            imageView.backgroundColor = .darkGray
        }
        
        if let purchased = asset.purchased {
            if purchased {
                lockIconView.isHidden = true
            }
        }
                
        titleLabel.text = asset.name
    }
}
