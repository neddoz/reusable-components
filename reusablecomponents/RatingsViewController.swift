//
//  RatingsViewController.swift
//  reusablecomponents
//
//  Created by kayeli dennis on 09/02/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit

class RatingsViewController: UIViewController {

    private enum ConstraintAttribute: String {
        case top
        case left
    }
    // MARK: private properties
    private var ratingView: RatingView!
    private lazy var ratingNib = UINib(nibName: "ratingsView", bundle: nil)

    override func viewDidLoad() {
        guard let ratingView = loadRatingView() else { return }
        super.viewDidLoad()
        activateConstraint(for: ratingView, attribute: .top)
    }

    // MARK: private methods
    private func loadRatingView()-> RatingView?{
        guard let ratingView = ratingNib.instantiate(withOwner: self,
                                                     options: nil).first as? RatingView else { return nil }
        view.addSubview(ratingView)
        return ratingView
    }

    private func activateConstraint(`for` ratingView: UIView, attribute: ConstraintAttribute){
        let attribute: NSLayoutAttribute = attribute == .top ? .top : .left
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: ratingView,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: attribute,
                           multiplier: 1.0,
                           constant: 203).isActive = true
    }
}
