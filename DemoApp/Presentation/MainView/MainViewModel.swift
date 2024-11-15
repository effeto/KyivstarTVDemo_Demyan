import UIKit
import Combine

class MainViewModel {
    // MARK: - Variables
    typealias SectionItem = Item
    
    @Published var categories: [Category] = []
    @Published var promotions: [Promotion] = []
    @Published var content: [ContentGroupsResponse] = []
    var sections: [Section] = []
    
    var currentPageSubject = PassthroughSubject<Int, Never>()
    private var cancellable = Set<AnyCancellable>()

    var currentPage = 0
    
    var pageCount: Int {
        promotions.count
    }
    
    // MARK: - Init
    init() {
        self.startMainView()
        self.internalBinding()

    }
    
    // MARK: - Networking
    let getPromotion = GetPromotionsUseCases(repo: GetPromotionsRepositoryImpl(dataSource: GetPromotionsAPIImplamentation()))
    let getCategories = GetCategoriesUseCases(repo: GetCategoriesRepositoryImpl(dataSource: GetCategoriesAPIImplamentation()))
    let getContent = GetContentGroupsUseCases(repo: GetContentGroupsRepositoryImpl(dataSource: GetContentGroupsAPIImplamentation()))
    
    @MainActor
    private func getPromotion() async {
        var errorMessage = ""
        do {
            let result = try await getPromotion.execute()
            switch result {
            case .success(let success):
                if let promotions = success.promotions {
                    self.promotions.append(contentsOf: promotions)
                }
            case .failure(let error):
                errorMessage = error.localizedDescription
                print("ERROR: \(errorMessage)")
            }
        } catch {
            errorMessage = error.localizedDescription
            print("ERROR: \(errorMessage)")
        }
    }
    
    @MainActor
    private func getCategories() async {
        var errorMessage = ""
        do {
            let result = try await getCategories.execute()
            switch result {
            case .success(let success):
                if let categories = success.categories {
                    self.categories.append(contentsOf: categories)
                }
            case .failure(let error):
                errorMessage = error.localizedDescription
                print("ERROR: \(errorMessage)")
            }
        } catch {
            errorMessage = error.localizedDescription
            print("ERROR: \(errorMessage)")
        }
    }
    
    @MainActor
    private func getContent() async {
        var errorMessage = ""
        do {
            let result = try await getContent.execute()
            switch result {
            case .success(let success):
                self.content.append(contentsOf: success)
            case .failure(let error):
                errorMessage = error.localizedDescription
                print("ERROR: \(errorMessage)")
            }
        } catch {
            errorMessage = error.localizedDescription
            print("ERROR: \(errorMessage)")
        }
    }
    
    func startMainView() {
        Task {
            await self.getPromotion()
            await self.getCategories()
            await self.getContent()
        }
    }
    

    // MARK: - Promo Pager View
    private func internalBinding() {
        currentPageSubject.sink { [weak self] value in
            self?.currentPage = value
        }.store(in: &cancellable)
    }
}
