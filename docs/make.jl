using RdJUFiles
using Documenter

DocMeta.setdocmeta!(RdJUFiles, :DocTestSetup, :(using RdJUFiles); recursive=true)

makedocs(;
    modules=[RdJUFiles],
    authors="Naoki Maeda <fnkyksj@gmail.com> and contributors",
    repo="https://github.com/nmaedajp/RdJUFiles.jl/blob/{commit}{path}#{line}",
    sitename="RdJUFiles.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://nmaedajp.github.io/RdJUFiles.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/nmaedajp/RdJUFiles.jl",
    devbranch="main",
)
