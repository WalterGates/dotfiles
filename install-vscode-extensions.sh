#!/usr/bin/bash

pkglist=(
    ms-dotnettools.vscode-dotnet-runtime
    ms-vscode.cpptools
    ms-vscode.cpptools-themes
    llvm-vs-code-extensions.vscode-clangd
    josetr.cmake-language-support-vscode
    ms-vscode.cmake-tools
    ms-vscode.cmake-tools
    johnguo.columnpaste
    ms-vscode.hexeditor
    onlylys.leaper
    ms-vsliveshare.vsliveshare
    pkief.material-icon-theme
    pkief.material-product-icons
    drmerfy.overtype
    slevesque.shader
    wayou.vscode-todo-highlight
)

for i in "${pkglist[@]}"; do
    code --install-extension "$i"
done
