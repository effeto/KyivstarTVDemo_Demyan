
import UIKit

class EPGCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let id = "EPGCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let lockIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .icLockedContent)
        imageView.bounds.size = .init(width: 24, height: 24)
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.progressTintColor = UIColor(hex: "0D7BDD")
        progressBar.trackTintColor = UIColor(hex: "2B3037")
        progressBar.layer.cornerRadius = 3
        progressBar.clipsToBounds = true
        progressBar.isHidden = true
        return progressBar
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
        contentView.addSubview(subtitleLabel)
        imageView.addSubview(progressBar)
        
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        lockIconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            lockIconView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            lockIconView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            lockIconView.widthAnchor.constraint(equalToConstant: 24),
            lockIconView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            progressBar.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .zero),
            progressBar.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: .zero),
            progressBar.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .zero),
            progressBar.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    // MARK: - Configure
    func configure(with asset: Asset) {
        
        if let url = asset.image {
            imageView.loadImage(url: url)
        } else {
            imageView.backgroundColor = .lightGray
        }
        
        lockIconView.isHidden = !(asset.purchased ?? false)
        
        titleLabel.text = asset.name
        
        if let company = asset.company {
            subtitleLabel.text = "У записі · Телеканал \(company)"
        }
        
        if let progress = asset.progress, progress != 0 {
            progressBar.progress = Float(progress) / 100.0
            progressBar.isHidden = false
        }
    }
}
