import UIKit

final class ResultsViewController: UIViewController {

    @IBOutlet private weak var usdLabel: UILabel!
    @IBOutlet private weak var cadLabel: UILabel!
    @IBOutlet private weak var eurLabel: UILabel!
    @IBOutlet private weak var rubLabel: UILabel!

    var usdAmount: Int = 0
    var selectedCurrencies: [Currency] = []
    var converter: Converter!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Results"
        usdLabel.text = "USD: \(usdAmount)"

        setLabel(cadLabel, visible: false)
        setLabel(eurLabel, visible: false)
        setLabel(rubLabel, visible: false)

        for currency in selectedCurrencies {
            let result = converter.convert(usd: usdAmount, to: currency)
            let formatted = format(result)

            switch currency {
            case .cad:
                cadLabel.text = "CAD: \(formatted)"
                setLabel(cadLabel, visible: true)
            case .eur:
                eurLabel.text = "EUR: \(formatted)"
                setLabel(eurLabel, visible: true)
            case .rub:
                rubLabel.text = "RUB: \(formatted)"
                setLabel(rubLabel, visible: true)
            }
        }
    }

    private func format(_ value: Double) -> String {
        String(format: "%.2f", value)
    }

    private func setLabel(_ label: UILabel, visible: Bool) {
        label.isHidden = !visible
    }
}