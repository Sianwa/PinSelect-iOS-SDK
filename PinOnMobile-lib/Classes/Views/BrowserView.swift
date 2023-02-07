import UIKit
import WebKit


class BrowserView: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var webCardinalURL: URL!
    
    convenience init(webCardinalURL:URL){
        self.init()
        self.webCardinalURL = webCardinalURL
    }
    
    override func loadView() {
        debugPrint("loading....")
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        debugPrint("loaded....")
        super.viewDidLoad()
        webView.load(URLRequest(url: webCardinalURL))
    }
}
