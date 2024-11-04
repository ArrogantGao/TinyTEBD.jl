using TinyTEBD
using Documenter

DocMeta.setdocmeta!(TinyTEBD, :DocTestSetup, :(using TinyTEBD); recursive=true)

makedocs(;
    modules=[TinyTEBD],
    authors="ArrogantGao <gaoxuanzhao@gmail.com> and contributors",
    sitename="TinyTEBD.jl",
    format=Documenter.HTML(;
        canonical="https://ArrogantGao.github.io/TinyTEBD.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ArrogantGao/TinyTEBD.jl",
    devbranch="main",
)
