library(shiny)
library(shinydashboard)
library(lattice)
library(arules)
library(arulesViz)


function(input, output) { 
  # 利用lattice包中的绘图函数
  output$splom <- renderPlot({
    splom(mtcars[c(1, 3:7)], groups = mtcars$cyl,
          pscales = 0,pch=1:3,col=1:3,
          varnames = c("Miles\nper\ngallon", "Displacement\n(cu. in.)",
                       "Gross\nhorsepower", "Rear\naxle\nratio",
                       "Weight", "1/4 mile\ntime"),
          key = list(columns = 3, title = "Number of Cylinders",
                     text=list(levels(factor(mtcars$cyl))),
                     points=list(pch=1:3,col=1:3)))
  })
  output$wireframe <- renderPlot({
    wireframe(volcano, shade = TRUE,
              aspect = c(61/87, 0.4),
              light.source = c(10,0,10))
    
  })
  
  #关联规则可视化
  output$groceryrules <- renderPlot({
    data(Groceries)
    groceryrules <- apriori(Groceries,parameter = 
                              list(support=0.006,confidence=0.25,minlen=2))
    plot(subset(groceryrules,lift > 3),method=input$method)
  })
  # 聚类结果可视化
  clusters <- reactive({
    kmeans(iris[,1:4],input$clusters)
  })
  output$kmeans <- renderPlot({
    plot(iris[,c('Sepal.Length','Sepal.Width')],
         col = clusters()$cluster,
         pch = 20, cex = 2)
    points(clusters()$centers, pch = 4, cex = 2, lwd = 4)
  })
  # 评价线性模型拟合情况可视化
  output$lm.fit <- renderPlot({
    fit <- lm(Sepal.Length~Sepal.Width,data=iris[,1:4])
    par(mfrow=c(2,2),pch="*",bg="aliceblue")
    plot(fit)
  })
}
