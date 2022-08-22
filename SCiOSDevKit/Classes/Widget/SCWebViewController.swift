//
//  SCWebViewController.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation
import SnapKit
import WebKit

private let progressKeyPath = "estimatedProgress"
private let canGoBackKeyPath = "canGoBack"

open class SCWebviewController: UIViewController {
    open var initialTitle: String?

    open var progressTintColor: UIColor = .blue {
        didSet { progressView.tintColor = progressTintColor }
    }

    open var progressBGColor: UIColor = .white {
        didSet { progressView.trackTintColor = progressBGColor }
    }

    public init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }

    private let urlString: String
    private var hasShowWeb = false

    /// 进度条
    open lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = progressTintColor
        progressView.trackTintColor = progressBGColor
        return progressView
    }()

    /// webView
    open lazy var webview: WKWebView = {
        let config = WKWebViewConfiguration()
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.backgroundColor = .white
        webview.scrollView.showsVerticalScrollIndicator = false
        webview.scrollView.showsHorizontalScrollIndicator = false
        webview.navigationDelegate = self
        webview.uiDelegate = self
        return webview
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()
        hasShowWeb = true
        configureUI()
        title = initialTitle
        loadUrl()
    }

    open func loadUrl() {
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData)
        webview.load(urlRequest)
    }

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == progressKeyPath {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webview.estimatedProgress), animated: true)
            if webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.2,
                               delay: 0.1,
                               options: UIView.AnimationOptions.curveLinear,
                               animations: {
                                   self.progressView.alpha = 0
                               }) { _ in
                    self.progressView.setProgress(0.0, animated: false)
                }
            }
        } else if keyPath == canGoBackKeyPath {
            if let newValue = change?[NSKeyValueChangeKey.newKey] as? Bool {
                navigationController?.interactivePopGestureRecognizer?.isEnabled = !newValue
            } else {
                navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }
        }
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        if hasShowWeb {
            webview.uiDelegate = nil
            webview.navigationDelegate = nil
            webview.removeObserver(self, forKeyPath: progressKeyPath)
            webview.removeObserver(self, forKeyPath: canGoBackKeyPath)
        }
    }
}

extension SCWebviewController {
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(2)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        view.addSubview(webview)
        webview.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.top.equalTo(progressView.snp.bottom)
        }

        webview.addObserver(self, forKeyPath: canGoBackKeyPath, options: .new, context: nil)
        webview.addObserver(self, forKeyPath: progressKeyPath, options: .new, context: nil)
    }
}

extension SCWebviewController: WKUIDelegate, WKNavigationDelegate {
    // MARK: - WKNavigationDelegate

    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let webTitle = webView.title,
           webTitle.isEmpty == false {
            title = webTitle
        } else {
            title = initialTitle
        }
    }
}
