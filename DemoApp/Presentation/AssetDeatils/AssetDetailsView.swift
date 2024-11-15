import SwiftUI
import Combine
import NukeUI

struct AssetDetailsView: View {
    // MARK: - Variables
    @StateObject var viewModel: AssetDetailsViewModel
    let hostingOutputSubject = PassthroughSubject<AssetDetailsViewHostingAction, Never>()
    
    // MARK: - Body
    var body: some View {
        VStack {
            self.titleImageView
            self.buttonsView
            self.dividerView
            self.contentScrollView
            Spacer()
        }
    }
    
    // MARK: - Title Image View
    private var titleImageView: some View {
        return VStack {
            ZStack(alignment: .topLeading) {
                if let url = self.viewModel.assetDetailsResponse?.image {
                    LazyImage(url: url) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 221)
                                .clipped()
                        } else {
                            Rectangle()
                                .foregroundStyle(.gray)
                                .frame(height: 221)
                        }
                    }
                } else {
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(height: 221)
                }
                
                    HStack {
                        Button {
                            hostingOutputSubject.send(.dismiss)
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                        }
                        .frame(width: 40, height: 40)

                        Spacer()
                    }
                    .padding(.leading, 24)
                    .padding(.top, 4)
                
                Spacer()
            }
        }
    }
    
    // MARK: - Buttons View
    private var buttonsView: some View {
        HStack() {
            playButtonView
            Spacer()
            addToFavoritesButtonView
        }
        .padding(.horizontal, 24)
        .padding(.top, 12)
    }
    
    // MARK: - Play Button View
    var playButtonView: some View {
            Button(action: {
                hostingOutputSubject.send(.play)
            }) {
                ZStack() {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "229FFF"), lineWidth: 1)
                        .frame(width: 130, height: 37)
                        .offset(y: -1)
                        .zIndex(1)
          
                    HStack(spacing: 16) {
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.white)
                        
                        Text("Play")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 4)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "0063C6"))
                            .frame(width: 130, height: 40)
                    )
                    .zIndex(0)
                }
            }
        }
    
    // MARK: - Add To Favorites Button View
    var addToFavoritesButtonView: some View {
            Button(action: {
                hostingOutputSubject.send(.favorite)
            }) {
                ZStack() {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(self.viewModel.isFavorite ? Color(hex: "229FFF") : Color.white, lineWidth: 1)
                        .frame(width: 66,  height: 37)
                        .offset(y: -1)
                        .zIndex(1)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(self.viewModel.isFavorite ? Color(hex: "F4FF5F") : Color(hex: "313D54"))
                    }
                    .padding(.bottom, 4)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(self.viewModel.isFavorite ? Color(hex: "0063C6") : Color(hex: "E9E7E7"))
                            .frame(width: 66, height: 40)
                    )
                    .zIndex(0)
                }
            }
        }
    
    // MARK: - Divider View
    private var dividerView: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(height: 1)
            .foregroundStyle(Color(hex: "E9E7E7"))
            .padding(.horizontal, 24)
            .padding(.top, 16)
    }
        
    // MARK: - Content Scroll View
    private var contentScrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                if let name = self.viewModel.assetDetailsResponse?.name, name != "" {
                    self.titleNameText(name: name)
                }
                
                if let duration = self.viewModel.assetDetailsResponse?.duration, duration != 0 {
                    self.titleInfoText(duration: duration)
                }
                
                if let description = self.viewModel.assetDetailsResponse?.description, description != "" {
                    self.titleDescriptionText(description: description)
                }
                
                SimilarItemsGridView(viewModel: self.viewModel)
            }
        }
        .padding(.top, 12)
        .padding(.horizontal, 24)
    }
    
    // MARK: - Title Name Text
    private func titleNameText(name: String) -> some View {
        HStack {
            Text(self.viewModel.assetDetailsResponse?.name ?? "")
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
    
    // MARK: - Title Info Text
    private func titleInfoText(duration: Int) -> some View {
        let infoString = "Adventure • \(duration.toTimeString()) • 2020"
        
        return HStack {
            Text(infoString)
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color(hex: "313D54"))
            Spacer()
        }
        .padding(.top, 4)
    }
    
    // MARK: - Title Description Text
    private func titleDescriptionText(description: String) -> some View {
        return HStack {
            Text(description)
                .font(.system(size: 12, weight: .regular))
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color(hex: "808890"))
            Spacer()
        }
        .padding(.top, 8)
    }
}
