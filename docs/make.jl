using Documenter
using BoundTypes

DocMeta.setdocmeta!(BoundTypes, :DocTestSetup, :(using BoundTypes); recursive = true)

makedocs(
    modules = [BoundTypes],
    sitename = "BoundTypes.jl",
    format = Documenter.HTML(;
        repolink = "https://github.com/bhftbootcamp/BoundTypes.jl",
        canonical = "https://bhftbootcamp.github.io/BoundTypes.jl",
        edit_link = "master",
        assets = ["assets/favicon.ico"],
        sidebar_sitename = true,  # Set to 'false' if the package logo already contain its name
    ),
    pages = [
        "Home" => "index.md",
        "API Reference" => [
            "pages/bound_number.md",
            "pages/bound_string.md",
            "pages/bound_time.md",
            "pages/utils.md",
        ],
        "For Developers" => "pages/devs.md",
    ],
    warnonly = [:doctest, :missing_docs],
)

deploydocs(;
    repo = "github.com/bhftbootcamp/BoundTypes.jl",
    devbranch = "master",
    push_preview = true,
)
