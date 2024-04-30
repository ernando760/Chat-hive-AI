<p align="center">
 <img src="https://github.com/ernando760/Chat-hive-AI/blob/main/assets/md/logo-chat-hive-AI.svg" alt="Chat_Hive_logo" width="500" height="300">
</p>

# tópicos
* **[Sobre o App]()**
* **[Como foi feito]()**
* **[Como configurar o projeto]()**

# Sobre o App

O Aplicativo foi desenvolvido com intuito de aprimorar meu aprendizado em desenvolvimento de aplicativos móveis feito em flutter. O proposito do aplicativo é para ter um ou varios bate-papo com IA **(Inteligência Artificial)**.Nele voçê manda mensagem de texto e a IA gera uma resposta e retorna de volta, não tem como enviar messagem por voz por enquanto. a IA usado nesse projeto é o Gemini que foi desenvolvido pela a Google,e os servico de autentificação e de banco de dados usado no projeto é do Firebase que tambem é do Google, para fazer a configuração do Firebase e do Genini está abaixo no tópico [Como configurar o projeto]().

# Como foi feito

O app foi desenvolvido usando um pacote [chat hive core]("") que foi feito para o projeto **É obrigatorio usar o pacote** para nõa dá nenhum problema, o design do projeto foi desenvolvido no figma [chat_hive_ai_design](https://www.figma.com/file/8s97OZwdXyUAf3JexTxn84/Chat-hive-AI?type=design&node-id=13%3A2530&mode=design&t=XTfdKeaeOTLvKNAL-1).

## Design pattern

* MVVM
 
## Gerenciadores de estado

* Provider
* ChangeNotifier

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
