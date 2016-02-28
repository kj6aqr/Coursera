shinyUI(pageWithSidebar(
  headerPanel("Analysis of Cognitive Impairment"),
  sidebarPanel(
    h4("Introduction"),
    p("This tool compares the efficacy of three different machine learning algorithms on a single classification problem.  This classification attempts to predict cognitive impairment from Alzheimer's disease based on several factors such as age, gender and genetic background."),
    selectInput("train","Select training/testing balance:",choices=c('20/80'='0','50/50'='1','80/20'='2')),
    selectInput("model","Select model:",choices=c('Please select a model'='0','   Random Forest'='1','   Linear Discriminant Analysis'='2','   Gradient Boosted Tree'='3')),
    textOutput("accuracy"),
    textOutput("time")
      ),
  mainPanel(
    plotOutput('ffp')
  )
))