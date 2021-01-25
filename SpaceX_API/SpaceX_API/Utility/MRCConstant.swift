import Foundation
import UIKit

let ProductionMode =  true

let TempEmail =  ""
let TempPass =  ""

let MainStoryboard =  "Main"
let LaunchVC = "LaunchesViewController"
let LaunchDetailsVC = "LaunchDetailViewController"

let DEVICE_WIDTH :Int =  Int(UIScreen.main.bounds.size.width)
let DEVICE_HEIGHT:Int =  Int(UIScreen.main.bounds.size.height)

let SCREEN_MAX_LENGTH = max(DEVICE_WIDTH, DEVICE_HEIGHT)
let SCREEN_MIN_LENGTH = min(DEVICE_WIDTH, DEVICE_HEIGHT)

let SF: Float = Float(SCREEN_MIN_LENGTH)/Float(320.0)


let IS_DEVICE_IPHONE = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

let IS_IPHONE_X_XS  = IS_DEVICE_IPHONE && DEVICE_WIDTH == 812
let IS_IPHONE_XR_X_MAX    = (IS_DEVICE_IPHONE && DEVICE_WIDTH == 896)

let launchesURLString = "https://api.spacexdata.com/v4/launches"

// https://api.spacexdata.com/v4/launches/abcd1234  // -> flight number, not working

let rocketURLString = "https://api.spacexdata.com/v4/rockets/" // rocket id , works https://api.spacexdata.com/v4/rockets/5e9d0d95eda69973a809d1ec


let detailURL = ""

let ErrorMeassage_K = "ErrorMeassage"
let APIError_K = "APIError"
let AppError_K = "AppError"

let BASE_DATE_STRING = "2020-01-01 0:0:0.000"
let DATE_FORMAT_1 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
let DATE_FORMAT_2 = "yyyy-MM-dd HH:mm:ss.SSS"
let DATE_FORMAT_14 = "yyyy-MM-dd'T'HH:mm:ss.SSS"
let DATE_FORMAT_13 = "yyyy-MM-dd'T'HH:mm:ss'Z'"


let COMMON_COLOR = ""
let COMMON_COLOR_BORDER = ""

let API_ERROR  = "Something went wrong. Please try again later"

let Title_TEXT = ""

enum Service{
    case UNKNOWN
    case LOGIN
}
