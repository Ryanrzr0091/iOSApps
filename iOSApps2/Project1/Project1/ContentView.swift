import SwiftUI

struct EmojiItem: Identifiable {
    let id = UUID()
    let emoji: String
    var count: Int
}

struct ContentView: View {
    @State private var emojiItems: [EmojiItem] = [
        EmojiItem(emoji: "😀", count: 0),
        EmojiItem(emoji: "🥳", count: 0),
        EmojiItem(emoji: "🔥", count: 0),
        EmojiItem(emoji: "❤️", count: 0),
        EmojiItem(emoji: "🚀", count: 0)
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(emojiItems.indices, id: \.self) { index in
                    HStack {
                        Text(emojiItems[index].emoji)
                            .font(.largeTitle)

                        Spacer()

                        Button(action: {
                            if emojiItems[index].count > 0 {
                                emojiItems[index].count -= 1
                            }
                        }) {
                            Text("–")
                                .font(.title2)
                                .frame(width: 35, height: 35)
                                .background(Color.red.opacity(0.2))
                                .clipShape(Circle())
                        }

                        Text("\(emojiItems[index].count)")
                            .font(.title3)
                            .frame(minWidth: 40)

                        Button(action: {
                            emojiItems[index].count += 1
                        }) {
                            Text("+")
                                .font(.title2)
                                .frame(width: 35, height: 35)
                                .background(Color.green.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Emoji Counter")
        }
    }
}

#Preview {
    ContentView()
}
