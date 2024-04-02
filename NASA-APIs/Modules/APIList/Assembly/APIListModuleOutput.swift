
protocol APIListModuleOutput {
	var onFinished: (() -> Void)? { get set }
    var onOpenAPODs: (() -> Void?)? { get set }
}
