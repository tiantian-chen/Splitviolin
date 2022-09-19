library(shiny)
library(ggplot2)
library(Rmisc)
library(ggpubr)
source("source/splitviolinplots.R",local = TRUE)
shinyServer(function(input, output) {
    observeEvent(input$action,{
        data <- read.table(input$data$datapath,sep = "\t",head = T)
        Group <- as.factor(data[,2])
        Attribute <- as.factor(data[,3])
        data1 <- data.frame(value=data[,1],Group=Group,Attribute=Attribute)
       
        Data_summary <- summarySE(data1, measurevar="value", groupvars=c("Group","Attribute"))
        p1 <- ggplot(data1, aes(x=Group, y=value,fill=Attribute)) + 
            
            geom_split_violin(trim=F,color="white",scale = "area")+
            geom_point(data = Data_summary,aes(x=Group, y=value),pch=19,position=position_dodge(0.5),size= 1)+
            geom_errorbar(data= Data_summary,aes(ymin=value-ci,ymax=value+ci),   
                          width= 0.05, 
                          position= position_dodge(0.5), 
                          color="black",
                          alpha = 0.5,
                          size= 0.5) +
            scale_fill_manual(values = c(input$treat1color, input$treat2color))+  #zhe li shi yan se
            theme(
                panel.background = element_rect(fill = input$panelcolor),
                plot.background = element_rect(fill = input$plotcolor),
                axis.title = element_text(size = input$axistitlesize),
                plot.title = element_text(size = input$titlesize,hjust = 0.5),#hjust
                legend.title = element_text(size = input$legendtitlesize)
                
            ) +
            labs(
                title = input$splitviolinplottitle, 
                x = input$xtitle,
                y = input$ytitle,
                fill = input$legendtitle
              
            )
        
        figurecp <<- p1
        output$distPlot <- renderPlot({
            p1
        },height=750, width=750)
    })
    
    observe({
        output$file.pdf <- downloadHandler(
            filename <- function(){ paste('file.pdf') },
            content <- function(file){
                pdf(file, width = 750/72, height = 750/72)
                print(figurecp)
                dev.off()
            }, contentType = 'application/pdf')
                output$file.svg <- downloadHandler(
                  filename <- function(){ paste('file.svg') },
                  content <- function(file){
                    svg(file, width = 750/72, height = 750/72)
                    print(figurecp)
                    dev.off()
            }, contentType = 'application/svg')  
        
    })
    # Download sample data
    
    output$downloadsampledata <- downloadHandler(
        filename <- function() {
            paste('data1.txt')
        },
        content <- function(file) {
            input_file <- "data1.txt"
            example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
            write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
        }, contentType = 'text/csv') 
       })





