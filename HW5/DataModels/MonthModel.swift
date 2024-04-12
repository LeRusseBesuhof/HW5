import Foundation

struct Month : Identifiable {
    var id : String = UUID().uuidString
    var name : String
    var notes : [String]
    var image : String
    
    static func rawData() -> [[Month]] {
        [
            [
                Month(name: "December", notes: ["Demobilizaion", "Searching for a Job"], image: "dec"),
                Month(name: "January", notes: ["New Job", "Christmas party", "Learning Swift"], image: "jan"),
                Month(name: "February", notes: ["My Birthday", "Best Friend's Birthday"], image: "feb")
                
            ],
            [
                Month(name: "March", notes: ["Hanging out with my Friend", "Buying a Scooter \"Suzuki Verde\"",  "Becoming \"Error=Nil\" School Student"], image: "mar"),
                Month(name: "April", notes: ["Learning Songs on the Guitar"], image: "apr")
            ]
        ]
    }
}
