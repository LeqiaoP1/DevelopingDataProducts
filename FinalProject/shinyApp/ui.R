attach(mtcars)

shinyUI(pageWithSidebar(
  headerPanel('Data from Motor Trend Car Road Tests'),
  
  sidebarPanel(
      
      h5('Setup the predicitve formular'),
    
    selectInput('ycol',h5('1. Select the outcome variable'), names(mtcars)[lapply(mtcars,class)=="numeric"],
                selected=names(mtcars)[lapply(mtcars,class)=="numeric"][[1]]),
    
    selectInput('x1col',h5('2. Select the 1st predictor variable'), names(mtcars)[lapply(mtcars,class)=="numeric"],
                selected=names(mtcars)[lapply(mtcars,class)=="numeric"][[2]]),
    
    
    selectInput('x2col',h5('3. Select the 2nd predictor variable'), names(mtcars)[lapply(mtcars,class)=="numeric"],
                selected=names(mtcars)[lapply(mtcars,class)=="numeric"][[3]]), 
    
    
    
    submitButton("Update")
    
  ),
  
  mainPanel(
      h4("Linear Regression Model with 2 Numeric Variables"),
      verbatimTextOutput('formular'),
      plotOutput('plot1'),
      h5("Evaluation on Goodness of Fit -- R^2 (value 0 for the worst, 1 for the best) "),
      verbatimTextOutput('summ')
  )
  
)
)