import Foundation

enum Currency: String {
    case cad = "CAD"
    case eur = "EUR"
    case rub = "RUB"

    var rateFromUSD: Double {
        switch self {
        case .cad: return 1.3618
        case .eur: return 0.8423
        case .rub: return 76.9169
        }
    }
}

struct Converter {
    func convert(usd: Int, to currency: Currency) -> Double {
        Double(usd) * currency.rateFromUSD
    }
}