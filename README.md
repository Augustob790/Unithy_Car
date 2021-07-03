# UNITHY - APP DE COMPRA E VENDA DE CARROS

A new Flutter project.

## O que é?

Consiste em uma aplicação que realizar o cadastro compra e venda de veículos, sendo adicionado algumas informações e até mesmo uma foto.

## Decisões

- Foi utilizado a linguagem Dart e FrameWork Flutter devido a sua capacidade de criar aplicações com um desempenho nativo e também e a ferramenta que eu venho estudando já há algum tempo.
- O Firebase foi escolhido para abrigar o dados gerados no aplicativo, por ser uma banco NoSQL e presente na forma de Cloud, o usuario poderá acessar e cadastrar as informações de qualquer lugar do mundo.
- Os carros serão exibidos na forma de lista contendo as informações cadastradas pelo seus usuarios.
- Contém um sistema de login completo, inlcuindo um cadastro e a recuperação de senhas.

## Observações

- A funcionalide de relatorio que consiste no retorno das informações (Listar o valor total em compras e vendas, lucro/prejuízo do mês e o valor pago em comissões.) não foi concluida, logo a mesma so estar sendo exiibindo apenas dados estaticos.
- O motivo consiste na dificuldade de realizar uma pesquisar composta dos dados utilizando os recursos presentes do Firebase.
- Essa dificuldade está relacionada forma como e armazenada os dados no Firestore, realizar um select que busca esses dados, ainda é uma grande adversidade para a minha pessoa.

## Getting Started

 - Baixe e instale o Flutter (de preferencia na versão 2.05). 
 
 - Instale o Visual Studio Code e baixe o plugin do Dart e Flutter.
 
 - Baixe esse projeto e adicione no VScode.
 
 - Adicione um dipostivo ou emulador Android ou Iphone.
 
 - Rode o comando  ( flutter run ) no terminal.
 ```
 flutter run
```
 
## Teste

O prazo para realização do exercício é dia 02 de julho
O intuito deste exercício é validar o máximo de conhecimento que você possui.
Antes de mais nada, crie um repositório no git e cole o conteúdo desse texto no readme.
Você precisará construir um sistema para uma agência de veículos, ele será composto por uma api e um frontend (Desktop ou Mobile).
Sinta-se à vontade para usar a linguagem que achar melhor e pode usar templates prontos, frameworks e/ou outras coisas que possam facilitar a sua vida.
Crie um arquivo readme falando um pouco sobre quais as decisões que você tomou para a resolução do exercício, e, caso não tenha feito algo, explique o motivo. Também informe os passos para fazer sua aplicação rodar, e caso tenha, o processo de deploy.
Precisamos que nosso sistema seja capaz de:
- Cadastrar a compra de um veículo, modelo, marca, ano de fabricação, placa, cor, chassi, data da compra e valor da compra.
- Registrar a venda de um veículo, com data da venda, valor da venda e comissão do vendedor (10% sobre o lucro da venda).
- Deverá ser possível listar todos os veículos, veículos disponíveis e histórico de veículos vendidos.
- Listar o valor total em compras e vendas, lucro/prejuízo do mês e o valor pago em comissões.
Caso queira criar mais funcionalidades fique à vontade, apenas se lembre de mencionar sobre elas no readme.
Qualquer dúvida entre em contato comigo pelo linkedin, estarei à disposição para esclarecer quaisquer dúvidas que surgirem.
Ao finalizar a prova basta enviar o link do repositório no linkedin. 
