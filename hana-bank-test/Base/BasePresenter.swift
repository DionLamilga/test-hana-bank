//
//  BasePresenter.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import RxSwift
import UIKit

class BasePresenter: NSObject {
    open var bag = DisposeBag()
    
    func showAPIErrorAlert(on view: UIViewController, _ error: Error, retryHandler: (() -> Void)? = nil) {
        let message: String
        if let apiError = error as? APIError {
            message = apiError.errorDescription
        } else {
            message = error.localizedDescription
        }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        if let retry = retryHandler {
            alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
                retry()
            })
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            view.present(alert, animated: true)
        }
    }
}
