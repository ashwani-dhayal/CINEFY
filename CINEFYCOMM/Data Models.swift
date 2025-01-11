
struct Genre {
    let id: Int
    let name: String
    let image: String
}

struct MovieDiscussion {
    let movieTitle: String
    let posterImage: String
    let discussions: [Discussion]
    let fanTheories: [FanTheory]
}

struct Discussion {
    let username: String
    let comment: String
}

struct FanTheory {
    let theory: String
}


struct Movie {
    let id: Int
    let title: String
    let posterImage: String
    let hasDiscussion: Bool
}


struct User {
    let name: String
    let username: String
   // let contact: String
    let email: String
}

struct MoviePoll {
    let question: String
    let options: [PollOption]
}

struct PollOption {
    let movieTitle: String
    let votePercentage: Double
}
