# Counting N boxes
observeEvent(input$gen_filterby_add, {
  gen_filterby_boxes_N(gen_filterby_boxes_N() + 1)
})
observeEvent(input$gen_filterby_minus, {
  if (gen_filterby_boxes_N()>0) {
    gen_filterby_boxes_N(gen_filterby_boxes_N() - 1)
  }
})

# Display N boxes
observeEvent(gen_filterby_boxes_N(), {
  lapply (1:25, function(i) {
    boxid <- sprintf('gen_filterby_%i', i)
    if (i <= gen_filterby_boxes_N()) {
      shinyjs::show(id = boxid)
    } else {
      shinyjs::hide(id = boxid)
    }
  })
})

# Build boxes' UIs
lapply(1:25, function(i) {
  boxid <- sprintf('gen_filterby_%i', i)
  output[[sprintf('%s_ui', boxid)]] <- renderUI({ filterby_UI(input[[sprintf("%s_vtype", boxid)]],
                                                              boxid) })
  output[[sprintf('%s_ui_sliders', boxid)]] <- renderUI({ filterby_UI_sliders(input[[sprintf("%s_vtype", boxid)]],
                                                                              boxid,
                                                                              input[[sprintf("%s.opt", boxid)]],
                                                                              input[[sprintf("%s.log", boxid)]],
                                                                              lexopsReact(),
                                                                              toleranceUIopt = input$preference.toleranceUI) })
  box_sliders <- reactive({
    vtype <- input[[sprintf("%s_vtype", boxid)]]
    if (vtype %in% c("Part of Speech", "Rhyme")) {
      input[[sprintf("%s_sl", boxid)]]
    } else if (input$preference.toleranceUI == 'slider') {
      input[[sprintf("%s_sl", boxid)]]
    } else {
      c(input[[sprintf("%s_tol_lower", boxid)]], input[[sprintf("%s_tol_upper", boxid)]])
    }
  })
  output[[sprintf('%s_ui_vis', boxid)]] <- renderPlot({ filterby_UI_vis(input[[sprintf("%s_vtype", boxid)]],
                                                                        boxid,
                                                                        input[[sprintf("%s.opt", boxid)]],
                                                                        input[[sprintf("%s.log", boxid)]],
                                                                        input[[sprintf("%s.source", boxid)]],
                                                                        lexopsReact(),
                                                                        box_sliders()) })
})

# Put the UIs built above into their boxes
lapply(1:25, function(i) {
  boxid <- sprintf('gen_filterby_%i', i)
  output[[sprintf('%s', boxid)]] <- renderUI({
    box(title=i, width=12, status='info', solidHeader=T,
        selectInput(sprintf('%s_vtype', boxid), NULL, c('(None)', vis.cats[vis.cats!="Rhyme"])),
        uiOutput(sprintf('%s_ui', boxid)),
        uiOutput(sprintf('%s_ui_sliders', boxid)),
        plotOutput(sprintf('%s_ui_vis', boxid), height='170px'),
        id = boxid
    )
  })
})
