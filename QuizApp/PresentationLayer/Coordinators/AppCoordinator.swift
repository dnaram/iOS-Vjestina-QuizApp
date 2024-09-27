//
//  AppCoordinator.swift
//  QuizApp
//
//  Created by Andrea Stanic on 06.06.2021..
//
import UIKit

final class AppCoordinator {
    private let navigationController = UINavigationController()
    private var window: UIWindow!

    init(window: UIWindow) {
        setRootViewController()
        presentInWindow(window: window)
    }

    private func setRootViewController() {
        let restaurantListController = createRestaurantListController()
        navigationController.viewControllers = [restaurantListController]
    }

    private func createRestaurantListController() -> RestaurantListController {
        let coreDataContext = CoreDataStack(modelName: "Model").managedContext
        let restaurantDataRepository = RestaurantDataRepository(
            jsonDataSource: RestaurantJsonDataSource(),
            coreDataSource: RestaurantCoreDataSource(coreDataContext: coreDataContext))
        let restaurantUseCase = RestaurantUseCase(restaurantRepository: restaurantDataRepository)
        let presenter = RestaurantListPresenter(restaurantUseCase: restaurantUseCase, coordinator: self)
        return RestaurantListController(presenter: presenter)
    }
}


// MARK: - Navigation
extension AppCoordinator: CoordinatorProtocol {

    private func presentInWindow(window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}

