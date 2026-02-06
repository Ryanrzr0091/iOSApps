import Foundation

struct AdventureOption {
    let title: String
    let nextNodeID: String
}

struct AdventureNode {
    let id: String
    let narrative: String
    let options: [AdventureOption]

    let isEnding: Bool

    let isSuccess: Bool
}

struct AdventureGraph {
    let nodes: [String: AdventureNode]

    func node(with id: String) -> AdventureNode {
        guard let node = nodes[id] else {
            fatalError("AdventureGraph missing node id: \(id)")
        }
        return node
    }
}
