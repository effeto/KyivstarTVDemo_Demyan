import SwiftUI

struct SimilarItemsGridView: View {
    @StateObject var viewModel: AssetDetailsViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Similar")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            
            LazyVGrid(columns: columns, spacing: 8) {
                if let similar = viewModel.assetDetailsResponse?.similar {
                    ForEach(similar ,id: \.id) { item in
                        SimilarItemView(item: item)
                    }
                }
            }
            .padding(.top, 8)
        }
        .padding(.top, 16)
    }
}
