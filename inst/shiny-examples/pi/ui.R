library(shiny)
library(shinycssloaders)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("superhero"),

                  titlePanel("\\(\\pi\\) Estimation"),
                  withMathJax(),
                  sidebarLayout(

                    sidebarPanel(
                      #We did not see the utility of having to choose an imput when we only have one method so we changed
                      #selectInput for textInput
                      textInput("method", "Method", choices= "Monte-Carlo approach"),

                      numericInput("seed", "Chose a seed", value = 4),

                      sliderInput("B", "number of iterations", min = 0, max = 10000, value = 5000) ),

                    mainPanel(

                      withSpinner(plotOutput("plot"),type= 4),

                      textOutput("time"),

                      textOutput("pi")
                    )
                  )
))
