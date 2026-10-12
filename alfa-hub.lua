-- Alfa Hub | Entrada pública com validação de chave.
-- As funções do hub são entregues pelo servidor somente após a autorização.
-- Mantenha este arquivo e o endereço do site para atualizar sem trocar o comando.
local BASE_URL = "https://alfakeys-vdt6rziw.manus.space"
local source = game:HttpGet(BASE_URL .. "/api/loader.lua", true)
local chunk, compileError = loadstring(source)
if type(chunk) ~= "function" then
    error("Alfa Hub: não consegui preparar a tela de chave. " .. tostring(compileError))
end
local start = chunk()
if type(start) ~= "function" then
    error("Alfa Hub: o servidor não retornou um carregador válido.")
end
start(BASE_URL)
