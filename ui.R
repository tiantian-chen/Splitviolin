library(shiny)

shinyUI(
    fluidPage(
        # Application title
        titlePanel("Splitviolin"),
        #
        sidebarLayout(
            sidebarPanel(
              conditionalPanel(
                condition = "input.tabs1 == 'Help'",
                h4("Help")
                
              ),
              conditionalPanel(
                condition = "input.tabs1 == 'About'",
                h4("About")
                
              ),
                conditionalPanel(
                    condition = "input.tabs1 == 'Splitviolinplot'",
                    
                    fileInput(
                        inputId = "data",
                        label = "Choose data",
                        multiple = FALSE
                    ),
                    downloadButton("downloadsampledata", 
                                   label = "Download sample data"),
                    textInput(
                      inputId = "splitviolinplottitle",
                      label = "Plot title",
                      value = "title"
                    ),
                    
                    sliderInput(
                        inputId = "titlesize",
                        label = "Title Size:",
                        min = 1,
                        max =150,
                        value = 20
                    ),
                    textInput(
                        "xtitle",
                        "X label title",
                        value = c("X title")
                    ),
                    textInput(
                        "ytitle",
                        "Y label title",
                        value = c("Y title")
                    ),
                    
                    
                    sliderInput(
                        "axistitlesize",
                        
                        "Axis Title Size:",
                        min = 1,
                        max = 150,
                        value = 20),
                    textInput("legendtitle",
                              "Legend title",
                              value = c("legend")),
                    
                    sliderInput("legendtitlesize",
                                "Legend Title Size:",
                                min = 1,
                                max = 150,
                                value = 20),
                    #h5("Plot background color"),
                    colourInput(
                        "plotcolor", 
                        "Plot background color",
                        "#ffffff"
                    ),
                    colourInput(
                      "panelcolor", 
                      "Panel background color",
                      "#BEBEBE"
                    ),
                    colourInput(
                      "treat1color", 
                      "treat1 background color",
                      "#56B4E9"
                    ),
                    colourInput(
                      "treat2color", 
                      "treat2 background color",
                      "#E69F00"
                    ),
                    # jscolorInput(
                    #     
                    #     "panelcolor", 
                    #     label = "Panel background color",
                    #     value = "#BEBEBE"
                    # ),
                    
                    #jscolorInput("plotcolor", label = NULL, value = "#0A0608")),
                    
                    actionButton(
                      inputId = "action",
                      label = "GO!"
                    ) 
                )
               
          ) ,
         
            # Show a plot of the generated distribution
            mainPanel(
                tabsetPanel(
                    tabPanel(
                        "Splitviolinplot",
                        downloadButton(
                            outputId = "file.pdf",
                            label = "Download pdf-file"
                        ),
                        downloadButton(
                          outputId = "file.svg",
                          label = "Download svg-file"
                          
                        )
                    ),
                    tabPanel(
                        "Help",
                        includeMarkdown("Help.md")
                    ),
                    tabPanel(
                      "About",
                      includeMarkdown("About.md")
                    ),
                    id = "tabs1"
                ),
                
                plotOutput("distPlot")
            )
            
        )
        
    )
    
    
)
