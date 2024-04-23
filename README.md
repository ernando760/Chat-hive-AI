# Chat Hive AI

O Aplicativo foi desenvolvido com intuito de aprimorar meu aprendizado em desenvolvimento de aplicativos móveis feito em flutter.

## Como configurar o projeto

### Firebase

Esse app usa os serviços do Firebase que são o firebase auth e o firestore database, para fazer as configurações acesse este link [configurando o firebase]().<br/>
(caso se você tem conhecimentos dos serviços do Firebase pricipalmente saber fazer a configuração do provedor do Google **não precisa acessar o link**).

### Gemini

E depois de configurar o Firebase vamos fazer a configuração da API KEY do gemini.

Primeiro criar uma api key do gemini [aqui](https://aistudio.google.com/app/apikey), depois de cria a chave, na raiz do projeto cria uma pasta **.config** dentro dela cria um arquivo **config.json** e adiciona esse código.

```json
{
    "API_KEY_GEMINI": "SUA_CHAVE"
}
```

O ultimo passo de configurar a API_KEY, vai no arquivo **.vscode/launch.json** e adiciona esse código.

```json
{
   "request": "launch",
   "type": "dart",
   "args": [
                "--dart-define-from-file",
                ".config/config.json"
            ]
}
```

E pronto voçê já fez a configuração da API KEY do Gemini, muito simples.
