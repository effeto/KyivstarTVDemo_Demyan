import UIKit
import Combine

class MainViewController: UIViewController {
    // MARK: - Variables
    typealias ViewModel = MainViewModel
    typealias Coordinator = MainCoordinator
    typealias DataSourceManager = MainViewDataSourceManager
    
    private let mainView = MainView()
    private let viewModel: ViewModel
    private let coordinator: Coordinator
    private var dataSourceManager: DataSourceManager?
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init
    init(_ viewModel: ViewModel, _ coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()
        self.setupDataSource()
        self.bindViewModel()
    
    }
    
    // MARK: - Privates
    private func bindViewModel() {
        viewModel.$promotions
            .combineLatest(
                viewModel.$categories,
                viewModel.$content
            )
            .receive(on: DispatchQueue.main)
            .sink { [weak self] promotions, categories, content in
                guard let self = self,
                      let dataSource = self.dataSource,
                      let dataSourceManager = self.dataSourceManager else {
                    return
                }

                self.viewModel.sections = []

                var contentSections: [(Section, [Item])] = [
                    (Section.logo, [Item.logo]),
                    (Section.promotions, promotions.map(Item.promotion)),
                    (Section.category, categories.map(Item.category))
                ]
                self.viewModel.sections.append(contentsOf: contentSections.map(\.0))

                for group in content {
                    guard let groupId = group.id else { continue }

                    if let type = group.type.first {
                        switch type {
                        case .movies, .series:
                            let section = Section.moviesSeries(groupId, canBeDeleted: group.canBeDeleted ?? false)
                            contentSections.append((section, group.assets.map(Item.moviesSeries)))
                            self.viewModel.sections.append(section)
                        case .livechannel:
                            let section = Section.liveChannel(groupId, canBeDeleted: group.canBeDeleted ?? false)
                            contentSections.append((section, group.assets.map(Item.liveСhannels)))
                            self.viewModel.sections.append(section)
                        case .epg:
                            let section = Section.epg(groupId, canBeDeleted: group.canBeDeleted ?? false)
                            contentSections.append((section, group.assets.map(Item.epg)))
                            self.viewModel.sections.append(section)
                        case .noNeedToDisplay:
                            continue
                        }
                    }
                }

                let snapShot = dataSourceManager.makeSnapshot(content: contentSections)
                dataSource.apply(snapShot)
                self.mainView.collectionView?.reloadData()
            }
            .store(in: &cancellables)
    }



    

    private func setupViews() {
        view.addSubview(mainView)
        self.mainView.collectionView?.delegate = self
        self.setupConstraints()
    }

    private func setupConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDataSource() {
        guard let collectionView = mainView.collectionView else { return }

        dataSourceManager = MainViewDataSourceManager(collectionView: collectionView, viewModel: self.viewModel)
        self.dataSource = dataSourceManager?.makeDataSource(delegate: self)

        if let dataSourceManager = dataSourceManager, let dataSource = self.dataSource {
            collectionView.collectionViewLayout = dataSourceManager.makeLayout(dataSource: dataSource)
        }
    }
}


// MARK: - SectionHeaderViewDelegate
extension MainViewController: SectionHeaderViewDelegate {
    func sectionHeaderViewDidDelete(_ view: SectionHeaderView, section: Section) {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.deleteSections([section])
        dataSource?.apply(snapshot)
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = dataSource else { return }
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch item {
        case .moviesSeries(let asset), .liveСhannels(let asset), .epg(let asset) :
            self.coordinator.openAsset(asset: asset)
        default:
            return
        }
    }
}


