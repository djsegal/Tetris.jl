include("colors.jl")
include("depth.jl")
include("style.jl")

bundled_assets = ""

bundled_assets *= colors_asset()
bundled_assets *= depth_asset()
bundled_assets *= style_asset()

bundled_assets *= """
  <script class="cs-step-script">
    \$(".cs-step-script").parent().css("padding", 0);
  </script>
"""
