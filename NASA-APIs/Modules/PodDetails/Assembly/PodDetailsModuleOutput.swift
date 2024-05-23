
protocol PodDetailsModuleOutput: AnyObject {
	var onFinished: (() -> Void)? { get set }
}
