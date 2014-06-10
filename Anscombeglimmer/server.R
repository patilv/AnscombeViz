
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggvis)
library(dplyr)

anscombe=as.data.frame(anscombe)
anscombereorder=anscombe[,c(1,5,2,6,3,7,4,8)]
anscombelong=data.frame(x=unlist(anscombe[,1:4]),
                        y=unlist(anscombe[,5:8]),
                        datasource=rep(1:4,each=11))

shinyServer(function(input, output) {

  tooltip <- function(data, ...) {
    paste0("x: ", data$x, "<br>",
           "y: ", data$y)
  }
  df=reactive({anscombelong %>% filter(datasource %in%  input$datasourcenum)}) 
  df %>% ggvis(x = ~x, y = ~y) %>%
    layer_points(fill.hover:="red",size.hover := 200) %>% 
    layer_model_predictions(stroke="lm",model = "lm", formula=y~x) %>% 
    add_tooltip(tooltip) %>% 
    scale_numeric("x", domain = c(4, 19)) %>%
    scale_numeric("y", domain = c(3, 13)) %>%
    set_options(width=400,height=300) %>% 
    bind_shiny("ggvisplot")
  options = list(height = 400,width=600)
  })
