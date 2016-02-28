library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Data science ftw"),
  sidebarPanel(
    h3('Sidebar text')
  ),
  mainPanel(
    h3('Main Panel text')
  )
))