#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny) 
library(datasets)
library(doBy)
 
 # Define server logic required to summarize and view the selected 
 # dataset 
 shinyServer(function(input, output) { 
    
# Return the requested dataset 
  datasetInput <- reactive({datasets::iris})
  
  levelsInput <- reactive({switch(input$dataset,"Sepal Length" = iris$Sepal.Length,
                                          "Sepal Width" = iris$Sepal.Width,
                                          "Petal Length" = iris$Petal.Length,
                                          "Petal Width" = iris$Petal.Width)})
     
  output$caption <- renderText({ 
         input$caption 
  }) 
      
 # Generate a summary of the dataset 
  output$summary <- renderPrint({ 
      dataset <- datasetInput()
      data.frame(t(summaryBy(Sepal.Length + Sepal.Width + Petal.Length + Petal.Width ~ Species,data=dataset, FUN=c(mean,min,max,sd,median))))
    #summary(dataset)
          
  }) 
      
  output$structure <- renderPrint({ 
       dataset <- datasetInput() 
         str(dataset)
       }) 
      
     # Show the first "n" observations 
     output$view <- renderTable({ 
         head(datasetInput(), n = input$obs) 
       }) 
      
    output$documentation <-renderText({  
         paste(
" -This is a Shiny App Project that was developed to show the various widgets that can be used to the App.  
 -This App has 2 sections, a sidebar which is on the left of the App and on the right is main screen that contains the tabs.  
 -The sidebar panel have fours(4) control items.  
 -Title textbox allow user to customize the main page title description.  
 -The second control item allows the user to select the continuous variable, that he wants to be displayed and analysed
 -The third item is to control how many observatrions will be showed under the Table tab.  
 -The forth item allows the user to select the displayed color of the histogram.  
 -On the Main Page, there are 5 tabs:  
    1.The first tab displays the histogram of the dataset selected.  
    2.The second tab show the summary  
    3.The third tab shows the observations. The no of observations displayed is based on the number selected by user in the sidebar.
    4.The forth tab displays the dataset structure.
    5.the fifth tab constitutes the Documentation of the developed data product")
       }) 
      
     output$plot <- renderPlot({
         dataset1 <- levelsInput() 
         hist(dataset1,breaks=seq(0,8,l=input$obs),col=input$color,xlab=names(dataset1)) 
      }) 
   }) 
