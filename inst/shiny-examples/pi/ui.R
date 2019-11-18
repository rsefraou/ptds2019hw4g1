library(shiny)
library(shinycssloaders)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("superhero"),

                  titlePanel("\\(\\pi\\) Estimation"),
                  withMathJax(),
                  sidebarLayout(

                    sidebarPanel(

                      selectInput("method", "Method", choices = "Monte-Carlo approach"),

                      numericInput("seed", "Choose a seed", value = 4),

                      sliderInput("B", "number of iterations", min = 0, max = 1000000, value = 5000) ),

                    mainPanel(

                      withSpinner(plotOutput("plot"),type= 4),

                      textOutput("time"),

                      textOutput("pi")
                    )
                  )
))
