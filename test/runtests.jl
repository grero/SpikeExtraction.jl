using SpikeExtraction
using Test
using Random
using Statistics


@testset "tresholds" begin
    RNG = MersenneTwister(1234)
    X = randn(RNG, 1000)
    μ,σ = SpikeExtraction.get_threshold(X) 
    @test μ ≈ -0.02534297022835935
    @test σ ≈ 1.0051000347393066
end
