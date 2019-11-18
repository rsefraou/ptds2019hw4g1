library(shiny)
library(ptds2019hw4g1)



shinyServer(function(input, output) {

    simulate <- reactive({
        # simulate pi and measure the time here
        estimate_pi(input$B, input$seed)
        system.time(estimate_pi(input$B, input$seed))

    })

    output$plot <- renderPlot({
        # plot pi

        ptds2019hw4g1:::plot.pi(estimate_pi(input$B, input$seed))
    })

    output$time <- renderText({
        # extract the time of the execution
        paste("The execution time was", round(system.time(estimate_pi(input$B, input$seed)), digits = 2)[3],"sec")

    })

    output$pi <- renderText({
        # extract the estimated value
        paste("The estimation of pi with", input$B, "iteration is equal to ", estimate_pi(input$B, input$seed)$estimated_pi)
    })

})




