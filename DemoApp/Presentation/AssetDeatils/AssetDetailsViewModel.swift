import Foundation
import Combine

final class AssetDetailsViewModel: ObservableObject {
    @Published var asset: Asset
    @Published var assetDetailsResponse: AssetDetailsResponse?
    
    @Published var isFavorite: Bool = false
    
    init(asset: Asset) {
        self.asset = asset
        self.startAssetView()
    }
    
    let getAsset = GetAssetDetailsUseCases(repo: GetAssetDetailsRepositoryImpl(dataSource: GetAssetDetailsAPIImplamentation()))

    
    @MainActor
    private func getAsset() async {
        var errorMessage = ""
        
        do {
            let result = try await getAsset.execute()
            switch result {
            case .success(let asset):
                self.assetDetailsResponse = asset
            case .failure(let error):
                errorMessage = error.localizedDescription
                print("ERROR: \(errorMessage)")
            }
        } catch {
            errorMessage = error.localizedDescription
            print("ERROR: \(errorMessage)")
        }
    }
    
    public func startAssetView() {
        Task {
            await self.getAsset()

        }
    }
    
    public func favoriteAction() {
        self.isFavorite.toggle()
    }
}
