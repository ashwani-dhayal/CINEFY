import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Only setup window if not using SceneDelegate (iOS 12 and below)
        if #available(iOS 13.0, *) {
            // Use SceneDelegate for window setup
        } else {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            let splashVC = SplashViewController()
            window?.rootViewController = splashVC
            window?.makeKeyAndVisible()
           // let genreVC = MovieGenreSelectionViewController()
            //let homeVC = HomeViewController()

            //let navController = UINavigationController(rootViewController: genreVC)
           // window?.rootViewController = navController
          //  window?.makeKeyAndVisible()
            

        }
       
        
        // Set global appearance for UINavigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .black
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = .white
        
        // Set global appearance for UITabBar
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .black
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        UITabBar.appearance().tintColor = .red
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        // Create Community tab
        let communityVC = CommunityViewController()
        let communityNav = UINavigationController(rootViewController: communityVC)
        communityVC.tabBarItem = UITabBarItem(
            title: "Community",
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )
        
        // Home tab
        let homeVC = HomeViewController() // Replace with your actual HomeViewController
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        // Explore tab
        let exploreVC = ExploreViewController() // Replace with your actual ExploreViewController
        let exploreNav = UINavigationController(rootViewController: exploreVC)
        exploreVC.tabBarItem = UITabBarItem(
            title: "Explore",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        // Profile tab
        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        // Set the view controllers
        viewControllers = [homeNav, exploreNav, communityNav, profileNav]
        
        // Set selected index to Community tab (index 2)
        selectedIndex = 0
    }
}
