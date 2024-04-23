
import UIKit

private struct Appearance {
    static let navigationBarBigTitleFont: UIFont = .init(name: "Apple SD Gothic Neo Bold", size: 30) ?? .systemFont(ofSize: 30)
    static let navigationBarRegularTitleFont: UIFont = .init(name: "Apple SD Gothic Neo Bold", size: 18) ?? .systemFont(ofSize: 18)
    static let navigationBarBackgroundColor: UIColor = .blue
    static let navigationBarForegroundColor: UIColor = .white
}

class BaseViewController: UIViewController {

    private var configuredWithLargeTitle: Bool = false

    private var loadingViews = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupBigTitle() {
        setupBigTitleNavigationBar()
        configuredWithLargeTitle = true
    }
}

private extension BaseViewController {
    func setupBigTitleNavigationBar() {
        let bigTitleAppearance = UINavigationBarAppearance()
        bigTitleAppearance.backgroundColor = Appearance.navigationBarBackgroundColor
        bigTitleAppearance.largeTitleTextAttributes = [
            .foregroundColor: Appearance.navigationBarForegroundColor,
            .font: Appearance.navigationBarBigTitleFont
        ]
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Appearance.navigationBarForegroundColor,
        ]
        bigTitleAppearance.titleTextAttributes = regularAttributes
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = Appearance.navigationBarBackgroundColor
        compactAppearance.titleTextAttributes = regularAttributes
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.scrollEdgeAppearance = bigTitleAppearance // big navigation bar appearance
        navigationController?.navigationBar.standardAppearance = compactAppearance // standard navigation bar appearance
    }
}

extension BaseViewController {
    func showLoader() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.alpha = 0.8
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)

        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.color = .black
        activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(44)
        }
        activityIndicator.startAnimating()
        [activityIndicator, blurredEffectView].forEach { loadingViews.append($0) }
    }

    func hideLoader() {
        loadingViews.forEach {
            $0.removeFromSuperview()
        }
    }
}
