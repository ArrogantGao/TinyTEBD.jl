using TinyTEBD
using Test

@testset "TinyTEBD.jl" begin
    tensor1 = [1 1; 1 1]
    tensor2 = [1 1; 1 1]
    mps1 = TinyTEBD.MPS([tensor1, tensor2])
    mps2 = TinyTEBD.MPS([tensor1, tensor2])
    result = TinyTEBD.inner_product(mps1, mps2)
    expected_value = 16.0
    @test result ≈ expected_value
end
