//
//  ViewController.swift
//  WeatherAppCombine
//
//  Created by Cezar_ on 13.12.22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField! {
        didSet {
            cityTextField.isEnabled = true
            cityTextField.becomeFirstResponder()
        }
    }
    @IBOutlet weak var temperatureLabel: UILabel!

    private let viewModel = TempViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.text = viewModel.city
        binding()
    }

    func binding() {
        cityTextField.textPublisher
           .assign(to: \.city, on: viewModel)
           .store(in: &cancellable)

        viewModel.$currentWeather
           .sink(receiveValue: {[weak self] currentWeather in

            self?.temperatureLabel.text =
                currentWeather.main?.temp != nil ?
                "\(Int((currentWeather.main?.temp!)!)) ºC"
                : " "}
        )
           .store(in: &cancellable)
    }

     private var cancellable = Set<AnyCancellable>()
}

extension Date {
    var dayOfTheWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }

    var hourAndDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE hh a"
        return dateFormatter.string(from: self)
    }

    var hourOfTheDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self)
    }

    var timeOfTheDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}

extension DateFormatter {
    static var shared: DateFormatter = {
        return DateFormatter()
    }()
}


