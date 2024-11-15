
import UIKit

class MoviesSeriesCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let id = "MoviesSeriesCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let lockedContentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .icLockedContent)
        imageView.bounds.size = .init(width: 24, height: 24)
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
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
        self.lockedContentImageView.isHidden = true
    }
    
    // MARK: - Setup
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(lockedContentImageView)
        contentView.addSubview(titleLabel)
        imageView.addSubview(progressBar)
        
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        lockedContentImageView.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 104),
            imageView.heightAnchor.constraint(equalToConstant: 156),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            
            lockedContentImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            lockedContentImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: .zero),
            
            progressBar.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .zero),
            progressBar.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: .zero),
            progressBar.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .zero),
            progressBar.heightAnchor.constraint(equalToConstant: 4),
        ])
    }
    
    // MARK: - Configure
    func configure(with asset: Asset)  {
        if let purchased = asset.purchased {
            if purchased {
                self.lockedContentImageView.isHidden = false
            }
        }
        
        if let title = asset.name {
            self.titleLabel.text = title
        }
        
        if let url = asset.image {
            self.imageView.loadImage(url: url)
        }
        
        if let progress = asset.progress, progress != 0 {
            progressBar.progress = Float(progress) / 100.0
            progressBar.isHidden = false
        }
    }
}


