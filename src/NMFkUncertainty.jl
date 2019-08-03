"Execute NMFk analysis for a given of number of signals multiple times"
function uncertainty(X::AbstractArray{T,N}, nk::Integer, nreruns::Integer, nNMF::Integer=10; kw...) where {T, N}
	W = Array{Array{T, N}}(undef, nreruns)
	H = Array{Array{T, 2}}(undef, nreruns)
	fitquality = Array{T}(undef, nreruns)
	robustness = Array{T}(undef, nreruns)
	aic = Array{T}(undef, nreruns)
	for i in 1:nreruns
		@info("Rerun $(i) out of $(nreruns):")
		W[i], H[i], fitquality[i], robustness[i], aic[i] = NMFk.execute(X, nk, nNMF; kw...)
	end
	@info("Results")
	for i in 1:nreruns
		println("Signals: $(@sprintf("%2d", i)) Fit: $(@sprintf("%12.7g", fitquality[i])) Silhouette: $(@sprintf("%12.7g", robustness[i])) AIC: $(@sprintf("%12.7g", aic[i]))")
	end
	return W, H, fitquality, robustness, aic
end