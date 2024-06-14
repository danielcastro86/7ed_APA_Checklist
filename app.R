# Carregando os pacotes necessários
library(shiny)
library(DT)
library(dplyr)
library(rmarkdown)

# Definindo a interface do usuário
ui <- fluidPage(
  titlePanel("Avaliação da Checklist APA 7ª Edição"),
  sidebarLayout(
    sidebarPanel(
      h3("Insira as notas (0 a 20)"),
      uiOutput("inputFields"),
      actionButton("calcButton", "Calcular e Gerar Relatório"),
      downloadButton("downloadReport", "Baixar Relatório em PDF")
    ),
    mainPanel(
      DTOutput("tableOutput"),
      h4("Média Final:"),
      textOutput("mediaFinal")
    )
  )
)

# Definindo a lógica do servidor
server <- function(input, output, session) {
  checklistItems <- c(
    "Página de Título: Espaçamento duplo em toda a página e sem avanços antes ou depois dos parágrafos.",
    "Página de Título: Todos os elementos da página estão centrados e sem indentação.",
    "Página de Título: Não existem palavras em itálico, sublinhadas, nem com diferentes tipos de letra ou tamanhos.",
    "Título: É um sumário conciso do trabalho e do tópico principal e/ou variáveis.",
    "Título: Primeira letra capitalizada bem como todas as restantes palavras com 4 ou mais letras.",
    "Título: Redigido na parte superior da página de título.",
    "Nome dos Autores: No mínimo o primeiro e último nome de todos os autores do trabalho. ",
    "Afiliação dos Autores: (e.g., Departamento, Universidade)",
    "Afiliação dos Autores:linha seguinte depois dos nomes dos autores",
    "Nome da Unidade Curricular: Na linha seguinte à afiliação",
    "Nome do Docente: Na linha seguinte à identificação da Unidade Curricular",
    "Data de Entrega: Uma linha após o nome do docente (e.g., 4 de maio de 2024)",
    "Cabeçalho Página de Título: Página número 1 alinhado à direita no canto superior direito.",
    "Tipo de Letra: O mesmo tipo e tamanho de letra ao longo do trabalho e em conformidade com as normas da APA.",
    "Espaçamento: Espaçamento duplo ao longo de todo o trabalho. Sem linhas extra antes ou depois dos títulos.",
    "Alinhamento e indentação dos parágrafos: Alinhado à esquerda e com indentação na primeira linha.",
    "Introdução: Nome do trabalho na primeira linha da primeira página de texto. Centrado e a negrito. O texto inicia na segunda linha da página.",
    "Ordenação das Páginas",
    "Texto: Títulos de nível 1 só devem ser utilizados para as secções principais após a introdução (e.g., Método, Resultados, Discussão).",
    "Títulos de Secção: Centrados e a negrito, incluíndo o Abstract e as Referências",
    "Escrita Científica: Continuidade entre palavras, conceitos, e o desenvolvimento temático ao longo do trabalho",
    "Escrita Científica: A utilização do início da frase para realizar a ligação clara com frase anterior",
    "Escrita Científica: A explicação das relações entre as ideias é clara",
    "Escrita Científica: O argumento segue uma ordem lógica, sem analepses ou prolepses.",
    "Escrita Científica: Evita redundâncias",
    "Escrita Científica: O uso excessivo de conceitos globais e genéricos.",
    "Escrita Científica: Parágrafos com apenas uma linha ou parágrafos com mais de 7 linhas.",
    "Escrita Científica: Utilização de linguagem clara, de tom professional, sem contrações, coloquialismos ou artifícios literários.",
    "Escrita Científica: Frases com cerca de 20 palavras, utilizando o início da frase para articular com a frase anterior.",
    "Escrita Científica: O início do parágrafo realiza a articulação com o parágrafo anterior.",
    "Citações: Estão apenas citados artigos que for lidos e incorporados no texto.",
    "Citações: Todos as citações do texto estão incluídos na lista de referências.",
    "Citações: A ortografia do nome dos autores e as datas das citações estão iguais nas citações e na lista de referências.",
    "Citações: Todo o conteúdo das citações foi parafraseado.",
    "Citações: Não existe sobrecitação nem subcitação do texto redigido.",
    "Citações: Todas as citações seguem as normas da APA.",
    "Citações: Para citações de trabalhos de dois autores as citações entre parêntesis têm um & e em formato narrativo um e.",
    "Citações: As citações de múltiplos trabalhos estão realizadas por ordem alfabética.",
    "Referências: A lista de referências inicia-se numa página nova depois do texto.",
    "Referências: O título está centrado e a negrito.",
    "Referências: A lista de referências apresenta espaçamento duplo, nas referências e entre as referências.",
    "Referências: Indentação pendente em cada referência.",
    "Referências: O formato de referência é apropriado para o formato do trabalho a ser referenciado.",
    "Referências: Todos os elementos da referência (i.e., autor, data, titulo, fonte) estão presentes.",
    "Referências: Apenas a primeira letra do título e do subtítulo está capitalizada.",
    "Referências: Não está incluída informação sobre a base de dados académica",
    "Referências: Todas as referências apresentam o DOI ou o URL do trabalho referenciado."
    
  )
  
  output$inputFields <- renderUI({
    lapply(1:length(checklistItems), function(i) {
      numericInput(paste0("item", i), checklistItems[i], min = 0, max = 20, value = 0)
    })
  })
  
  observeEvent(input$calcButton, {
    notas <- sapply(1:length(checklistItems), function(i) {
      input[[paste0("item", i)]]
    })
    
    df <- data.frame(
      Item = checklistItems,
      Nota = notas
    )
    
    output$tableOutput <- renderDT({
      datatable(df)
    })
    
    mediaFinal <- round(mean(notas), 2)
    
    output$mediaFinal <- renderText({
      mediaFinal
    })
  })
  
  output$downloadReport <- downloadHandler(
    filename = function() {
      paste("relatorio_avaliacao", Sys.Date(), ".pdf", sep = "")
    },
    content = function(file) {
      notas <- sapply(1:length(checklistItems), function(i) {
        input[[paste0("item", i)]]
      })
      
      df <- data.frame(
        Item = checklistItems,
        Nota = notas
      )
      
      mediaFinal <- round(mean(notas), 2)
      
      rmarkdown::render("report_template.Rmd", output_file = file,
                        params = list(notas = df, media = mediaFinal))
    }
  )
}

# Executando a aplicação Shiny
shinyApp(ui = ui, server = server)
