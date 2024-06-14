
# Checklist de Avaliação das Normas da APA 7ª Edição para Trabalhos Académicos

## Descrição

Esta aplicação Shiny compreende uma checklist de 47 items baseada na 7ª edição do estilo APA para avaliar trabalhos académicos. Os utilizadores podem inserir notas para diferentes itens da checklist, calcular a média final e gerar um relatório em PDF contendo as notas e a média.

## Estrutura do Projeto

- `app.R`: Contém a lógica do aplicativo Shiny, incluindo a interface do utilizador (UI) e a lógica do servidor.
- `report_template.Rmd`: Template do relatório em RMarkdown para gerar o relatório PDF com as notas inseridas e a média calculada.

## Requisitos

- R (versão 3.6 ou superior)
- Pacotes R:
  - `shiny`
  - `DT`
  - `dplyr`
  - `rmarkdown`
  - `knitr`

## Instalação

1. Instale R a partir do [site oficial](https://cran.r-project.org/).
2. Instale os pacotes necessários em R:

```R
install.packages(c("shiny", "DT", "dplyr", "rmarkdown", "knitr"))
```

## Executar a Aplicação

1. Baixe os arquivos `app.R` e `report_template.Rmd`.
2. Execute o seguinte comando no R ou RStudio para iniciar a aplicação Shiny:

```R
shiny::runApp("caminho/para/app.R")
```

## Uso

1. Insira as notas (de 0 a 20) para cada item da checklist na barra lateral.
2. Clique no botão "Calcular e Gerar Relatório" para calcular a média das notas e exibir a tabela de notas.
3. Clique no botão "Baixar Relatório em PDF" para baixar um relatório PDF com as notas inseridas e a média calculada.

## Estrutura do Código

### `app.R`

- **UI**: Define a interface do usuário com um painel de entrada de notas, botões de ação e uma tabela de saída.
- **Server**: Contém a lógica para renderizar os campos de entrada, calcular a média das notas, exibir a tabela de notas e gerar o relatório em PDF.
- **Checklist Items**: Lista de itens da checklist APA 7ª Edição.

### `report_template.Rmd`

- Template para gerar o relatório em PDF.
- Utiliza os parâmetros `notas` e `media` para preencher a tabela no relatório.

## Contacto

Para mais informações, entre em contato com dcastro.rcb@gmail.com.
