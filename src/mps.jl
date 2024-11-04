struct MPS{T}
    tensors::Vector{T}
    function MPS(tensors::Vector{T}) where T<:AbstractArray
        new{T}(tensors)
    end
end

function inner_product(mps1::MPS{T}, mps2::MPS{T}) where T<:AbstractArray

    @assert length(mps1.tensors) == length(mps2.tensors)

    n_sites = length(mps1.tensors)

    num_physical_indices = n_sites
    num_bond_indices = n_sites - 1

    indices = Vector{Int}[]

    # generate indices for mps1


    eincode = OMEinsum.DynamicEinCode(indices, Int[])

    return eincode(mps1.tensors..., mps2.tensors...)
end
