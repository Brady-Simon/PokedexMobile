//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Brady Simon on 10/27/20.
//

import UIKit

class DetailViewController: UIViewController, PokemonSelectionDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = 15.0
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.borderWidth = 1.0
        
        navigationController?.navigationBar.barTintColor = .systemRed
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Layer count: \(view.layer.sublayers?.count ?? 0)")
        drawTopAccentView()
        drawBottomAccentView()
    }
    
    /// Updates the UI when the pokemon is changed.
    private func updateUI() {
//        loadViewIfNeeded()
//        view.layer.layoutSublayers()
        
        // Update the layout and image
        if let pokemon = pokemon {
            title = pokemon.name
            name?.text = pokemon.name
            height?.text = "Height: \(pokemon.height)"
            weight?.text = "Weight: \(pokemon.weight)"
            
            DispatchQueue.main.async {
                if let url = pokemon.imageUrl, let data = try? Data(contentsOf: url) {
                    self.imageView.image = UIImage(data: data)
                }
            }
            
        }
    }
    
    func updatePokemon(_ newPokemon: Pokemon) {
        pokemon = newPokemon
    }
    
    func drawTopAccentView() {
        
        let minX: CGFloat = view.frame.minX, maxX = view.frame.maxX
        let minY: CGFloat = 0//view.safeAreaInsets.top
        let maxY = minY + 50
        print("Shape: (\(minX), \(minY)), (\(maxX), \(maxY))")
        
        let path = UIBezierPath()
        path.removeAllPoints()
        path.move(to: CGPoint(x: minX, y: minY))
        path.addLine(to: CGPoint(x: maxX, y: minY))
        path.addLine(to: CGPoint(x: minX, y: maxY))
        path.close()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        
        shape.fillColor = UIColor.systemRed.cgColor
        shape.lineWidth = 0.0
        shape.zPosition = -1
        view.layer.addSublayer(shape)
    }
    
    func drawBottomAccentView() {
        
        let path = UIBezierPath()
        path.removeAllPoints()
        let y = imageView.frame.maxY - view.safeAreaInsets.top
        path.move(to: CGPoint(x: view.frame.maxX, y: y))
        path.addLine(to: CGPoint(x: view.frame.maxX, y: view.frame.maxY))
        path.addLine(to: CGPoint(x: view.frame.minX, y: view.frame.maxY))
        path.addLine(to: CGPoint(x:view.frame.minX, y: y + 50))
        path.close()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        
        shape.fillColor = UIColor.systemRed.cgColor
        shape.lineWidth = 0.0
        shape.zPosition = -1
        view.layer.addSublayer(shape)
        
    }

}
