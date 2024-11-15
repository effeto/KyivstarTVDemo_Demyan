import UIKit

protocol SectionHeaderViewDelegate: AnyObject {
    func sectionHeaderViewDidDelete(_ view: SectionHeaderView, section: Section)
}

class SectionHeaderView: UICollectionReusableView {
    // MARK: - Variables
    static let id = "SectionHeader"
    weak var delegate: SectionHeaderViewDelegate?
    private var section: Section?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Del", for: .normal)
        button.setTitleColor(UIColor(hex: "0063C6"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Privates
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            deleteButton.heightAnchor.constraint(equalToConstant: 28),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }

    
    func configure(with section: Section) {
        self.section = section
        
        switch section {
        case .moviesSeries, .liveChannel, .epg:
            
            switch section.canBeDeleted {
            case true:
                self.deleteButton.isHidden = false
            case false:
                self.deleteButton.isHidden = true
            }
            
        default:
            self.deleteButton.isHidden = true
        }
        

        
        titleLabel.text = section.name
    }
    
    // MARK: - Actions
    @objc private func didTapDelete(_ sender: Any) {
        guard let section else { return }
        delegate?.sectionHeaderViewDidDelete(self, section: section)
    }
}
