import UIKit

final class CurrencyConverter: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var usdTextField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!

    @IBOutlet private weak var cadSwitch: UISwitch!
    @IBOutlet private weak var eurSwitch: UISwitch!
    @IBOutlet private weak var rubSwitch: UISwitch!

    private let converter = Converter()
    private var usdAmount: Int = 0
    private var selectedCurrencies: [Currency] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Currency Converter"
        errorLabel.text = ""
        errorLabel.numberOfLines = 0

        usdTextField.keyboardType = .numberPad
        usdTextField.delegate = self

        addDoneToNumberPad()
    }

    @IBAction private func convertTapped(_ sender: UIButton) {
        errorLabel.text = ""

        guard let text = usdTextField.text, !text.isEmpty else {
            errorLabel.text = "Please enter an amount in USD."
            return
        }

        guard let value = Int(text) else {
            errorLabel.text = "Invalid input. Enter integers only (e.g., 25)."
            return
        }

        guard value >= 0 else {
            errorLabel.text = "Amount must be a non-negative integer."
            return
        }

        let currencies = gatherSelectedCurrencies()
        guard !currencies.isEmpty else {
            errorLabel.text = "Select at least one currency to convert."
            return
        }

        usdAmount = value
        selectedCurrencies = currencies

        performSegue(withIdentifier: "showResults", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showResults",
              let dest = segue.destination as? ResultsViewController else { return }

        dest.usdAmount = usdAmount
        dest.selectedCurrencies = selectedCurrencies
        dest.converter = converter
    }

    private func gatherSelectedCurrencies() -> [Currency] {
        var list: [Currency] = []
        if cadSwitch.isOn { list.append(.cad) }
        if eurSwitch.isOn { list.append(.eur) }
        if rubSwitch.isOn { list.append(.rub) }
        return list
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        return string.allSatisfy { $0.isNumber }
    }

    private func addDoneToNumberPad() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.items = [flex, done]
        usdTextField.inputAccessoryView = toolbar
    }

    @objc private func doneTapped() {
        usdTextField.resignFirstResponder()
    }
}