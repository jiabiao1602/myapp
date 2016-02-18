library(shiny)
library(shinydashboard)
library(lattice)
library(ggplot2)
library(arules)
library(arulesViz)

dashboardPage(
  dashboardHeader(title="数据可视化平台demo"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("lattice绘图展示",tabName = "latticedemo"),
      menuItem("模型结果可视化展示",tabName = "viz")
    )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "latticedemo",
              box(title = "lattice包绘制散点图矩阵",
                  width = 6,solidHeader = TRUE,
                  background = "light-blue", plotOutput("splom")),
              box(title = "lattice包绘制三维图",
                  width = 6,solidHeader = TRUE,
                  background = "light-blue", plotOutput("wireframe"))),
      tabItem(tabName = "viz",
              box(title = "关联规则可视化",
                  width = 6,solidHeader = TRUE,collapsible = T,
                  background = "red",plotOutput("groceryrules")),
              box(title = "kmeans结果可视化",
                  width = 6,solidHeader = TRUE,collapsible = T,
                  background = "red",plotOutput("kmeans")),
              column(6,selectInput(inputId="method",label="请选择关联规则可视化的method",
                                   choices=c("graph","scatterplot","two-key plot", "matrix",  
                                             "matrix3D","paracoord"))),
              column(6,numericInput('clusters', '请选择k值', 3,
                                    min = 1, max = 9)),
              column(12,box(title = "评价线性模型拟合情况可视化",
                            solidHeader = TRUE,collapsible = T,width="100%",
                            background = "lime",plotOutput("lm.fit"))))
    )))
