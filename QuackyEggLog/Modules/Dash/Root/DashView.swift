import SwiftUI

struct DashView: View {
    
    @StateObject private var viewModel = DashViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var isShowFavoritesView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .scaleToFillAndCropp()
                
                VStack(spacing: 16) {
                    navigationView
                    randomFactSection
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 35)
                
                NavigationLink(isActive: $isShowFavoritesView) {
                    DuckDashFavoritesView(viewModel: viewModel)
                } label: {
                    EmptyView()
                }
            }
            .onAppear {
                viewModel.loadFavorites()
                isShowTabBar = true
            }
        }
    }
    
    private var navigationView: some View {
        ZStack {
            Text("DUCK DASH")
                .font(.brust(with: 35))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .lineLimit(2)
            
            HStack {
                Button {
                    isShowTabBar = false
                    isShowFavoritesView = true
                } label: {
                    Image(.Images.Buttons.unlike)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var randomFactSection: some View {
        VStack {
            VStack(spacing: 24) {
                HStack {
                    Text(viewModel.currentItem.type.rawValue)
                        .frame(height: 40)
                        .padding(.horizontal, 20)
                        .font(.brust(with: 20))
                        .foregroundStyle(.baseYellow)
                        .overlay {
                            RoundedRectangle(cornerRadius: 13)
                                .stroke(.baseYellow, lineWidth: 3)
                        }
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(viewModel.currentItem.text)
                    .font(.brust(with: 30))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                
                Button {
                    viewModel.changeFavoriteStatus(of: viewModel.currentItem)
                } label: {
                    Image(viewModel.currentItem.isFavorite ? .Images.Buttons.like : .Images.Buttons.unlike)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                }
            }
            .padding(15)
            .background(.white)
            .cornerRadius(18)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    DashView(isShowTabBar: .constant(false))
}

