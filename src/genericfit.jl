# generic functions for distribution fitting

function suffstats(dt::Type{D}, xs...) where D<:Distribution
    argtypes = tuple(D, map(typeof, xs)...)
    error("suffstats is not implemented for $argtypes.")
end

"""
    fit_mle(D, x)

Fit a distribution of type `D` to a given data set `x`.

- For univariate distribution, x can be an array of arbitrary size.
- For multivariate distribution, x should be a matrix, where each column is a sample.
"""
fit_mle(D, x)

"""
    fit_mle(D, x, w)

Fit a distribution of type `D` to a weighted data set `x`, with weights given by `w`.

Here, `w` should be an array with length `n`, where `n` is the number of samples contained in `x`.
"""
fit_mle(D, x, w)

fit_mle(dt::Type{D}, x::AbstractArray) where {D<:UnivariateDistribution} = fit_mle(D, suffstats(D, x))
fit_mle(dt::Type{D}, x::AbstractArray, w::AbstractArray) where {D<:UnivariateDistribution} = fit_mle(D, suffstats(D, x, w))

fit_mle(dt::Type{D}, x::AbstractMatrix) where {D<:MultivariateDistribution} = fit_mle(D, suffstats(D, x))
fit_mle(dt::Type{D}, x::AbstractMatrix, w::AbstractArray) where {D<:MultivariateDistribution} = fit_mle(D, suffstats(D, x, w))

"""
    fit(D, args...)

Fit a distribution of type `D` to `args`.

The fit function will choose a reasonable way to fit the distribution, which,
in most cases, is maximum likelihood estimation. Note that this algorithm may
change; for a function that will behave consistently across versions, see 
`fit_mle`.

By default, the fallback is [`fit_mle(D, args...)`](@ref); developers can change this default
for a specific distribution type `D <: Distribution` by defining a `fit(::Type{D}, args...)` method.
"""
fit(dt::Type{D}, x) where {D<:Distribution} = fit_mle(D, x)
fit(dt::Type{D}, args...) where {D<:Distribution} = fit_mle(D, args...)
