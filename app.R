ui <- fluidPage(

	  # Application title
  titlePanel("Dataset Exploration Tool"),


	
  sidebarLayout(

    # Sidebar with a slider input
    sidebarPanel(
tags$table(
	tags$tr(
		tags$td("The purpose of this application is to allow exploring datasets by plotting numeric variables on the x and y axes.  Put things in, take them out, look at the correlations change.  It could be considered as a complement to the interesting, yet bulky, ggpairs() plot.  By default, the 'swiss' dataset has already been loaded for you.  If you wish, you may plug in any other reasonably small csv file.  (Verified to work: concrete, seatbelts, mtcars).  If you load your own, please use a csv with a header row, since the program will use this as the basis for the lists of variables you can plot.  Thanks!")
					)
	),

		uiOutput("a"),
tags$table(
	tags$tr(
		tags$td(uiOutput("b")),tags$td(uiOutput("c"))
	)
	)
    ),
	    mainPanel(
	plotOutput("d"),
	verbatimTextOutput("cor")
)

  	
  	  )

	
	
#	uiOutput("c"),
	
	
		)
   



	
			server <- function(input, output) {
output$a <- renderUI({
	# certain input.. what kind.. selection of a file
	     fileInput("file1", "",
        accept = c(
          "text/csv",
          "text/comma-separated-values,text/plain",
          ".csv")
        )
 
				
})
output$b <- renderUI ({
	   if(is.null(input$file1))
{
	   	# the user can demo with swiss
	   	# in case they don't have anything suitable
csvData <- swiss
} else
{
	csvObject <- (input$file1)
  csvData <- read.csv(csvObject$datapath)
}
		colnames <- names(csvData)
	    checkboxGroupInput("columnsx", "Plot on X", 
                        choices  = colnames)
})

output$c <- renderUI ({
	   if(is.null(input$file1))
{
	   	# the user can demo with swiss
	   	# in case they don't have anything suitable
csvData <- swiss
} else
{
	csvObject <- (input$file1)
  csvData <- read.csv(csvObject$datapath)
}

		colnames <- names(csvData)
	    checkboxGroupInput("columnsy", "Plot on Y", 
                        choices  = colnames)
})

output$d <- renderPlot ({

	   if(is.null(input$file1))
{
	   	# the user can demo with swiss
	   	# in case they don't have anything suitable
csvData <- swiss
t <- swiss
		   if(is.null(input$columnsx))
return()
		   if(is.null(input$columnsy))
return()


} else
{
		   if(is.null(input$columnsx))
return()
		   if(is.null(input$columnsy))
return()
	csvObject <- (input$file1)
  csvData <- read.csv(csvObject$datapath)
  t <- read.csv(csvObject$datapath)
}

 # t <- csvObject$name
	x1 <- input$columnsx
y1 <- input$columnsy
#p1 <- paste0(c("+t$"),collapse="")
#p2 <- paste0(c(t,"$"),collapse="")
p1 <- "+t$"
p2 <- "t$"
x2 <- paste0(x1,collapse=p1)
x3 <- paste0(c(p2,x2),collapse="")
y2 <- paste0(y1,collapse=p1)
y3 <- paste0(c(p2,y2),collapse="")
plotstring <- paste0(c("plot(",x3,",",y3,")"),collapse="")
eval(parse(text=plotstring))



#plot(mtcars$mpg,mtcars$hp)
	
	})
output$cor <- renderPrint ({
	   if(is.null(input$file1))
{
	   	# the user can demo with swiss
	   	# in case they don't have anything suitable
csvData <- swiss
t <- swiss
		   if(is.null(input$columnsx))
return()
		   if(is.null(input$columnsy))
return()


} else
{
		   if(is.null(input$columnsx))
return()
		   if(is.null(input$columnsy))
return()
	csvObject <- (input$file1)
  csvData <- read.csv(csvObject$datapath)
  t <- read.csv(csvObject$datapath)
}

	
	x1 <- input$columnsx
y1 <- input$columnsy
#p1 <- paste0(c("+t$"),collapse="")
#p2 <- paste0(c(t,"$"),collapse="")
p1 <- "+t$"
p2 <- "t$"
x2 <- paste0(x1,collapse=p1)
x3 <- paste0(c(p2,x2),collapse="")
y2 <- paste0(y1,collapse=p1)
y3 <- paste0(c(p2,y2),collapse="")
corstring <- paste0(c("\"Correlation\";","cor(",x3,",",y3,")"),collapse="")

current_correlation <- eval(parse(text=corstring))
c("Correlation of variables shown:",current_correlation)
})


   }
shinyApp(ui, server)
