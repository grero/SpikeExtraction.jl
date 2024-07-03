
function create_spike_shape(nstates::Integer, a::Real, b::Real, c::Real)
    x = range(0.0,stop=1.5,length=nstates)
    y = a*sin.(2*pi*x).*exp.(-(b .- x).^2/c)
    return y
end

function add_spike!(X::Vector{T}, spikeshape::Vector{T}, idx::Integer=rand(1:length(X))) where T <: Real
    peak = argmax(spikeshape)
    _idx = idx .+ (1:length(spikeshape)) .- peak 
    X[_idx] .+= spikeshape
end

function add_spikes!(X::Vector{T}, spikeshape::Vector{T};p=0.01, δ=3, rng=Random.default_rng()) where T <: Real
    peak = argmax(abs.(spikeshape))
    sidx = 1:length(spikeshape)
    last_active = 0
    idx = Int64[]
    for ii in 1:(length(X)-length(spikeshape))
        if last_active == 0
            if rand(rng) < p
                last_active = ii
                X[sidx .+ (ii-1)] .+= spikeshape
                push!(idx, ii+peak-1)
            end
        elseif ii - last_active + 1 > δ + length(spikeshape)
            last_active = 0
        end
    end        
    idx
end

