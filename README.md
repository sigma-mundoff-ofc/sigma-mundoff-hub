# sigma.mundoff

Painel Roblox/Luau com 13 opções de scripts, lista rolável, ícone flutuante e atalho para o perfil TikTok @sigma.mundoff. O nome exibido no painel é **sigma.mundoff** (sem número de versão).

## Linha para o Delta

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/sigma-mundoff-ofc/sigma-mundoff-hub/main/sigma-mundoff.lua"))()
```

O repositório deve ser **público** para que o link raw funcione sem autenticação. A linha acima só funciona depois que `sigma-mundoff.lua` estiver publicado no ramo `main` deste repositório.

## Atualizar sem trocar a linha

Edite o arquivo `sigma-mundoff.lua` no ramo `main` e salve a alteração com **Commit changes**. Mantenha o mesmo usuário, nome do repositório, ramo e nome do arquivo. Da próxima vez que a linha for executada, ela buscará o conteúdo atualizado; o cache do GitHub ou do executor pode atrasar a atualização por alguns minutos. Uma instância já aberta não se atualiza sozinha: execute a linha novamente.

O ícone usado pela interface está em `icone-sigma-mundoff.jpg`. Ele é baixado e armazenado pelo executor se esse recurso estiver disponível. Os scripts listados nos botões vêm de terceiros e podem mudar, apresentar falhas ou ficar indisponíveis sem aviso.

**Atenção:** as linhas antigas hospedadas em `files.manuscdn.com` não passarão a apontar para este repositório. Para receber atualizações por este endereço, será necessário distribuir a linha do GitHub uma vez.
