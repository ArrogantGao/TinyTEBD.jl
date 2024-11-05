struct MPS{T}
    tensors::Vector{T}
    function MPS(tensors::Vector{T}) where T<:AbstractArray
        new{T}(tensors)
    end
end

using OMEinsum
function dagger_mps(mps::MPS{T}) where T<:AbstractArray
    # Apply complex conjugate and transpose to each tensor in the MPS
    daggered_tensors = [conj(transpose(tensor)) for tensor in mps.tensors]
    return MPS(daggered_tensors)
end


function inner_product(mps1::MPS{T}, mps2::MPS{T}) where T<:AbstractArray

    @assert length(mps1.tensors) == length(mps2.tensors)
    mps2_dagger = dagger_mps(mps2)
    n_sites = length(mps1.tensors)

    num_physical_indices = n_sites
    num_bond_indices = n_sites - 1
  
    indices = Vector{Int}[]
    # generate indices for mps1
    # mps1_indices=Vector{Int}[]
    for i in 1:n_sites
        mps11_indices=[]
        push!(mps11_indices,i)
        if i==1
            push!(mps11_indices,i+n_sites)
        
        elseif i==n_sites
            push!(mps11_indices,i+n_sites-1)
        
        else
            push!(mps11_indices,i+n_sites-1)
            push!(mps11_indices,i+n_sites)
            
        end
        push!(indices,mps11_indices)
    end

    @show indices

    # push!(indices,mps1_indices)

    # generate indices for mps2
    # mps2_indices=Vector{Int}[]
    for i in 1:n_sites
        mps22_indices=[]
        push!(mps22_indices,i)
        if i==1
            push!(mps22_indices,i+2*n_sites-1)
        elseif i==n_sites
            push!(mps22_indices,i+2*n_sites-2)
        else
            push!(mps22_indices,i+2*n_sites-1)
            push!(mps22_indices,i+2*n_sites-2)
        end
        push!(indices,mps22_indices)
    end
    # push!(indices,mps2_indices)

    @show indices
    
    eincode = OMEinsum.DynamicEinCode(indices, Int[])
    @show eincode

    nested_ein = optimize_code(eincode, uniformsize(eincode, 2), TreeSA())

    @show nested_ein

    return eincode(mps1.tensors..., mps2.tensors...)[1]#, nested_ein(mps1.tensors..., mps2.tensors...)
end
tensor1 = [1+2im 2; 1 1]
#tensor2 = [1 2; 3 4]
tensor3 = [1 1; 1 1]
mps1 = MPS([tensor1, tensor3])
mps2 = MPS([tensor1, tensor3])
result = inner_product(mps1, mps2)
println(result)
@show result
