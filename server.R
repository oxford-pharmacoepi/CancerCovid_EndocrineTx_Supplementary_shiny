
options(encoding = "UTF-8")

#### SERVER ------
server <-	function(input, output, session) {
  
    # database details
  output$tbl_database_details <- renderText(kable(database_details) %>%
                                              kable_styling("striped", full_width = F) )
  
  
  output$gt_database_details_word <- downloadHandler(
    filename = function() {
      "database_description.docx"
    },
    content = function(file) {
      x <- gt(database_details)
      gtsave(x, file)
    }
  )
  
  # clinical codelists
  output$tbl_codelists <- renderText(kable(concepts_lists) %>%
                                       kable_styling("striped", full_width = F) )
  
  
  output$gt_codelists_word <- downloadHandler(
    filename = function() {
      "concept_lists.docx"
    },
    content = function(file) {
      x <- gt(concepts_lists)
      gtsave(x, file)
    }
  )
  
  # cohort attrition -----
  get_table_attrition <-reactive({
    
    table <- attrition_table %>% 
      filter(Cancer %in% input$attrition_cohort_name_selector)  
    
    table
  }) 
  
  output$dt_cohort_attrition <- renderText(kable(get_table_attrition()) %>%
                                             kable_styling("striped", full_width = F) )
  
  output$gt_cohort_attrition_word <- downloadHandler(
    filename = function() {
      "cdm_attrition.docx"
    },
    content = function(file) {
      x <- gt(get_table_attrition())
      gtsave(x, file)
    }
  )
}
  # 
  # 
  # # demographics --------
  # 
  # get_demographics <- reactive({
  #   
  #   table <- demographics %>% 
  #     filter(Sex %in% input$tableone_sex_selector) %>% 
  #     filter(Age %in% input$tableone_age_selector) 
  #   
  #   selected_columns <- c("Description", input$demographics_database_name_selector)
  #   table <- table[, selected_columns, drop = FALSE]
  #   
  #   table
  #   
  # }) 
  # 
  # 
  # output$dt_demographics <- renderText(kable(get_demographics()) %>%
  #                                        kable_styling("striped", full_width = F) )
  # 
  # 
  # output$gt_demographics_word <- downloadHandler(
  #   filename = function() {
  #     "demographics.docx"
  #   },
  #   content = function(file) {
  #     x <- gt(get_demographics())
  #     gtsave(x, file)
  #   }
  # )  
  # 
  # 
  # # table one --------
  # 
  # get_table_one <- reactive({
  #   
  #   table <- tableone_final %>% 
  #     filter(Cancer %in% input$tableone_cohort_name_selector) %>% 
  #     filter(Sex %in% input$tableone_sex_selector) %>% 
  #     filter(Age %in% input$tableone_age_selector) 
  #   
  #   selected_columns <- c("Description", input$tableone_database_name_selector)
  #   table <- table[, selected_columns, drop = FALSE]
  #   
  #   table
  #   
  # }) 
  # 
  # 
  # output$dt_tableone <- renderText(kable(get_table_one()) %>%
  #                                    kable_styling("striped", full_width = F) )
  # 
  # 
  # output$gt_tableone_word <- downloadHandler(
  #   filename = function() {
  #     "table_one.docx"
  #   },
  #   content = function(file) {
  #     x <- gt(get_table_one())
  #     gtsave(x, file)
  #   }
  # )  
  # 
  # 
  # # gof results --------
  # get_gof <- reactive({
  #   
  #   table <- GOFResults %>% 
  #     filter(Database %in% input$gof_database_selector) %>% 
  #     filter(Cancer %in% input$gof_cohort_name_selector) %>% 
  #     filter(Sex %in% input$gof_sex_selector) %>% 
  #     filter(Age %in% input$gof_age_selector) 
  #   
  #   table
  #   
  # }) 
  # 
  # 
  # output$dt_gof <- renderText(kable(get_gof()) %>%
  #                               kable_styling("striped", full_width = F) )
  # 
  # 
  # output$gt_gof_word <- downloadHandler(
  #   filename = function() {
  #     "gof.docx"
  #   },
  #   content = function(file) {
  #     x <- gt(get_gof())
  #     gtsave(x, file)
  #   }
  # )  
  # 
  # # extrapolation parameters --------
  # get_param <- reactive({
  #   
  #   table <- ExtrpolationParameters %>% 
  #     filter(Database %in% input$param_database_selector) %>% 
  #     filter(Cancer %in% input$param_cohort_name_selector) %>% 
  #     filter(Sex %in% input$param_sex_selector) %>% 
  #     filter(Age %in% input$param_age_selector) 
  #   
  #   table
  #   
  # }) 
  # 
  # output$dt_param <- renderText({
  #   get_param_text <- kable(get_param()) %>%
  #     kable_styling("striped", full_width = F)
  #   
  #   
  # })
