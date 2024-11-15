import SwiftUI
import NukeUI

struct SimilarItemView: View {
    let item: SimilarItem
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                LazyImage(url: item.image) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 104, height: 156)
                            .cornerRadius(8)
                    } else {
                        Color.gray
                            .frame(width: 104, height: 156)
                            .cornerRadius(8)
                    }
                }
                
                if let purchased = item.purchased, purchased {
                    Image(.icLockedContent)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top, 8)
                        .padding(.leading, 8)
                }
            }
        }
        .frame(width: 104)
    }
}
