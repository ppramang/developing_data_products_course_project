#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny) 
 

 # Define UI for dataset viewer application 
 shinyUI(fluidPage( 
      
     # Application title 
     titlePanel(title = h2("Developing Data Products-Shiny App Project", align = "center")), 
      
     # Sidebar with controls to select  
      
     sidebarLayout( 
         sidebarPanel( 
             textInput("caption", "1. Write a Header Description", "Name Your Analysis"),
             
             selectInput("dataset", "2. Select a Dataset:", 
                                           c("Sepal Length" = "Sepal Length", 
                                             "Sepal Width" = "Sepal Width", 
                                             "Petal Length" = "Petal Length",
                                             "Petal Width" = "Petal Width")), 
             
             
             sliderInput("obs", "3. Select Number of Observations", min=20, max=150, value=1), 
              
             radioButtons("color", "4. Select Color of Histogram", c("Cornflowerblue", 
                                                                     "Mediumorchid2", 
                                                                     "Darkgoldenrod1"),selected="Cornflowerblue")), 
         
          
      # Show a tabset  
          
      mainPanel( 
          h3(textOutput("caption", container = span)), 
              tabsetPanel(type = "tabs",  
              tabPanel("Plot",plotOutput("plot")), 
              tabPanel("Summary", verbatimTextOutput("summary")),  
              tabPanel("Structure", verbatimTextOutput("structure")), 
              tabPanel("Table", tableOutput("view")), 
              tabPanel("Documentation", verbatimTextOutput("documentation")) 
              ) 
              
           ) 
      ) 
)) 
