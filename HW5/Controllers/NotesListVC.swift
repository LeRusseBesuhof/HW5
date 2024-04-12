import UIKit

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
    }
}

extension NotesListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes[sectionNumber].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "season", for: indexPath)
        
        let curNote = notes[sectionNumber][indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        cell.contentConfiguration = config.setGetConfigBy(text: names[indexPath.row], secondaryText: curNote.dateOfCreation, image: curNote.image)
        
        return cell
    }
}

extension NotesListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "My Events" }
}
