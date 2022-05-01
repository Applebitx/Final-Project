//
//  Location.swift
//  Final Project
//
//  Created by Денис Сторожик on 01.05.2022.
//

import Foundation
// Autorization check/request
// Location request

//    private func locationUpdate() {
//        let alertController = UIAlertController(title: "TITLE", message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)
//
//           let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
//               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                   return
//               }
//               if UIApplication.shared.canOpenURL(settingsUrl) {
//                   UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
//                }
//           }
//           let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//
//           alertController.addAction(cancelAction)
//           alertController.addAction(settingsAction)
//
//
//        switch locationManager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//            locationManager.startUpdatingLocation()
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .denied:
//            self.present(alertController, animated: true, completion: nil)
//        case .restricted:
//            self.present(alertController, animated: true, completion: nil)
//        default:
//            break
//        }
//    }


//let alert = UIAlertController(title: "Notice", message: "Please go to Settings and turn on the permissions", preferredStyle: UIAlertController.Style.alert)
//
//// add the actions (buttons)
//alert.addAction(UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
//                   guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                       return
//                   }
//                   if UIApplication.shared.canOpenURL(settingsUrl) {
//                       UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
//                    }
//               }
//alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
//
//// show the alert
//self.present(alert, animated: true, completion: nil)
//}
