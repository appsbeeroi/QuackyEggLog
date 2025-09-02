import SwiftUI

struct DuckDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: NutritionViewModel
    
    @State var duck: Duck
    
    @State private var feedingToEdit: DuckFeeding?
    @State private var reminderToEdit: Reminder?
    
    @State private var isShowAddFeedingView = false
    @State private var isShowAddReminderView = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .scaleToFillAndCropp()
            
            VStack(spacing: 12) {
                navigationView
                
                ScrollView(showsIndicators: false) {
                    duckInfoSection
                    buttonsSection
                    
                    if !duck.feedings.isEmpty {
                        feedingSection
                    }
                    
                    if !duck.reminders.isEmpty {
                        reminderSection
                    }
                    
                    Color.clear
                        .frame(height: 50)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.default, value: duck)
            
            NavigationLink(isActive: $isShowAddFeedingView) {
                AddFeedingsView(feedings: feedingToEdit ?? DuckFeeding(isReal: true)) { feeding in
                    if let index = duck.feedings.firstIndex(where: { $0.id == feeding.id }) {
                        duck.feedings[index] = feeding
                    } else {
                        duck.feedings.append(feeding)
                    }
                }
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $isShowAddReminderView) {
                AddReminderView(reminder: reminderToEdit ?? Reminder(isReal: true)) { reminder, specificDate in
                    if reminder.frequency == .specificDates {
                        duck.specificReminderDate = specificDate
                    }
                    
                    if let index = duck.reminders.firstIndex(where: { $0.id == reminder.id }) {
                        duck.reminders[index] = reminder
                    } else {
                        duck.reminders.append(reminder)
                    }
                }
            } label: {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigationView: some View {
        HStack {
            Button {
                viewModel.save(duck)
            } label: {
                Image(.Images.Buttons.back)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 65)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 25)
        .padding(.horizontal, 35)
    }
    
    private var duckInfoSection: some View {
        VStack(spacing: 18) {
            Text(duck.name)
                .font(.brust(with: 35))
                .foregroundStyle(.black)
            
            if let image = duck.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(25)
                
                HStack {
                    Text("Breed")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.baseDarkGray)
                    
                    Text(duck.breed)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                }
                
                HStack {
                    Text("Age")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.baseDarkGray)
                    
                    Text(duck.age + " years")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                }
                
                HStack {
                    Text("Weight")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.baseDarkGray)
                    
                    Text(duck.weight + " kg")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                }
            }
            
            VStack(spacing: 8) {
                Text("Features")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.baseDarkGray)
                
                Text(duck.features)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
            }
            
            HStack(spacing: 18) {
                Button {
                    dismiss()
                } label: {
                    Image(.Images.Buttons.edit)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                }
                
                Button {
                    viewModel.remove(duck)
                } label: {
                    Image(.Images.Buttons.remove)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                }
            }
        }
        .padding(10)
        .background(.white)
        .cornerRadius(25)
        .padding(.horizontal, 35)
    }
    
    private var buttonsSection: some View {
        HStack(spacing: 6) {
            Button {
                isShowAddFeedingView = true
            } label: {
                Image(.Images.baseWood)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 45)
                    .overlay {
                        Text("+FEEDING")
                            .font(.brust(with: 25))
                            .foregroundStyle(.white)
                    }
                
                Button {
                    isShowAddReminderView = true
                } label: {
                    Image(.Images.baseWood)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 45)
                        .overlay {
                            Text("+REMINDERS")
                                .font(.brust(with: 25))
                                .foregroundStyle(.white)
                        }
                }
            }
        }
    }
    
    private var feedingSection: some View {
        VStack(spacing: 8) {
            Text("FEEDING DIARY")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.brust(with: 16))
                .foregroundStyle(.black)
            
            ForEach(duck.feedings) { feeding in
                DuckFeedingCellView(feeding: feeding) {
                    feedingToEdit = feeding
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isShowAddFeedingView = true
                    }
                } removeAction: {
                    guard let index = duck.feedings.firstIndex(where: { $0.id == feeding.id }) else { return }
                    duck.feedings.remove(at: index)
                }
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var reminderSection: some View {
        VStack(spacing: 8) {
            Text("REMINDERS")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.brust(with: 16))
                .foregroundStyle(.black)
            
            ForEach(duck.reminders) { reminder in
                DuckReminderCellView(reminder: reminder, duck: duck) {
                    reminderToEdit = reminder
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isShowAddReminderView = true
                    }
                } removeAction: {
                    guard let index = duck.reminders.firstIndex(where: { $0.id == reminder.id }) else { return }
                    duck.reminders.remove(at: index)
                }
            }
        }
        .padding(.horizontal, 35)
    }
}

#Preview {
    DuckDetailView(duck: Duck(isReal: false))
}


