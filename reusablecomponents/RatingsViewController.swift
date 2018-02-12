//
//  RatingsViewController.swift
//  reusablecomponents
//
//  Created by kayeli dennis on 09/02/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit

class RatingsViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var mealName: UILabel!

    //MARK: Private types
    private enum ConstraintAttribute: String {
        case top
        case left
    }

    //MARK: Instance properties
    public var mealItems: [Meal]?

    // MARK: private properties
    private var currentratingView: RatingView!
    private var nextratingView: RatingView!
    private var previousratingView: RatingView!
    private var mealIndex = 0 {
        didSet{}
    }

    private var currentLeftConstraint: NSLayoutConstraint!
    private var previousLeftConstarint: NSLayoutConstraint!
    private var nextLeftConstarint: NSLayoutConstraint!

    private let currentLeftOffset: CGFloat = 20
    private let nextLeftOffset: CGFloat = 356
    private let previousLeftOffset: CGFloat = -316

    private lazy var ratingNib = UINib(nibName: "ratingsView", bundle: nil)

    override func viewDidLoad() {
        guard let curentratingView = loadRatingView(),
            let nextRatingView = loadRatingView(),
            let previousratingView = loadRatingView() else { return }
        super.viewDidLoad()

        // MARK: Top Constraints for our rating views
        activateConstraint(for: curentratingView, attribute: .top, offset: nil)
        activateConstraint(for: nextRatingView, attribute: .top, offset: nil)
        activateConstraint(for: previousratingView, attribute: .top, offset: nil)

        // MARK: Left Constraints for our rating Views
        activateConstraint(for: curentratingView, attribute: .left, offset: currentLeftOffset)
        activateConstraint(for: nextRatingView, attribute: .left, offset: nextLeftOffset)
        activateConstraint(for: previousratingView, attribute: .left, offset: previousLeftOffset)

        // Bind Data
        bindView()
    }

    // MARK: private methods
    private func loadRatingView()-> RatingView?{
        guard let currentratingView = ratingNib.instantiate(withOwner: self,
                                                     options: nil).first as? RatingView else { return nil }
        view.addSubview(currentratingView)
        return currentratingView
    }

    private func activateConstraint(`for` ratingView: UIView, attribute: ConstraintAttribute, offset: CGFloat?){
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        let attribute: NSLayoutAttribute = attribute == .top ? .top : .left
        // default constant when setting the top constraint
        var constant: CGFloat = 203
        // Optionally change the constatant if we are setting the left constaraints
        if let offset = offset { constant = offset }
        NSLayoutConstraint(item: ratingView,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: attribute,
                           multiplier: 1.0,
                           constant: constant).isActive = true
    }

    private func bindView(){
        guard let meals = mealItems else { return }
        let currentMeal = meals[mealIndex]
        self.mealName.text = currentMeal.name
    }
}
