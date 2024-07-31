//
//  Constant.swift
//  NeoStoreApp
//
//  Created by Neosoft on 01/07/24.
//

import Foundation
import UIKit

class Constants{
    
    static var shared: Constants = Constants()
    var userBaseURL = "http://staging.php-dev.in:8844/trainingapp/api/users/"
    var baseUrl = "http://staging.php-dev.in:8844/trainingapp/api/"
    var productListingSubURL = "products/getList?product_category_id=4"
}
    enum Constant{
        enum Api{
            static let registerUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/register"
            static let loginUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/login"
            static let changePasswordUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/change"
            static let resetPasswordUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/change"
            static let myAccountUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData"
            static let forgetPasswordUrl = "http://staging.php-dev.in:8844/trainingapp/api/users/forgot"
            static let orderListApi = "http://staging.php-dev.in:8844/trainingapp/api/orderList"
            static let productDetails = "http://staging.php-dev.in:8844/trainingapp/api/products/getDetail"
            static let addToCart = "http://staging.php-dev.in:8844/trainingapp/api/addToCart"
            static let listCartItems = "http://staging.php-dev.in:8844/trainingapp/api/cart"
            static let productList = "http://staging.php-dev.in:8844/trainingapp/api/products/getList"
            static let deletingUrl = "http://staging.php-dev.in:8844/trainingapp/api/deleteCart"
            static let orderApi = "http://staging.php-dev.in:8844/trainingapp/api/order"
            static let orderDetails = "http://staging.php-dev.in:8844/trainingapp/api/orderDetail"
            static let getUserList = "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData"
            static let updateAccountDetails = "http://staging.php-dev.in:8844/trainingapp/api/users/update"
            static let ratingUrl = "http://staging.php-dev.in:8844/trainingapp/api/products/setRating"
            static let editCart = "http://staging.php-dev.in:8844/trainingapp/api/editCart"
        }
    }
        
enum Endpoint : String{
    case registerUrl = "register"
    case loginUrl = "login"
    case forgetPasswordUrl = "forgot"
    case changePasswordUrl = "change"
    case updateAccountDetails = "update"
    case myAccountUrl = "getUserData"
    case productList = "products/getList"
    case productDetails = "products/getDetail"
    case ratingUrl = "products/setRating"
    case addToCart = "addToCart"
    case deletingUrl = "deleteCart"
    case listCartItems = "cart"
    case orderApi = "order"
    case orderListApi = "orderList"
    case orderDetails = "orderDetail"
}
    

