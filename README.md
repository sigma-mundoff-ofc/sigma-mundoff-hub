# sigma.mundoff

Painel Roblox/Luau com **18 botões independentes** em uma lista rolável, ícone flutuante, controles de janela e atalho para o TikTok @sigma.mundoff. O nome exibido continua **sigma.mundoff**.

## Linha para o Delta

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/sigma-mundoff-ofc/sigma-mundoff-hub/main/sigma-mundoff.lua"))()
```

Essa linha permanece a mesma após atualizações do arquivo `sigma-mundoff.lua` no ramo `main` do repositório público. Execute a linha novamente para buscar alterações; uma interface já aberta não muda sozinha. O cache do GitHub ou do executor pode atrasar a chegada da nova versão.

## Mudanças desta atualização

- Permanecem 11 botões anteriores, na mesma ordem, incluindo Chilli hub AFK, Lennon hub manual e as duas versões de Miranda que o usuário informou não pedirem chave.
- Saíram **CloverHub**, cujo site oficial oferece obtenção de chave, e **Speed Hub X**, rotulado como “working key” para o mesmo link na [lista consultada](https://globalinterndesk.com/ecc/scripts/steal-an-egg/).
- Entraram sete botões **abaixo de bee hub**: ZEROIN HUB, OXIDE HUB, UB HUB, BLYXO HUB, BK HUB, NEVA HUB e CLOUT HUB. A [página de origem](https://globalinterndesk.com/ecc/scripts/steal-an-egg/) anuncia esses sete como “no key”, mas seus loaders são remotos ou ofuscados: **isso não garante que continuem sem chave ou funcionando**. Se algum pedir chave, remova o item da tabela `SCRIPTS` no `.lua` e salve um novo commit.
- LIMBO HUB (KAITUN) ficou de fora porque seu link retornou **404** na verificação; VALINC HUB retornou **403**. ZERO POINT HUB foi excluído porque seu código exige chave para Steal An Egg. OUROBOROS HUB declarou falta de suporte ao jogo; CYRUS HUB está em manutenção.

A lista consultada só apresenta scripts para **Steal An Egg**. Sem uma opção confirmada para outro jogo, não foi acrescentada a faixa horizontal de jogos. A rolagem vertical existente foi mantida.

## Arquivos

O ícone existente `icone-sigma-mundoff.jpg` **não mudou** e não precisa ser reenviado. Para atualizar este repositório, substitua `sigma-mundoff.lua`; este `README.md` é opcional, mas mantém as instruções corretas. Mantenha os arquivos na raiz do repositório, com os mesmos nomes e no ramo `main`.

**Atenção:** todos os botões executam código de terceiros que pode mudar ou ficar indisponível; a leitura passiva dos links não substitui um teste no Roblox. As linhas antigas da CDN não passam a carregar as alterações deste repositório.
