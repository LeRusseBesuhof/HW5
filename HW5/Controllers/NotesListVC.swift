import UIKit

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
            ],
            []
        ]
    }
}

class NotesListVC: UIViewController {
    
    lazy var imageName = ""
    lazy var seasonPicture : UIImageView = {
        $0.image = UIImage(named: imageName)
        return $0
    }(UIImageView(frame: CGRect(x: 147, y: (navigationController?.toolbar.frame.height ?? 0) + 58, width: 136, height: 136)))
    
    lazy var seasonName = "no title"
    lazy var seasonLabel : UILabel = {
        $0.text = seasonName
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return $0
    }(UILabel(frame: CGRect(x: 30, y: seasonPicture.frame.maxY + 27, width: view.frame.width - 60, height: 35)))
    
    private var notes = Note.rawData()
    
    lazy var names = [String]()
    lazy var sectionNumber = 0
    lazy var notesTable : UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "season")
        $0.dataSource = self
        return $0
    }(UITableView(frame: CGRect(x: 0, y: seasonLabel.frame.maxY + 40, width: view.frame.width, height: view.frame.height), style: .insetGrouped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        [seasonPicture, seasonLabel, notesTable].forEach { view.addSubview($0) }
        // view.addSubview(notesTable)
    }
}

extension NotesListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes[sectionNumber].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "season", for: indexPath)
        
        var config = cell.defaultContentConfiguration()
        let curNote = notes[indexPath.section][indexPath.row]
        print(indexPath.section, indexPath.row)
        
        config.text = names[indexPath.row]
        config.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        config.image = UIImage(named: curNote.image)
        config.imageProperties.maximumSize = CGSize(width: 56, height: 56)
        
        config.secondaryText = curNote.dateOfCreation
        
        cell.contentConfiguration = config
        return cell
    }
}

// сделал передачу заголовка секций для установки его в качестве названия раздела
