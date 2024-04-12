import Foundation

struct Note : Identifiable {
    var id: String = UUID().uuidString
    var name : String = ""
    var dateOfCreation : String
    var image : String
    
    static func rawData() -> [[Note]] {
        [
            [
                Note(dateOfCreation: "01.12", image: "soldier"),
                Note(dateOfCreation: "14.12", image: "job-seeker")
            ],
            [
                Note(dateOfCreation: "07.01", image: "job"),
                Note(dateOfCreation: "09.01", image: "dance"),
                Note(dateOfCreation: "21.01", image: "programing")
            ],
            [
                Note(dateOfCreation: "14.02", image: "birthday"),
                Note(dateOfCreation: "23.02", image: "bfparty")
            ],
            [
                Note(dateOfCreation: "15.03", image: "friends"),
                Note(dateOfCreation: "17.03", image: "scooter"),
                Note(dateOfCreation: "26.03", image: "error")
            ],
            [
                Note(dateOfCreation: "01.04", image: "guitar")
            ]
        ]
    }
}
