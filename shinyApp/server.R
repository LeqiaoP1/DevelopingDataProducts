
library(car)

attach(mtcars)


shinyServer(function(input, output, session) {
    
    # check the input formular   
    fstr <- reactive({
        if ( (input$ycol == input$x1col) || (input$ycol == input$x2col))
            "Error: Make sure the outcome variable is different from any predictor variables!"
        else if (input$x1col == input$x2col)
            "Error: Choose two different predictor variables!"          
        else    
            paste(input$ycol, "~", input$x1col, " + ", input$x2col, sep = " ")
        
    })
    
    # train the linear model
    fit_model <- reactive({
        if (grepl("Error", fstr()) == FALSE)
        {
            lm(as.formula(fstr()), data = mtcars)            
        }
    })
    
    output$plot1 <- renderPlot({
        if (grepl("Error", fstr()) == FALSE)
        {
            par(mfrow=c(1,2))
            termplot( fit_model(), main = c(paste("Regre. term @", input$x1col), paste("Regr. term @", input$x2col)), 
                      partial.resid = TRUE, se=TRUE )
        }
        else
            plot(x=0, main = "Error at input formular")
    })
    
    output$summ <-renderText({
        if (grepl("Error", fstr()) == TRUE)
            "Error at input formular"
        else
            summary(fit_model())$r.squared
        
    })
    
    output$formular <- renderText( {
        fstr()        
    })
    
})
