import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Optional background color
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Image("hiking")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 320, maxHeight: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)

                Text("A relaxing weekend hike.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
