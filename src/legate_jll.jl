# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule legate_jll
using Base
using Base: UUID
using LazyArtifacts
Base.include(@__MODULE__, joinpath("..", ".pkg", "platform_augmentation.jl"))
import JLLWrappers

JLLWrappers.@generate_main_file_header("legate")
JLLWrappers.@generate_main_file("legate", UUID("e95fb1d3-fb9e-51b5-bdb8-1a812408cac9"))
end  # module legate_jll
