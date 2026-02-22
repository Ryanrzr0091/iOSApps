import UIKit

final class PlanetsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let planets: [Planet] = [
        Planet(
            name: "Mercury",
            kind: "Planet",
            subtitle: "Closest planet to the Sun",
            description: "Mercury is the smallest planet and the closest to the Sun. It has extreme temperature swings and no moons.",
            moons: []
        ),
        Planet(
            name: "Venus",
            kind: "Planet",
            subtitle: "Hottest planet (runaway greenhouse)",
            description: "Venus is similar in size to Earth but has a thick CO₂ atmosphere and crushing surface pressure. It has no moons.",
            moons: []
        ),
        Planet(
            name: "Earth",
            kind: "Planet",
            subtitle: "Our home world",
            description: "Earth is the only known world with abundant liquid water on the surface and life.",
            moons: [
                Moon(name: "Moon", fact: "Stabilizes Earth's tilt and drives ocean tides.")
            ]
        ),
        Planet(
            name: "Mars",
            kind: "Planet",
            subtitle: "The red planet",
            description: "Mars is a cold desert world with the largest volcano in the Solar System (Olympus Mons).",
            moons: [
                Moon(name: "Phobos", fact: "Orbits very close to Mars and is slowly spiraling inward."),
                Moon(name: "Deimos", fact: "Smaller and farther out than Phobos.")
            ]
        ),
        Planet(
            name: "Jupiter",
            kind: "Planet",
            subtitle: "Largest planet (gas giant)",
            description: "Jupiter is the most massive planet and has intense storms including the Great Red Spot.",
            moons: [
                Moon(name: "Io", fact: "Most volcanically active body in the Solar System."),
                Moon(name: "Europa", fact: "Likely has a subsurface ocean beneath its icy crust."),
                Moon(name: "Ganymede", fact: "Largest moon in the Solar System."),
                Moon(name: "Callisto", fact: "Heavily cratered; may also have a subsurface ocean."),
                Moon(name: "Amalthea", fact: "A small inner moon discovered in 1892.")
            ]
        ),
        Planet(
            name: "Saturn",
            kind: "Planet",
            subtitle: "Famous for its rings",
            description: "Saturn is a gas giant with spectacular rings made mostly of ice particles.",
            moons: [
                Moon(name: "Titan", fact: "Has a thick atmosphere and lakes of liquid hydrocarbons."),
                Moon(name: "Enceladus", fact: "Shoots water-ice plumes from a subsurface ocean."),
                Moon(name: "Rhea", fact: "Icy moon with a heavily cratered surface."),
                Moon(name: "Iapetus", fact: "Has a striking two-tone coloration."),
                Moon(name: "Dione", fact: "Icy moon with bright wispy fractures.")
            ]
        ),
        Planet(
            name: "Uranus",
            kind: "Planet",
            subtitle: "Ice giant that rotates on its side",
            description: "Uranus has an extreme axial tilt and a cold atmosphere rich in hydrogen and helium with methane.",
            moons: [
                Moon(name: "Titania", fact: "Largest moon of Uranus."),
                Moon(name: "Oberon", fact: "Second-largest moon of Uranus."),
                Moon(name: "Ariel", fact: "Shows signs of past geologic activity."),
                Moon(name: "Umbriel", fact: "Dark surface with a mysterious bright ring feature."),
                Moon(name: "Miranda", fact: "Has bizarre cliffs and patchwork terrain.")
            ]
        ),
        Planet(
            name: "Neptune",
            kind: "Planet",
            subtitle: "Farthest planet (ice giant)",
            description: "Neptune is an ice giant with strong winds and storm systems like the historical Great Dark Spot.",
            moons: [
                Moon(name: "Triton", fact: "Large moon with a retrograde orbit; likely a captured Kuiper Belt object."),
                Moon(name: "Proteus", fact: "One of Neptune’s largest inner moons."),
                Moon(name: "Nereid", fact: "Has a highly eccentric orbit.")
            ]
        ),
        Planet(
            name: "Pluto",
            kind: "Dwarf planet",
            subtitle: "Kuiper Belt dwarf planet",
            description: "Pluto is a Kuiper Belt world with complex geology and a thin atmosphere that can freeze out.",
            moons: [
                Moon(name: "Charon", fact: "So large relative to Pluto that they form a binary-like system."),
                Moon(name: "Nix", fact: "Small moon discovered in 2005."),
                Moon(name: "Hydra", fact: "Small moon discovered in 2005."),
                Moon(name: "Kerberos", fact: "Small moon discovered in 2011."),
                Moon(name: "Styx", fact: "Small moon discovered in 2012.")
            ]
        ),
        Planet(
            name: "Ceres",
            kind: "Dwarf planet",
            subtitle: "Largest object in the asteroid belt",
            description: "Ceres is a dwarf planet in the asteroid belt. It shows evidence of ice and possible briny activity.",
            moons: []
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Planets & Moons"
        navigationItem.largeTitleDisplayMode = .never

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowDetail",
              let detailVC = segue.destination as? DetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }

        detailVC.planet = planets[indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension PlanetsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planets.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
        let planet = planets[indexPath.row]

        cell.textLabel?.text = "\(planet.name) • \(planet.kind)"
        cell.detailTextLabel?.text = planet.subtitle
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

// MARK: - UITableViewDelegate
extension PlanetsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
