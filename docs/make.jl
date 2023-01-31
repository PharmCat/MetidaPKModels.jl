using MetidaPKModels
using Documenter

DocMeta.setdocmeta!(MetidaPKModels, :DocTestSetup, :(using MetidaPKModels); recursive=true)

makedocs(;
    modules=[MetidaPKModels],
    authors="Vladimir Arnautov",
    repo="https://github.com/PharmCat/MetidaPKModels.jl/blob/{commit}{path}#{line}",
    sitename="MetidaPKModels.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://PharmCat.github.io/MetidaPKModels.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/PharmCat/MetidaPKModels.jl",
    devbranch="main",
)
