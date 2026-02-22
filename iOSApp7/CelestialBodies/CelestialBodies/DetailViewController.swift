import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!

    var planet: Planet?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        subtitleLabel.numberOfLines = 0
        textView.isEditable = false
        textView.alwaysBounceVertical = true

        configure()
    }

    private func configure() {
        guard let planet else { return }

        title = planet.name

        subtitleLabel.text = "\(planet.name) • \(planet.kind)\n\(planet.subtitle)"

        let moonsText: String
        if planet.moons.isEmpty {
            moonsText = "Notable moons: None"
        } else {
            let formatted = planet.moons
                .map { "• \($0.name): \($0.fact)" }
                .joined(separator: "\n")
            moonsText = "Notable moons (up to 5):\n\(formatted)"
        }
        textView.text = "\(planet.description)\n\n\(moonsText)"
    }
}
