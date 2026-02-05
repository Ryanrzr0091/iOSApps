enum AdventureFactory {
    static func makeGraph() -> AdventureGraph {

        // Level 1
        let start = AdventureNode(
            id: "start",
            narrative: "You wake up alone on an empty pirate ship. No crew. No captain. Just creaking timbers and a compass. What do you do?",
            options: [
                .init(title: "Sail to Tortuga", nextNodeID: "tortuga"),
                .init(title: "Sail toward the British ship on the horizon", nextNodeID: "british")
            ],
            isEnding: false,
            isSuccess: false
        )

        // Level 2A (Tortuga branch)
        let tortuga = AdventureNode(
            id: "tortuga",
            narrative: "Tortuga comes into view—loud taverns, loud cannons, louder rumors. What’s your play?",
            options: [
                .init(title: "Recruit a crew", nextNodeID: "recruit_end"),
                .init(title: "Sell the ship", nextNodeID: "sell_end")
            ],
            isEnding: false,
            isSuccess: false
        )

        // Level 2B (British branch)
        let british = AdventureNode(
            id: "british",
            narrative: "The British ship closes in. They signal you to heave to. You need a story fast.",
            options: [
                .init(title: "Claim to be a pirate and try to commandeer the vessel", nextNodeID: "pirate_end"),
                .init(title: "Claim you were captured by pirates", nextNodeID: "captured_end")
            ],
            isEnding: false,
            isSuccess: false
        )

        // Level 3 endings (all fail, per your script)
        let recruitEnd = AdventureNode(
            id: "recruit_end",
            narrative: "You recruit a crew and sail to Florida in search of Spanish Gold. You only find alligators. You die trying to become the first “Florida Man” meme.",
            options: [],
            isEnding: true,
            isSuccess: false
        )

        let sellEnd = AdventureNode(
            id: "sell_end",
            narrative: "You sell the ship and have yourself smuggled back to England. You find a job, get married, and settle down.",
            options: [],
            isEnding: true,
            isSuccess: true
        )

        let pirateEnd = AdventureNode(
            id: "pirate_end",
            narrative: "You attempt to commandeer a British Man O’ War with an 800-man crew. You fail within seconds. You really are the worst pirate ever.",
            options: [],
            isEnding: true,
            isSuccess: false
        )

        let capturedEnd = AdventureNode(
            id: "captured_end",
            narrative: "They believe you. Unfortunately you’re involuntarily enlisted into the British Navy. Assigned to a small sloop with little defenses, you are captured on your first week by actual pirates. They leave you on a deserted island.",
            options: [],
            isEnding: true,
            isSuccess: false
        )

        return AdventureGraph(nodes: [
            start.id: start,
            tortuga.id: tortuga,
            british.id: british,
            recruitEnd.id: recruitEnd,
            sellEnd.id: sellEnd,
            pirateEnd.id: pirateEnd,
            capturedEnd.id: capturedEnd
        ])
    }
}