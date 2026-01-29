import UIKit

final class MoodViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mood Tracker"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    private let moodValueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private let slider: UISlider = {
        let s = UISlider()
        s.minimumValue = 0
        s.maximumValue = 100
        s.value = 50
        s.isContinuous = true
        return s
    }()

    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .automatic
        return dp
    }()

    private let saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Save Mood", for: .normal)
        b.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        b.titleLabel?.adjustsFontForContentSizeCategory = true
        b.configuration = .filled()
        return b
    }()

    private let savedEntryLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = ""
        return label
    }()

    private let contentStack: UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.spacing = 16
        st.alignment = .fill
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()

    private var currentMood: Mood {
        Mood.from(value: Int(slider.value.rounded()))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(contentStack)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(moodValueLabel)
        contentStack.addArrangedSubview(slider)
        contentStack.addArrangedSubview(datePicker)
        contentStack.addArrangedSubview(saveButton)
        contentStack.addArrangedSubview(savedEntryLabel)

        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            contentStack.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20),
            contentStack.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor, constant: -20)
        ])

        updateMoodLabel()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.updateLayoutForSize(size)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLayoutForSize(view.bounds.size)
    }

    @objc private func sliderChanged(_ sender: UISlider) {
        updateMoodLabel()
    }

    @objc private func saveTapped() {
        let mood = currentMood
        let formattedDate = Self.format(date: datePicker.date)
        savedEntryLabel.text = "On \(formattedDate), you felt \(mood.emoji)"
    }

    private func updateMoodLabel() {
        let v = Int(slider.value.rounded())
        let mood = Mood.from(value: v)
        moodValueLabel.text = "Mood (\(v)): \(mood.description) \(mood.emoji)"
    }

    private func updateLayoutForSize(_ size: CGSize) {
        if size.width > 600 {
            contentStack.layoutMargins = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
            contentStack.isLayoutMarginsRelativeArrangement = true
        } else {
            contentStack.layoutMargins = .zero
            contentStack.isLayoutMarginsRelativeArrangement = false
        }
    }

    private static func format(date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "MMMM d"
        return df.string(from: date)
    }
}

private enum Mood {
    case verySad, sad, neutral, happy, veryHappy

    var description: String {
        switch self {
        case .verySad: return "Very Sad"
        case .sad: return "Sad"
        case .neutral: return "Neutral"
        case .happy: return "Happy"
        case .veryHappy: return "Very Happy"
        }
    }

    var emoji: String {
        switch self {
        case .verySad: return "😢"
        case .sad: return "🙁"
        case .neutral: return "😐"
        case .happy: return "🙂"
        case .veryHappy: return "😄"
        }
    }

    static func from(value: Int) -> Mood {
        switch value {
        case 0...20: return .verySad
        case 21...40: return .sad
        case 41...60: return .neutral
        case 61...80: return .happy
        default: return .veryHappy
        }
    }
}