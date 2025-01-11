import UIKit

class ExploreViewController: UIViewController, UISearchBarDelegate {

    private let gridView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .black
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()

    private var data: [String] = []
    private var filteredData: [String] = []
    private var isSearching = false

    private var posterImages: [[String]] = [
        ["topgun", "kill", "devara", "emergency"],
        ["fighter", "singham", "jigra", "topgun"],
        ["RRR", "YODHA", "DANGAL", "kill"],
        ["laapta", "kill", "topgun", "atal"],
        ["kraven", "ramayana", "subha", "topgun"]
    ]

    private let categories: [(image: String, title: String)] = [
        ("scifigenre", "Scifi"),
        ("horrorgenre", "Horror"),
        ("mysterygenre", "Mystery"),
        ("actiongenre", "Action"),
        ("dramagenre", "Drama"),
        ("comedygenre", "Comedy")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        setupData()
    }

    private func setupUI() {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        // Create a stack view for arranging the search bar, gridView, and tableView
        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        // Create the search bar
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search items"
        searchBar.barStyle = .black
        contentStackView.addArrangedSubview(searchBar)

        // Set up the grid view
        setupGridView()
        contentStackView.addArrangedSubview(gridView)

        // Add the table view to the stack view
        contentStackView.addArrangedSubview(tableView)

        // Set constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Set constraints for the stack view inside the scroll view
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Set height constraints for gridView
        NSLayoutConstraint.activate([
            gridView.heightAnchor.constraint(equalToConstant: 400)
        ])

        // Set table view height dynamically based on content
        tableView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func setupGridView() {
        let gridStackView = UIStackView()
        gridStackView.axis = .vertical
        gridStackView.spacing = 10
        gridStackView.distribution = .fillEqually
        gridStackView.translatesAutoresizingMaskIntoConstraints = false
        gridView.addSubview(gridStackView)

        NSLayoutConstraint.activate([
            gridStackView.topAnchor.constraint(equalTo: gridView.topAnchor),
            gridStackView.leadingAnchor.constraint(equalTo: gridView.leadingAnchor),
            gridStackView.trailingAnchor.constraint(equalTo: gridView.trailingAnchor),
            gridStackView.bottomAnchor.constraint(equalTo: gridView.bottomAnchor)
        ])

        for row in 0..<3 { // 3 rows
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 10
            rowStackView.distribution = .fillEqually
            rowStackView.translatesAutoresizingMaskIntoConstraints = false
            gridStackView.addArrangedSubview(rowStackView)

            for col in 0..<2 { // 2 columns per row
                let index = row * 2 + col
                guard index < categories.count else { break }

                let categoryView = UIView()
                categoryView.layer.cornerRadius = 10
                categoryView.clipsToBounds = true
                categoryView.tag = index // Assign a tag for identification

                let imageView = UIImageView(image: UIImage(named: categories[index].image))
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.translatesAutoresizingMaskIntoConstraints = false

                let label = UILabel()
                label.text = categories[index].title
                label.textColor = .white
                label.font = UIFont.boldSystemFont(ofSize: 16)
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false

                // Add the image view and label to the category view
                categoryView.addSubview(imageView)
                categoryView.addSubview(label)

                NSLayoutConstraint.activate([
                    // ImageView constraints
                    imageView.topAnchor.constraint(equalTo: categoryView.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: categoryView.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: categoryView.bottomAnchor),

                    // Label constraints (centered vertically)
                    label.centerXAnchor.constraint(equalTo: categoryView.centerXAnchor),
                    label.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor)
                ])

                // Add tap gesture recognizer to categoryView
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCategoryTap(_:)))
                categoryView.addGestureRecognizer(tapGesture)
                categoryView.isUserInteractionEnabled = true

                rowStackView.addArrangedSubview(categoryView)
            }
        }
    }
    @objc private func handleCategoryTap(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        let categoryIndex = view.tag
        let category = categories[categoryIndex]

        if category.title == "Scifi" {
            let sciFiVC = SciFiViewController() // Initialize your SciFiViewController
            navigationController?.pushViewController(sciFiVC, animated: true)
        } else {
            print("Category tapped: \(category.title)")
            // Handle other categories if needed
        }
    }

    private func setupData() {
        data = []
        filteredData = data
    }

    // MARK: - UISearchBarDelegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredData = data
        } else {
            isSearching = true
            filteredData = data.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        filteredData = data
        tableView.reloadData()
    }
}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count + 5  // Adding 5 for the horizontal scroll sections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Display movie title text
        if indexPath.row < filteredData.count {
            cell.textLabel?.text = filteredData[indexPath.row]
        } else {
            let sectionIndex = indexPath.row - filteredData.count
            setupHorizontalScrollView(forCell: cell, atSection: sectionIndex)
        }

        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }

    func setupHorizontalScrollView(forCell cell: UITableViewCell, atSection sectionIndex: Int) {
        // Create a container stack view for the scroll view and label
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.spacing = 30 // Add more space between scroll views
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(containerStackView)

        // Create the label for each section
        let label = UILabel()
        switch sectionIndex {
        case 0:
            label.text = "Latest Pictures"
        case 1:
            label.text = "Global Hits"
        case 2:
            label.text = "Best of the Year"
        case 3:
            label.text = "Top Box Office"
        case 4:
            label.text = "For you"
        default:
            label.text = "Featured"
        }
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.addArrangedSubview(label)

        // Create the scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.addArrangedSubview(scrollView)

        // Create a horizontal stack view to hold the images
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20 // Add more space between images
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        // Add images to the stack view
        for imageName in posterImages[sectionIndex] {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true

            // Increase the size of the images
            imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true  // Increased height
            imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true   // Increased width
            stackView.addArrangedSubview(imageView)
        }

        // Constraints for the container stack view
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: sectionIndex == 0 ? 10 : 20), // Top margin for first scroll
            containerStackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),
            containerStackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),
            containerStackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: sectionIndex == posterImages.count - 1 ? 40 : 20), // Larger bottom margin for the last one
        ])

        // Constraints for the scroll view and stack view
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalToConstant: 220),  // Adjust the height of the scroll view to fit the new image size
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected: \(filteredData[indexPath.row])")
    }
}
