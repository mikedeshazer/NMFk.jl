toupper(x::String, i=1) = x[1:i-1] * uppercase(x[i:i]) * x[i+1:end]

function maximumnan(X, c...; kw...)
	maximum(X[.!isnan.(X)], c...; kw...)
end

function minimumnan(X, c...; kw...)
	minimum(X[.!isnan.(X)], c...; kw...)
end

function sumnan(X, c=nothing; kw...)
	if c == nothing
		return sum(X[.!isnan.(X)]; kw...)
	else
		count = .*(size(X)[vec(collect(c))]...)
		I = isnan.(X)
		X[I] .= 0
		sX = sum(X, c; kw...)
		X[I] .= NaN
		sI = sum(I, c; kw...)
		sX[sI.==count] .= NaN
		return sX
	end
end

function ssqrnan(X)
	sum(X[.!isnan.(X)].^2)
end

function vecnormnan(X)
	vecnorm(X[.!isnan.(X)])
end

function cornan(x, y)
	isn = isnan.(x) .| isnan.(y)
	cov(x[.!isn], y[.!isn])
end