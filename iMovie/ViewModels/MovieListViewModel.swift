//
//  MovieListVCModel.swift
//  iMovie
//
//  Created by Sandesh on 11/05/20.
//  Copyright © 2020 sandesh. All rights reserved.
//

import UIKit

protocol MovieListViewModelDelegate {
    func present(_ viewController: UIViewController)
}

protocol MovieListViewModelDataSource {
    
}


class MovieListViewModel {
    //MARK: Diffable datasource and snap shot vars
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieViewModel>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section,MovieViewModel>
    
    //raw value represents index
    enum Section: Int, CaseIterable {
        case trending = 0
        case nowPlaying = 1
        case topRated = 2
        case popular = 3
        case upcoming = 4
    }
    
    //MARK: View model
    enum MovieType {
        case nowPlaying
        case topRated
    }
    
    //MARK:- Private Vars
    private var movies: [[MovieViewModel]] {
        didSet {
            applyMovieSnapShot()
        }
    }

    private var moviesTypes: MovieType
    private var movieDataSorce: DataSource!
    
    var delegate: MovieListViewModelDelegate?
    var dataSource: MovieListViewModelDataSource?
    
    //initializer
    init(type: MovieType) {
        self.moviesTypes = type
        //TODO: - update logic to keep movies array as empty and the fill it as data comes
        self.movies = [[],[],[],[],[]]
        fetchMovieFor(section: .trending)
        fetchMovieFor(section: .nowPlaying)
        fetchMovieFor(section: .topRated)
        fetchMovieFor(section: .popular)
        fetchMovieFor(section: .upcoming)
    }
    
    //MARK:- Private Methods
    
    private func fetchMovieFor(section: Section) {
        switch section {
        case .trending:
            ApiRequset.shared.getMovie(api: .trending(.movie, .week)) { [weak self] movies in
                self?.update(movies, for: .trending)
            }
        case .nowPlaying:
            ApiRequset.shared.getMovie(api: .nowPlaying) { [weak self] movies in
                self?.update(movies, for: .nowPlaying)
            }
        case .topRated:
            ApiRequset.shared.getMovie(api: .topRated) { [weak self] movies in
                self?.update(movies, for: .topRated)
            }
        case .popular:
            ApiRequset.shared.getMovie(api: .popular) { [weak self] movies in
                self?.update(movies, for: .popular)
            }
        case .upcoming:
            ApiRequset.shared.getMovie(api: .upcoming) { [weak self] movies in
                self?.update(movies, for: .upcoming)
            }
        }
    }
    
    private func update(_ movies: [Movie], for section: Section) {
        let movieModels = movies.map { MovieViewModel(movie: $0) }
        self.movies.insert(movieModels, at: section.rawValue)
    }

    private func applyMovieSnapShot() {
        var snapShot = SnapShot()
    snapShot.appendSections([.trending, .nowPlaying, .topRated, .popular, .upcoming])
        snapShot.appendItems(movies[Section.trending.rawValue], toSection: .trending)
        snapShot.appendItems(movies[Section.nowPlaying.rawValue], toSection: .nowPlaying)
        snapShot.appendItems(movies[Section.topRated.rawValue], toSection: .topRated)
        snapShot.appendItems(movies[Section.popular.rawValue], toSection: .popular)
        snapShot.appendItems(movies[Section.upcoming.rawValue], toSection: .upcoming)

        movieDataSorce?.apply(snapShot, animatingDifferences: true)
    }
    
    //MARK:- Public Methods
    func setDataSourceFor(_ collectionView: UICollectionView) -> DataSource{
        movieDataSorce = DataSource(collectionView: collectionView) { (collectionView, indexPath, movieModel) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.IDENTIFIER, for: indexPath) as? MovieCell else {
                return nil
            }
            cell.movie = movieModel
            return cell
        }
        return movieDataSorce
    }
    
    func filterMovies(_ title: String) {
//        var filteredMovies = [MovieViewModel]()
//        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//            filteredMovies = movies
//        } else {
//            filteredMovies = movies.filter { $0.title.contains(title)}
//        }
//
//        var newSnapShot = SnapShot()
//        newSnapShot.appendSections([.main,.secondary])
//        newSnapShot.appendItems(filteredMovies,toSection: .main)
//        newSnapShot.appendItems(filteredMovies,toSection: .secondary)
//        movieDataSorce.apply(newSnapShot, animatingDifferences: true)
        
    }
    
    func viewWillAppear() {
        if !movies.isEmpty {
           applyMovieSnapShot()
        }
    }
    
    func itemSelected(at indexPath: IndexPath) {
        guard let item = movieDataSorce.itemIdentifier(for: indexPath) else {
            fatalError("Invalid IndexPath")
        }
        let detailVC = MovieDetailVC()
        detailVC.movie = item
        delegate?.present(detailVC)
    }
    
    
    //MARK:- Getters
       var title: String {
           switch moviesTypes {
           case .nowPlaying: return "Now Playing"
           case .topRated: return " Top Rated"
           }
       }
    
    var movieListType: MovieType {
        return moviesTypes
    }
}

extension MovieListViewModel : MovieCellDelegate {
    func delete(_ movie: MovieViewModel) {
//        guard let index = movies.firstIndex(of: movie) else { return }
//        movies.remove(at: index)
//        applyMovieSnapShot()
    }
}
