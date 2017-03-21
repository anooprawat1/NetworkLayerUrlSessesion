import UIKit



class MockApiManager: ApiManager {
    
    static let manager = MockApiManager()
    var fakeCompletionHandler:completionBlock?
    
    override init() {
    }
    override func apiGetRequerst(urlString: String, parameter: [String : AnyObject]?, completionHandler: @escaping completionBlock) {
        self.fakeCompletionHandler = completionHandler
    }
    
    
    func mockMethodForCompletionHandler(isSucces:Bool,response:[String:Any],error:Error?) {
        fakeCompletionHandler!(Result.responseData(response))
    }
    
}


