# Ifood Shop

Um novo projeto Flutter para compras de pratos de restaurantes.

## Alunos

Diogo Kaster

Rafael de Paiva Perina

Isabela Novaes

## Introdução

Este projeto é um ponto de partida para uma aplicação Flutter utilizando a arquitetura MVVM (Model-View-ViewModel).

## Arquitetura

A estrutura do projeto foi definida com base na arquitetura MVVM, conforme recomendado pela documentação oficial do Flutter:

- Model (Modelo): Responsável pela camada de dados e lógica de negócio.

- View (Visualização): Camada responsável pela interface com o usuário.

- ViewModel: Atua como ponte entre a View e o Model, lidando com a lógica e controle de estado.

Já implementamos as estruturas de models, repositories e definimos a separação das camadas. No entanto, tivemos alguns desafios ao implementar a funcionalidade de controle de estado usando o ViewModel, o que ainda está sendo ajustado para garantir uma integração eficiente entre as camadas.

Para gerenciamento de estado foi utilizada a biblioteca Provider em conjunto com Path.

E para construção de um banco de dados local foi utilizado o Sqflite.