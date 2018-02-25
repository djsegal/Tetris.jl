include("colors.jl")
include("depth.jl")
include("style.jl")

bundled_assets = ""

bundled_assets *= colors_asset()
bundled_assets *= depth_asset()
bundled_assets *= style_asset()
