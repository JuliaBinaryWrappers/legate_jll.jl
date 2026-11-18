using Base.BinaryPlatforms

try
    using CUDA_Runtime_jll
catch
    # during initial package installation, CUDA_Runtime_jll may not be available.
end

# every other tag that artifacts are selected on must be set before calling this
function augment_cuda_tag!(platform::Platform)
    if @isdefined(CUDA_Runtime_jll) && isdefined(CUDA_Runtime_jll, :augment_dependent!)
        # both Pkg and the JLL module include this file from the JLL's `.pkg` directory
        artifacts_toml = joinpath(@__DIR__, "..", "Artifacts.toml")
        CUDA_Runtime_jll.augment_dependent!(platform, artifacts_toml)
    elseif !haskey(platform, "cuda")
        # CUDA_Runtime_jll is missing during initial installation, or briefly older than
        # our compat bound while Pkg changes the environment. select the CPU build, if
        # any; without the tag, Pkg would select any build.
        platform["cuda"] = "none"
    end
    return platform
end

function augment_platform!(platform::Platform)
    augment_cuda_tag!(platform)
end