import UIKit


class MainView: UIView {
    // MARK: - Variables
    weak var collectionView: UICollectionView?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Privates
    private func setupCollectionView() {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.id)
        
        collectionView.register(MainViewSecrtionPromoFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: MainViewSecrtionPromoFooterView.id)
        
        collectionView.register(LogoImageCell.self, forCellWithReuseIdentifier: LogoImageCell.id)
        collectionView.register(PromotionsCell.self, forCellWithReuseIdentifier: PromotionsCell.id)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.id)
        collectionView.register(MoviesSeriesCell.self, forCellWithReuseIdentifier: MoviesSeriesCell.id)
        collectionView.register(LiveChannelCell.self, forCellWithReuseIdentifier: LiveChannelCell.id)
        collectionView.register(EPGCell.self, forCellWithReuseIdentifier: EPGCell.id)

        self.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.collectionView = collectionView
    }
}



