import SwiftUI

struct DuckDashFavoritesView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: DashViewModel
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .scaleToFillAndCropp()
            
            VStack(spacing: 16) {
                navigationView
                
                if viewModel.favorites.isEmpty {
                    stumb
                } else {
                    favoritesList
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 35)
            .animation(.easeInOut, value: viewModel.favorites)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigationView: some View {
        ZStack {
            Text("FAVORITES")
                .font(.brust(with: 35))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .lineLimit(2)
            
            HStack {
                Button {
                     dismiss()
                } label: {
                    Image(.Images.Buttons.back)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var stumb: some View {
        VStack {
            Text("You have no data\nyet")
                .font(.brust(with: 40))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
        }
        .frame(maxHeight: .infinity)
    }
    
    private var favoritesList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 13) {
                ForEach(viewModel.favorites) { item in
                    DuckDashCellView(item: item) {
                        viewModel.changeFavoriteStatus(of: item)
                    }
                }
            }
        }
    }
}

