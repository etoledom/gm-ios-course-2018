
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let googleBooks = GoogleBooksService(remote: NetworkRequestImpl())
        googleBooks.search(for: "Clean code") { (response) in
            do {
                let googleBooks = try response()
                print(googleBooks)
            } catch {
                print(error)
            }
        }

        return true
    }
}

