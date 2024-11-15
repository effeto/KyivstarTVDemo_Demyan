import Foundation
import UIKit
import Combine

class MainViewSecrtionPromoFooterView: UICollectionReusableView {
    // MARK: - Variables
    static let id = "HomePageControlFooterView"

    private var cancellable = Set<AnyCancellable>()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.3)
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    

    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 0
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: self.topAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Public
    func configure(currentPage: Int,
                   pageCount: Int,
                   pageProvider: PassthroughSubject<Int, Never>?) {
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = pageCount
        
        pageProvider?
            .assign(to: \.currentPage, on: pageControl)
            .store(in: &cancellable)
    }
}
