import Foundation

struct Moon {
    let name: String
    let fact: String
}

struct Planet {
    let name: String
    let kind: String          // "Planet" or "Dwarf planet"
    let subtitle: String      // shows in the table cell
    let description: String   // shows on detail screen
    let moons: [Moon]         // 0–5 notable moons
}
