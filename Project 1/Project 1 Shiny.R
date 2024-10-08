library(shiny)
library(dplyr)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Youtube Data Plot Selection"),
  
  sidebarLayout(
    sidebarPanel(
      style = "max-height: calc(100vh - 50px); overflow-y: auto; width: 300px; position: fixed;",  # Adjusted width and added position
      selectInput("plot_type", "Select Plot Type", choices = c("Channel Category Plot", "Rank Percentile Plot", "Earnings Plot")),
      selectInput("country_chart", "Select Country", choices = unique(youtube_data$country)),
      uiOutput("channel_type_ui"),
      conditionalPanel(
        condition = "input.plot_type == 'Rank Percentile Plot'",
        checkboxInput("correlation_checkbox", "Show Video views vs rank Plot", value = FALSE)
      ),
      conditionalPanel(
        condition = "input.plot_type == 'Earnings Plot'",
        radioButtons("earnings_time_period", "Select Earnings Time Period",
                     choices = c("Monthly", "Yearly"), selected = "Monthly"),
        radioButtons("earnings_value_type", "Select Earnings Value Type",
                     choices = c("Highest", "Lowest"), selected = "Highest")
      ),
      
      hr()
    ),
    mainPanel(
      style = "margin-left: 350px;",  # Adjusted margin-left
      uiOutput("dynamic_plot"),
      # Add margin to create a gap
      div(style = "margin-top: 10px;"),
      
      verbatimTextOutput("total_youtubers_count")
    )
  )
)


# Define server logic
server <- function(input, output, session) {
  
  total_youtubers_count <- reactiveVal(0)  # Initialize with 0
  
  observe({
    if (!is.null(input$country_chart)) {
      total_youtubers_count(nrow(filtered_data_chart()))
    }
  })
  
  output$total_youtubers_count <- renderText({
    paste("Total YouTubers in", input$country_chart, "used for this plot:", total_youtubers_count())
  })
  
  output$channel_type_ui <- renderUI({
    if (input$plot_type == "Channel Category Plot") {
      selectInput("channel_type", "Select Channel Type", choices = c("All", unique(youtube_data$channel_type)))
    } else {
      NULL
    }
  })
  
  filtered_data_chart <- reactive({
    if (!is.null(input$channel_type) && input$channel_type != "All") {
      filtered_data <- youtube_data[youtube_data$country == input$country_chart &
                                      youtube_data$channel_type == input$channel_type, ]
    } else {
      filtered_data <- youtube_data[youtube_data$country == input$country_chart, ]
    }
    filtered_data
  })
  
  output$dynamic_plot <- renderUI({
    plot_type <- input$plot_type
    
    if (plot_type == "Channel Category Plot") {
      plotOutput("stacked_bar_chart")
    } else if (plot_type == "Rank Percentile Plot") {
      plotOutput("percentile_scatter_plot")
    } else if (plot_type == "Earnings Plot") {
      plotOutput("earning_plot")
    }
  })
  
  output$stacked_bar_chart <- renderPlot({
    data_for_plot <- filtered_data_chart()  # Store the reactive data in a variable
    ggplot(data_for_plot, aes(x = category, y = uploads, fill = channel_type)) +
      geom_bar(stat = "identity") +
      labs(title = "Country Channel Type Category Data",
           x = "Category",
           y = "Uploads",
           fill = "Channel Type") +
      graph_theme +
      coord_flip() +
      theme(legend.position = "bottom",
            text = element_text(face = "bold"),  # Bold text
            plot.title = element_text(size = rel(1.2))) +
      scale_fill_discrete(name = "Channel Type")
  })
  
  output$percentile_scatter_plot <- renderPlot({
    data_for_plot <- filtered_data_chart()  # Store the reactive data in a variable
    p <- ggplot(data_for_plot, aes(x = country_percentile_rank, y = uploads)) +
      geom_point(colour = "darkred", shape = 23) +
      labs(title = "Country Rank Data",
           x = "Top Percentile Rank",
           y = "Uploads") +
      theme(legend.position = "bottom",
            text = element_text(face = "bold", size = 12),  # Bold text
            plot.title = element_text(size = rel(1.2))) +
      graph_theme
    
    if (input$correlation_checkbox) {
      correlation_plot <- ggplot(data_for_plot, aes(x = video_views, y = country_percentile_rank)) +
        geom_point(colour = "darkblue", shape = 23) +
        geom_smooth(method = "lm", se = FALSE, color = "darkblue") +
        labs(title = "Correlation between Video Views and Percentile Rank",
             x = "Video Views",
             y = "Percentile Rank") +
        theme(legend.position = "bottom",
              text = element_text(face = "bold", size = 12),  # Bold text
              plot.title = element_text(size = rel(1.2))) +
        graph_theme
      p <- cowplot::plot_grid(p, correlation_plot, nrow = 2)
    }
    p
  })
  
  output$earning_plot <- renderPlot({
    data_for_plot <- filtered_data_chart()
    
    earnings_type <- if (input$earnings_time_period == "Monthly") {
      if (input$earnings_value_type == "Highest") {
        "highest_monthly_earnings"
      } else {
        "lowest_monthly_earnings"
      }
    } else {
      if (input$earnings_value_type == "Highest") {
        "highest_yearly_earnings"
      } else {
        "lowest_yearly_earnings"
      }
    }
    
    if (earnings_type %in% names(data_for_plot)) {
      mean_earnings <- mean(data_for_plot[[earnings_type]], na.rm = TRUE)
      p_box <- ggplot(data_for_plot, aes(x = factor(1), y = .data[[earnings_type]])) +
        geom_boxplot() +
        stat_summary(fun = mean, geom = "point", shape = 19, size = 3, color = "red") +  # Adding mean dot
        geom_text(aes(x = 1, y = mean_earnings, label = paste("Mean:", round(mean_earnings, 2))),
                  vjust = -1, color = "red") +
        labs(title = paste(input$earnings_value_type, "Earnings Box Plot -", input$earnings_time_period),
             x = input$country_chart,
             y = "Earnings") +
        theme(legend.position = "bottom",
              text = element_text(face = "bold", size = 12),  # Bold text
              plot.title = element_text(size = rel(1.2))) +
        graph_theme +
        scale_x_discrete(labels = "")
      
      p_violin <- ggplot(data_for_plot, aes(x = factor(1), y = .data[[earnings_type]])) +
        geom_violin(fill = "lightblue", color = "blue", alpha = 0.5) +
        stat_summary(fun = mean, geom = "point", shape = 19, size = 3, color = "red") +  # Adding mean dot
        geom_text(aes(x = 1, y = mean_earnings, label = paste("Mean:", round(mean_earnings, 2))),
                  vjust = -1, color = "red") +
        labs(title = paste(input$earnings_value_type, "Earnings Violin Plot -", input$earnings_time_period),
             x = input$country_chart,
             y = "Earnings") +
        theme(legend.position = "bottom",
              text = element_text(face = "bold", size = 12),  # Bold text
              plot.title = element_text(size = rel(1.2))) +
        graph_theme +
        scale_x_discrete(labels = "")
      
      plot_grid(p_box, p_violin, ncol = 2)
    } else {
      # Return a message if the selected earnings column is not present
      plot(NULL, xlim = c(0, 1), ylim = c(0, 1), xlab = "", ylab = "",
           main = "Selected earnings column not found.")
    }
  })
  
  
}

# Run the application
shinyApp(ui = ui, server = server)