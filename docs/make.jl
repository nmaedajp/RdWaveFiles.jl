using RdWaveFiles
using Documenter

DocMeta.setdocmeta!(RdWaveFiles, :DocTestSetup, :(using RdWaveFiles); recursive=true)

makedocs(;
    modules=[RdWaveFiles],
    authors="Naoki Maeda <fnkyksj@gmail.com> and contributors",
    repo="https://github.com/nmaedajp/RdWaveFiles.jl/blob/{commit}{path}#{line}",
    sitename="RdWaveFiles.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://nmaedajp.github.io/RdWaveFiles.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/nmaedajp/RdWaveFiles.jl",
    devbranch="main",
)