#   
#   output$dt_param <- renderDT({
#     datatable(get_param(), options = list(scrollX = TRUE, 
#                                           dom = 't', 
#                                           searching = FALSE), 
#               rownames = FALSE, width = '50%')
#   })
#   
#   # 
#   # output$dt_param <- renderText(kable(get_param()) %>%
#   #                               kable_styling("striped", full_width = F) )
#   
#   
#   output$gt_param_word <- downloadHandler(
#     filename = function() {
#       "extrapolation_parameters.docx"
#     },
#     content = function(file) {
#       x <- gt(get_param())
#       gtsave(x, file)
#     }
#   )  
#   
#   
#   get_surv_plot <- reactive({
#     plot_data <- survivalResults %>%
#       filter(Database %in% input$survival_database_selector) %>%
#       filter(Cancer %in% input$survival_cohort_name_selector) %>%
#       filter(Age %in% input$survival_age_selector) %>%
#       filter(Sex %in% input$survival_sex_selector) %>%
#       filter(Method %in% input$survival_method_selector)
#     
#     if (!is.null(input$surv_plot_group) && !is.null(input$surv_plot_facet)) {
#       plot <- plot_data %>%
#         unite("Group", c(all_of(input$surv_plot_group)), remove = FALSE, sep = "; ") %>%
#         unite("facet_var", c(all_of(input$surv_plot_facet)), remove = FALSE, sep = "; ") %>%
#         ggplot(aes(x = time, y = est, ymin = lcl, ymax = ucl, group = Group, colour = Group, fill = Group)) +
#         geom_line(aes(size = ifelse(Method == "Kaplan-Meier", "Thicker", "Regular"))) +
#         scale_size_manual(values = c("Thicker" = 1.5, "Regular" = 0.75)) +
#         #scale_linetype_manual(values = rep("solid", length(unique(plot_data$Method)))) +
#         xlab("Time (Years)") +
#         ylab("Survival Function (%)") +
#         facet_wrap(vars(facet_var), ncol = 2) +
#         theme_bw() +
#         guides(size = FALSE)
#       
#     } else if (!is.null(input$surv_plot_group) && is.null(input$surv_plot_facet)) {
#       plot <- plot_data %>%
#         unite("Group", c(all_of(input$surv_plot_group)), remove = FALSE, sep = "; ") %>%
#         ggplot(aes(x = time, y = est, ymin = lcl, ymax = ucl, group = Group, colour = Group, fill = Group)) +
#         geom_line(aes(size = ifelse(Method == "Kaplan-Meier", "Thicker", "Regular"))) +
#         scale_size_manual(values = c("Thicker" = 1.5, "Regular" = 0.75)) +
#         #scale_linetype_manual(values = rep("solid", length(unique(plot_data$Method)))) +
#         xlab("Time (Years)") +
#         ylab("Survival Function (%)") +
#         theme_bw() +
#         guides(size = FALSE)
#       
#     } else if (is.null(input$surv_plot_group) && !is.null(input$surv_plot_facet)) {
#       plot <- plot_data %>%
#         unite("facet_var", c(all_of(input$surv_plot_facet)), remove = FALSE, sep = "; ") %>%
#         ggplot(aes(x = time, y = est, ymin = lcl, ymax = ucl, group = Group, colour = Group, fill = Group)) +
#         geom_line(aes(size = ifelse(Method == "Kaplan-Meier", "Thicker", "Regular"))) +
#         scale_size_manual(values = c("Thicker" = 1.5, "Regular" = 0.75)) +
#         #scale_linetype_manual(values = rep("solid", length(unique(plot_data$Method)))) +
#         xlab("Time (Years)") +
#         ylab("Survival Function (%)") +
#         facet_wrap(vars(facet_var), ncol = 2) +
#         theme_bw() +
#         guides(size = FALSE)
#       
#     } else {
#       plot <- plot_data %>%
#         ggplot(aes(x = time, y = est, ymin = lcl, ymax = ucl, group = Group, colour = Group, fill = Group)) +
#         geom_line(aes(size = ifelse(Method == "Kaplan-Meier", "Thicker", "Regular"))) +
#         scale_size_manual(values = c("Thicker" = 1.5, "Regular" = 0.75)) +
#         # scale_linetype_manual(values = rep("solid", length(unique(plot_data$Method)))) +
#         xlab("Time (Years)") +
#         ylab("Survival Function (%)") +
#         theme_bw() +
#         guides(size = FALSE)
#       
#     }
#     
#     # Move scale_y_continuous outside of ggplot
#     plot <- plot + scale_y_continuous(limits = c(0, NA))
#     
#     plot
#   })
#   
#   output$survivalPlot <- renderPlot(
#     get_surv_plot()
#   )
#   
#   
#   
#   
# }