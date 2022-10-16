//
//  HomeTabBarController.swift
//  iMovie
//
//  Created by Sandesh on 11/05/20.
//  Copyright © 2020 sandesh. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rootVC1 = MovieListVC(collectionViewLayout: UICollectionViewFlowLayout())
        rootVC1.model = MovieListViewModel(type: .nowPlaying)
        let nowPlayingMovies = UINavigationController(rootViewController: rootVC1)
        nowPlayingMovies.tabBarItem.title = "Now Showing"
        nowPlayingMovies.tabBarItem.image = UIImage(systemName: "play.rectangle", withConfiguration: UIImage.SymbolConfiguration(scale: .medium))!
        
        let rootVC2 = MovieListVC(collectionViewLayout: UICollectionViewFlowLayout())
        rootVC2.model = MovieListViewModel(type: .topRated)
        let topRatedMovies = UINavigationController(rootViewController: rootVC2)
        topRatedMovies.tabBarItem.title = "Top Rated"
        topRatedMovies.tabBarItem.image = UIImage(systemName: "star",  withConfiguration: UIImage.SymbolConfiguration(scale: .medium))!
        
        
        
        viewControllers = [nowPlayingMovies, topRatedMovies]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.tintColor = .systemRed
        tabBar.backgroundColor = .appBackground
        tabBar.unselectedItemTintColor = .systemGray
    }
    
}
