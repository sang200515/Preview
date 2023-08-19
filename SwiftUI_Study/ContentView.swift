//
//  ContentView.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 12/07/2023.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var sizeObserver = ScreenSize.shared

    let data: [String] = ["Hi", "Hello", "Hey everyone"]
    let myString: String = "Hello"



    var body: some View {
        VStack (spacing: 10){

            ForEach(0..<5) { index in
                Circle()
                    .frame(height: 150)
            }
             
                .debugOverlay()



        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewResizable()
    }
}


struct Home: View {
    @StateObject private var sizeObserver = ScreenSize.shared

    var body: some View {
        VStack(spacing: 0) {
            Text("Restaurants")
                .debugOverlay()
            Text("OrdersOrdersOrdersOrdersOrdersOrdersOrdersOrdersOrders")
                .debugOverlay()
            Text("Rewards")
        }.background(.yellow)
    }
}

// Tab Button
struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    var animation: Namespace.ID

    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = title
            }
        }) {
            VStack(spacing: 6) {

                // Top indicator

                // Slide in and out Animation
                ZStack {
                    // Custom Shape
                    CustomShape()
                        .fill(Color.clear) // placeholder shape
                        .frame(width: 45, height: 6)

                    if selectedTab == title {
                        CustomShape()
                            .fill(Color("tint"))
                            .frame(width: 45, height: 6)
                            .matchedGeometryEffect(id: "Tab_Change", in: animation)
                    }
                }
                .padding(.bottom, 10)

                Image(title)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedTab == title ? Color("tint") : Color.black.opacity(0.2))
                    .frame(width: 24, height: 24)

                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(selectedTab == title ? 0.6 : 0.2))
            }
        }
    }
}

// Custom Shape
struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))

        return Path(path.cgPath)
    }
}

// Both title image name are same
var tabs = ["Home", "Restaurants", "Orders", "Rewards"]

// If you simply having Views and not that much network task means its fine
// otherwise, use this method to load data when the tab opens
class ModelView: ObservableObject {
    @Published var isOrderLoad = false
    @Published var isRestaurantLoad = false
    @Published var isRewardLoad = false

    init() {
        // load initial data
        print("Home Data Loaded")
    }

    func loadOrders() {
        print("order Loaded")
        isOrderLoad = true
    }

    func loadRestaurants() {
        print("Restaurant Loaded")
        isRestaurantLoad = true
    }

    func loadReward() {
        print("Reward Loaded")
        isRewardLoad = true
    }
}
