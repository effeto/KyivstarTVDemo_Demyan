
import UIKit
import Nuke

class MainViewDataSourceManager {
    // MARK: - Variables
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Content = (section: Section, items: [Item])
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    typealias Delegate = SectionHeaderViewDelegate
    typealias ViewModel = MainViewModel

    private weak var collectionView: UICollectionView?
    private var viewModel: ViewModel

    // MARK: - Init
    init(collectionView: UICollectionView, viewModel: ViewModel) {
        self.collectionView = collectionView
        self.viewModel = viewModel
    }
    
    // MARK: - Public
    func makeDataSource(delegate: Delegate) -> UICollectionViewDiffableDataSource<Section, Item> {
        guard let collectionView = collectionView else {
            fatalError("CollectionView is not available")
        }
        
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .logo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LogoImageCell.id,
                                                                    for: indexPath) as? LogoImageCell else {
                    return UICollectionViewCell()
                }
                
                return cell
                
            case .promotion(let promotion):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionsCell.id,
                                                                    for: indexPath) as? PromotionsCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(promotion: promotion)
                
                return cell
                
            case .category(let category):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id,
                                                                    for: indexPath) as? CategoryCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(with: category)
                
                return cell
                
            case .moviesSeries(let asset):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesSeriesCell.id,
                                                                    for: indexPath) as? MoviesSeriesCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(with: asset)
                
                return cell
                
            case .liveСhannels(let asset):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveChannelCell.id,
                                                                    for: indexPath) as? LiveChannelCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(with: asset)
                
                return cell
                
            case .epg(let asset):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EPGCell.id,
                                                                    for: indexPath) as? EPGCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(with: asset)
                
                return cell
                
            }
        }
        
        dataSource.supplementaryViewProvider = makeSupplementaryViewProvider(delegate: delegate)
        
        return dataSource
    }
    
    func makeLayout(dataSource: DataSource) -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { [weak dataSource] index, _ in
            guard let sectionIdentifier = dataSource?.snapshot().sectionIdentifiers[index] else { return nil }
            
            switch sectionIdentifier {
            case .logo:
                return self.createLogoSectionLayout()
            case .promotions:
                return self.createPromotionSectionLayout()
            case .category:
                return self.createCategoriesSectionLayout()
            case .moviesSeries:
                return self.createMoviesSeriesSectionLayout()
            case .liveChannel:
                return self.createLiveChannelsSeriesSectionLayout()
            case .epg:
                return self.createEPGSectionLayout()
             }
        })
    }
    
    func makeSnapshot(content: [Content]) -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        content.forEach { item in
            snapshot.appendSections([item.section])
            snapshot.appendItems(item.items, toSection: item.section)
        }
        return snapshot
    }
    
    // MARK: - Private
    private func makeSupplementaryViewProvider(delegate: Delegate) -> DataSource.SupplementaryViewProvider {
        { collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard indexPath.section < self.viewModel.sections.count else { return nil }
                let section = self.viewModel.sections[indexPath.section]
                    
                    guard let header = collectionView.dequeueReusableSupplementaryView(
                        ofKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: SectionHeaderView.id,
                        for: indexPath
                    ) as? SectionHeaderView else {
                        return nil
                    }

                    header.configure(with: section)
                    header.delegate = delegate
                    return header
                
            case UICollectionView.elementKindSectionFooter:
                guard let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: MainViewSecrtionPromoFooterView.id,
                    for: indexPath
                  ) as? MainViewSecrtionPromoFooterView else {
                    return nil
                }
                footer.configure(currentPage: self.viewModel.currentPage,
                                 pageCount: self.viewModel.pageCount,
                                 pageProvider: self.viewModel.currentPageSubject)
                return footer
                
            default:
                return nil
            }
        }
    }
    
    private func createLogoSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(18)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(18)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    private func createPromotionSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets.zero

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 24
        
        section.boundarySupplementaryItems = [makeFooter()]
        
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let rowIndex = items.last?.indexPath.row else { return }
            
            self?.viewModel.currentPageSubject.send(rowIndex)
        }
        return section
    }
    
    private func createCategoriesSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(128))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let section = NSCollectionLayoutSection(group: .vertical(layoutSize: size, subitems: [item]))
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }
    
    private func createMoviesSeriesSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let section = NSCollectionLayoutSection(group: .vertical(layoutSize: size, subitems: [item]))
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }
    
    private func createLiveChannelsSeriesSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(104))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let section = NSCollectionLayoutSection(group: .vertical(layoutSize: size, subitems: [item]))
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }
    
    private func createEPGSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(216), heightDimension: .absolute(170))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let section = NSCollectionLayoutSection(group: .vertical(layoutSize: size, subitems: [item]))
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }
    
    
    private func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(24))
        let item = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        return item
    }
    
    private func makeFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(18)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: footerSize,
          elementKind: UICollectionView.elementKindSectionFooter,
          alignment: .bottom,
          absoluteOffset: CGPoint(x: 0, y: -18)
        )
        footer.pinToVisibleBounds = true
        footer.zIndex = 2
        
        return footer
    }
}
