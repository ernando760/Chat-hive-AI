<p align="center">
 <img src="https://github.com/ernando760/Chat-hive-AI/blob/main/assets/md/logo-chat-hive-AI.svg" alt="Chat_Hive_logo" width="500" height="300">
</p>

# tópicos
* **[Sobre o projeto](#sobre-o-projeto)**
* **[Como foi feito?](#como-foi-feito)**
* **[como configurar o projeto](#como-configurar-o-projeto)**


<h1 id="sobre-o-projeto">Sobre o projeto</h1>

O projeto foi desenvolvido com intuito de aprimorar meu aprendizado em desenvolvimento de aplicativos móveis feito em flutter. O proposito do aplicativo é para ter um ou varios bate-papo com IA **(Inteligência Artificial)**.Nele voçê manda mensagem de texto e a IA gera uma resposta e retorna de volta, não tem como enviar messagem por voz por enquanto. a IA usado nesse projeto é o Gemini que foi desenvolvido pela a Google,e os servico de autentificação e de banco de dados usado no projeto é do Firebase que tambem é do Google, para fazer a configuração do Firebase e do Gemini está abaixo no tópico [Como configurar o projeto](https://github.com/ernando760/Chat-hive-AI/edit/main/README.md#como-configurar-o-projeto).

<h1 id="como-foi-feito">Como foi feito?</h1>

O aplicativo foi desenvolvido junto com o pacote [chat hive core]("https://github.com/ernando760/chat-hive-ai-core") que foi feito para o projeto **É obrigatorio usar esse pacote** para não dá nenhum problema. O design UI do projeto foi desenvolvido no figma [chat_hive_ai_design_UI](https://www.figma.com/file/8s97OZwdXyUAf3JexTxn84/Chat-hive-AI?type=design&node-id=13%3A2530&mode=design&t=XTfdKeaeOTLvKNAL-1). O design pattern usado no projeto foi o MVVM, e os gerenciadores de estado usados, são o Provider e o ChangeNotifier.

<h1 id="como-configurar-o-projeto">Como configurar o projeto?</h1>

**Primeiro faça o clone do projeto e do pacote [chat hive core](https://github.com/ernando760/chat-hive-ai-core), para fazer as configurações**.

## Firebase

> [!WARNING]
> **As configurações do firebase só foram feita na plataforma Android. Se voçê tem conhecimento dos servicos do firebase e principalmente saber fazer as configuracões do provedor de autentificação do Google, então pode pular para a configuração do Gemini.**

Para fazer as configurações do Firebase segue as seguites etapas;

* Cria um projeto no [console do firebase](https://console.firebase.google.com/). 
* Adiciona um aplicativo android no projeto.
* Adiciona o serviço de autentificação e de banco de dados **(que no projeto usa o firestore)**.

No aplicativo usa o provedor de autentificação do google, se voçẽ tem conhecimento de como fazer a configuração, então vai para a configuração do Gemini. Então, para fazer a configuração do provedor de autentificação do google, voçê deve seguir as seguites etapas.

Primeiro abra o seu terminal e entra na pastas **android** do projeto, e executa o seguinte comando.

```bash
 $ ./gradrew signingReport
```
Deve retornar algo parecido com isso.

```
> Task :app:signingReport
Variant: debug
Config: debug
Store: /seu/usuario/.android/debug.keystore
Alias: AndroidDebugKey
MD5: SEU_MD5
SHA1: SEU_SHA1
SHA-256: SEU_SHA256
Valid until: sexta-feira, 4 de julho de 2053

...
```

Depois, copia o SEU_SHA1 e o SEU_SHA256, e vai no seu projeto que voçê criou no firebase, vai na configuraçẽes do projeto rola até no final, onde você vai encontra **Seus aplicativos**, no final dele tem um botão **Adicionar impressão digital**, ao clicar, voçê deve colar o SEU_SHA1 e o SEU_SHA256, depois disso voçê vai baixar o arquivo **google-services.json** e substituir o do seu projeto **android/app/google-services.json**.

**E pronto!** voçê já finalizou a configuração do firebase do seu projeto.
  
## Gemini

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

**E pronto!** voçê já fez a configuração da API KEY do Gemini, muito simples.
