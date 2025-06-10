# Automação do Pipeline de Vendas

## Descrição
Este projeto envolve a automação do pipeline de vendas, desde a criação de oportunidades até a movimentação automática entre as fases de vendas, com base em critérios específicos, como valor e condições da oportunidade.

O objetivo é reduzir o trabalho manual e aumentar a precisão nas movimentações, permitindo que a equipe de vendas foque em fechar negócios.

## Tecnologias Utilizadas:
- **Apex Trigger**: Para automatizar a movimentação de oportunidades para as fases corretas com base em condições definidas.
- **LWC (Lightning Web Component)**: Para criar um componente de visualização interativa das oportunidades e suas fases.
- **Salesforce Flow**: Para automatizar processos que podem ser utilizados por outros times, como o time de marketing.

## Desafio
O maior desafio foi garantir que as oportunidades fossem movidas automaticamente para a fase correta, com base no valor da oportunidade e nos critérios de vendas. Também tivemos que garantir que a solução fosse fácil de usar para os vendedores e que funcionasse sem causar conflitos de dados.

## Solução
Criamos uma **trigger Apex** que automaticamente move as oportunidades entre as fases, e um **LWC** para permitir que os vendedores visualizem e interajam com as oportunidades de forma clara.

## Resultados
- Redução de 25% no tempo necessário para mover as oportunidades entre fases.
- Aumento de 30% na adoção da automação pelo time de vendas.
- Melhoria na precisão das movimentações de oportunidades, com menos erros manuais.

## Código
Você pode ver o código completo abaixo:

- **Trigger**: `Trigger1.trigger`
- **LWC Component**: `LWCComponent1.js`
