import UIKit

final class CalculatorView: UIViewController {

    private enum Theme {
        static let nasaBlue = UIColor(red: 11/255, green: 61/255, blue: 145/255, alpha: 0.92)
        static let panelOverlay = UIColor(white: 0.06, alpha: 0.55)
        static let border = UIColor(white: 1.0, alpha: 0.10)
        static let shadowColor = UIColor.black.cgColor
    }

    private let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.layer.cornerRadius = 26
        v.layer.borderWidth = 1
        v.layer.borderColor = Theme.border.cgColor
        v.layer.shadowColor = Theme.shadowColor
        v.layer.shadowOpacity = 0.18
        v.layer.shadowRadius = 22
        v.layer.shadowOffset = CGSize(width: 0, height: 14)
        v.clipsToBounds = false
        return v
    }()

    private let starfield = Starfield()

    private let panelOverlayView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Theme.panelOverlay
        v.isUserInteractionEnabled = false
        return v
    }()

    private let clippedContentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.layer.cornerRadius = 26
        v.clipsToBounds = true
        return v
    }()

    private let rootStack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 12
        s.distribution = .fill
        s.alignment = .fill
        return s
    }()

    private let displayContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0.04, alpha: 0.62)
        v.layer.cornerRadius = 18
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor(white: 1.0, alpha: 0.10).cgColor
        return v
    }()

    private let displayLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.textColor = UIColor(white: 0.97, alpha: 1.0)
        l.text = "0"
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.35
        l.numberOfLines = 1
        l.font = UIFont.monospacedDigitSystemFont(ofSize: 56, weight: .semibold)
        return l
    }()

    private let keypadStack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 10
        s.distribution = .fillEqually
        s.alignment = .fill
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        setupLayout()
        buildKeypad()
    }

    private func setupScreen() {
        view.backgroundColor = .white
    }

    private func setupLayout() {
        let safe = view.safeAreaLayoutGuide

        view.addSubview(containerView)
        containerView.addSubview(clippedContentView)

        clippedContentView.addSubview(starfield)
        clippedContentView.addSubview(panelOverlayView)

        clippedContentView.addSubview(rootStack)
        rootStack.addArrangedSubview(displayContainer)
        rootStack.addArrangedSubview(keypadStack)
        displayContainer.addSubview(displayLabel)

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: safe.centerYAnchor),

            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: safe.leadingAnchor, constant: 18),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: safe.trailingAnchor, constant: -18),
            containerView.topAnchor.constraint(greaterThanOrEqualTo: safe.topAnchor, constant: 18),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: safe.bottomAnchor, constant: -18),

            containerView.widthAnchor.constraint(lessThanOrEqualToConstant: 560),
            containerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 320),

            containerView.heightAnchor.constraint(lessThanOrEqualTo: safe.heightAnchor, multiplier: 0.92),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 520)
        ])

        NSLayoutConstraint.activate([
            clippedContentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            clippedContentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            clippedContentView.topAnchor.constraint(equalTo: containerView.topAnchor),
            clippedContentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        starfield.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starfield.leadingAnchor.constraint(equalTo: clippedContentView.leadingAnchor),
            starfield.trailingAnchor.constraint(equalTo: clippedContentView.trailingAnchor),
            starfield.topAnchor.constraint(equalTo: clippedContentView.topAnchor),
            starfield.bottomAnchor.constraint(equalTo: clippedContentView.bottomAnchor),

            panelOverlayView.leadingAnchor.constraint(equalTo: clippedContentView.leadingAnchor),
            panelOverlayView.trailingAnchor.constraint(equalTo: clippedContentView.trailingAnchor),
            panelOverlayView.topAnchor.constraint(equalTo: clippedContentView.topAnchor),
            panelOverlayView.bottomAnchor.constraint(equalTo: clippedContentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            rootStack.leadingAnchor.constraint(equalTo: clippedContentView.leadingAnchor, constant: 16),
            rootStack.trailingAnchor.constraint(equalTo: clippedContentView.trailingAnchor, constant: -16),
            rootStack.topAnchor.constraint(equalTo: clippedContentView.topAnchor, constant: 16),
            rootStack.bottomAnchor.constraint(equalTo: clippedContentView.bottomAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            displayLabel.leadingAnchor.constraint(equalTo: displayContainer.leadingAnchor, constant: 16),
            displayLabel.trailingAnchor.constraint(equalTo: displayContainer.trailingAnchor, constant: -16),
            displayLabel.topAnchor.constraint(equalTo: displayContainer.topAnchor, constant: 14),
            displayLabel.bottomAnchor.constraint(equalTo: displayContainer.bottomAnchor, constant: -14),

            displayContainer.heightAnchor.constraint(equalToConstant: 105)
        ])
    }

    private func buildKeypad() {
        let rows: [[Key]] = [
            [.function("AC"), .function("±"), .function("%"), .op("÷")],
            [.digit("7"), .digit("8"), .digit("9"), .op("×")],
            [.digit("4"), .digit("5"), .digit("6"), .op("−")],
            [.digit("1"), .digit("2"), .digit("3"), .op("+")],
            [.digit("0"), .digit("."), .op("=")]
        ]

        for (idx, keys) in rows.enumerated() {
            let row = UIStackView()
            row.axis = .horizontal
            row.spacing = 10
            row.alignment = .fill

            if idx == rows.count - 1 {
                row.distribution = .fill

                let zero = makeButton(for: keys[0])
                let dot = makeButton(for: keys[1])
                let equals = makeButton(for: keys[2])

                row.addArrangedSubview(zero)
                row.addArrangedSubview(dot)
                row.addArrangedSubview(equals)

                dot.widthAnchor.constraint(equalTo: equals.widthAnchor).isActive = true
                zero.widthAnchor.constraint(equalTo: dot.widthAnchor, multiplier: 2.0, constant: row.spacing).isActive = true

            } else {
                row.distribution = .fillEqually
                for key in keys {
                    row.addArrangedSubview(makeButton(for: key))
                }
            }

            keypadStack.addArrangedSubview(row)
        }
    }

    private func makeButton(for key: Key) -> UIButton {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle(key.title, for: .normal)

        b.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)

        b.layer.cornerRadius = 16
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor(white: 1.0, alpha: 0.10).cgColor

        switch key.kind {
        case .digit:
            b.backgroundColor = UIColor(white: 0.11, alpha: 0.72)
            b.setTitleColor(UIColor(white: 0.96, alpha: 1.0), for: .normal)
        case .function:
            b.backgroundColor = UIColor(white: 0.18, alpha: 0.70)
            b.setTitleColor(UIColor(white: 0.96, alpha: 1.0), for: .normal)
        case .op:
            b.backgroundColor = Theme.nasaBlue
            b.setTitleColor(.white, for: .normal)
        }

        b.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)

        b.heightAnchor.constraint(greaterThanOrEqualToConstant: 54).isActive = true

        return b
    }

    @objc private func tap(_ sender: UIButton) {
        UIView.animate(withDuration: 0.08, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            sender.alpha = 0.92
        }, completion: { _ in
            UIView.animate(withDuration: 0.10) {
                sender.transform = .identity
                sender.alpha = 1.0
            }
        })
    }
}

private enum KeyKind { case digit, function, op }

private struct Key {
    let title: String
    let kind: KeyKind

    static func digit(_ t: String) -> Key { .init(title: t, kind: .digit) }
    static func function(_ t: String) -> Key { .init(title: t, kind: .function) }
    static func op(_ t: String) -> Key { .init(title: t, kind: .op) }
}