library(shiny)
library(shinycssloaders)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("superhero"),

                  titlePanel("Pi Estimation"),
                  withMathJax(),
                  sidebarLayout(

                    sidebarPanel(

                      selectInput("method", "Method", choices = "Estimation of \\(\\pi\\)"),

                      numericInput("seed", "Chose a seed", value = 4),

                      sliderInput("B", "number of iterations", min = 0, max = 10000, value = 5000) ),

                    mainPanel(

                      withSpinner(plotOutput("plot"),type= 4),

                      textOutput("time"),

                      textOutput("pi")
                    )
                  )
))
