//
//  SceneDelegate.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let catsSource = CatsSource()
            let savedCats = savedCatsViewController(catsSource: catsSource)
            let listOfCats = listOfCatsViewController(catsSource: catsSource)
            let randomCat = randomCatViewController(catsSource: catsSource)
            let recognize = recognizeViewController(catsSource: catsSource)
            let tabBarController = UITabBarController()
            tabBarController.setViewControllers([randomCat, listOfCats, savedCats, recognize], animated: false)
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    private func randomCatViewController(catsSource: CatsSource) -> RandomCatViewController {
        let randomCatView = RandomCatView(source: catsSource)
        let randomCatViewController = RandomCatViewController(rootView: randomCatView)
        randomCatViewController.getCat()
        randomCatViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return randomCatViewController
    }
    
    private func listOfCatsViewController(catsSource: CatsSource) -> UIViewController {
        let listOfCatsView = ListOfCatsView(source: catsSource)
        let listController = ListOfCatsViewController(rootView: listOfCatsView)
        listController.getBreeds()
        listController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "square.stack.3d.down.right.fill"), tag: 1)
        return listController
    }
    
    private func savedCatsViewController(catsSource: CatsSource) -> UIViewController {
        let savedView = SavedCatsView(source: catsSource)
        let savedViewController = SavedCatsViewController(rootView: savedView)
        savedViewController.load()
        savedViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart.fill"), tag: 2)
        return savedViewController
    }
    
    private func recognizeViewController(catsSource: CatsSource) -> UIViewController {
        let recognizeView = RecognizeView(source: catsSource)
        let recognizeViewControlelr = RecognizeViewController(rootView: recognizeView)
        recognizeViewControlelr.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "camera.fill"), tag: 3)
        return recognizeViewControlelr
    }

}

