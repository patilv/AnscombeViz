library(shiny)
library(ggvis)

shinyUI(bootstrapPage(
  div(class="row",
      div(class="span4",
                    sliderInput("datasourcenum","Data Set Number:", min=1, max=4, value=1,  
                      format="###0",step=1,animate=animationOptions(playButton="Start Flipping", pauseButton="Stop flipping", loop=T, interval=1500)))),
  ggvisOutput("ggvisplot"))
 )