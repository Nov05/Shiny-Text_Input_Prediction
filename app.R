
# https://stackoverflow.com/questions/35265920/auto-complete-and-selection-of-multiple-values-in-text-box-shiny

library(shiny)
library(shinysky)

# remove all lists
rm(list = ls())

#trigram <- readRDS("../data/capstone/3gram_notail_en.rds")
unigram <- readRDS("1gram_90_en.rds")
unilist <- as.character((unigram[,1]))

my_autocomplete_list <- unilist

ui <- shinyUI(
  fluidPage(tags$style(type="text/css",".shiny-output-error { visibility: hidden; }",".shiny-output-error:before { visibility: hidden; }"),
            tags$style(type="text/css","#search { top: 50% !important;left: 50% !important;margin-top: -100px !important;margin-left: -250px 
                       !important; color: blue;font-size: 20px;font-style: italic;}"),         
            
            titlePanel("Text Input Prediction"),
            sidebarLayout(
              sidebarPanel(
                textInput.typeahead(id="typeahead01",
                                    placeholder="Type a word here",
                                    local=data.frame(name=c(my_autocomplete_list)),
                                    valueKey="name",
                                    tokens=c(1:length(my_autocomplete_list)),
                                    template = HTML("<p class='repo-language'>{{info}}</p> <p class='repo-name'>{{name}}</p>"),
                                    limit=10
                ),
                shinyalert("shinyalert01")
              ),
              mainPanel(
                br(),br()
              )
            )
  )
)

server <- function(input, output, session){
  # typeahead
  observe({
    input$typeahead01
    showshinyalert(session, "shinyalert01", sprintf("Typeahead Text Input Value: %s", input$typeahead01), "error")
  })
}

shinyApp(ui=ui, server=server)