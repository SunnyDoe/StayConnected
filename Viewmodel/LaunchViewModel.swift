//
//  LaunchViewModel.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 28.11.24.
//
import Foundation

class LaunchViewModel {
    var onTransitionToLogin: (() -> Void)?

    func startLaunchTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.onTransitionToLogin?()
        }
    }
}
