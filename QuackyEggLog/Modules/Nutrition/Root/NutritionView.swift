import SwiftUI

struct NutritionView: View {
    
    @StateObject private var viewModel = NutritionViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var duckToEdit: Duck?
    @State private var isShowAddDuckView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .scaleToFillAndCropp()
                
                VStack(spacing: 16) {
                    navigationView
                    
                    if viewModel.ducks.isEmpty {
                        stumb
                    } else {
                        ducksList
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.bottom, 96)
                .animation(.easeInOut, value: viewModel.ducks)
                
                NavigationLink(isActive: $isShowAddDuckView) {
                    AddDuckView(duck: duckToEdit ?? Duck(isReal: true))
                } label: {
                    EmptyView()
                }
            }
            .onAppear {
                viewModel.loadDucs()
                isShowTabBar = true
                duckToEdit = nil
                viewModel.isCloseActiveNavigation = false
            }
            .onChange(of: viewModel.isCloseActiveNavigation) { isClose in
                if isClose {
                    isShowAddDuckView = false
                    viewModel.isCloseActiveNavigation = false 
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigationView: some View {
        Text("NUTRITION & CARE\nACCOUNTING")
            .font(.brust(with: 35))
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
            .lineLimit(2)
    }
    
    private var stumb: some View {
        VStack(spacing: 12) {
            Text("No ducks added yet")
                .font(.brust(with: 40))
                .foregroundStyle(.black)
            
            Button {
                isShowTabBar = false
                isShowAddDuckView = true
            } label: {
                Image(.Images.baseWood)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 70)
                    .overlay {
                        Text("Add a duck")
                            .font(.brust(with: 35))
                            .foregroundStyle(.white)
                    }
            }
        }
        .frame(maxHeight: .infinity)
    }
    
    private var ducksList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(viewModel.ducks) { duck in
                    NutritionDuckCellView(duck: duck) {
                        duckToEdit = duck
                        isShowTabBar = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isShowAddDuckView = true
                        }
                    } editAction: {
                        duckToEdit = duck
                        isShowTabBar = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isShowAddDuckView = true
                        }
                    } removeAction: {
                        viewModel.remove(duck)
                    }
                }
                
                Button {
                    isShowTabBar = false
                    isShowAddDuckView = true
                } label: {
                    Image(.Images.baseWood)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 70)
                        .overlay {
                            Text("Add a duck")
                                .font(.brust(with: 35))
                                .foregroundStyle(.white)
                        }
                }
            }
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    NutritionView(isShowTabBar: .constant(false))
}

