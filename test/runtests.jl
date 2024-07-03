using SpikeExtraction
using Test
using Random
using StableRNGs
using Statistics

@testset "tresholds" begin
    RNG = StableRNG(1234)
    X = randn(RNG, 1000)
    μ,σ = SpikeExtraction.get_threshold(X) 
    @test μ ≈ -0.007811596994466759
    @test σ ≈ 1.0104186192194744
end

@testset "extraction" begin
    rng = StableRNG(1234)
   # create some simple spikes
    spikeshape1 = SpikeExtraction.create_spike_shape(60,3.0, 0.8, 0.2)
    spikeshape2 = SpikeExtraction.create_spike_shape(60,4.0, 0.3, 0.2)
    N = 1000
    X = 0.1*randn(rng, 1000)
    idx = SpikeExtraction.add_spikes!(X, spikeshape1;rng=rng)
    pidx,wf = SpikeExtraction.extract_spikes(X;θ=3,only_negative=true)

    # NOTE: we don't have pidx == idx because the noise sometimes shifts the peak 
    # by a point or two
    @test length(pidx) == length(idx)
    @test maximum(abs.(pidx .- idx)) == 2
    @test pidx == [268, 390, 470, 563, 692, 785, 869, 961] 
end
