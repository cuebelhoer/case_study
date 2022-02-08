- dashboard: customer_
  title: 'Customer '
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: Distribution of customers based on the number of orders
    name: Distribution of customers based on the number of orders
    model: case_study
    explore: order_items
    type: looker_funnel
    fields: [user_facts.lifetime_orders_tier, user_facts.count]
    filters:
      user_facts.lifetime_orders_tier: "-Below 1"
    sorts: [cumsum desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: runningtotal, label: runningtotal, expression: 'running_total(${user_facts.count})',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: cumsum, label: CumSum, expression: 'if(row()=
          1, sum(${user_facts.count}), sum(${user_facts.count}) - offset(${runningtotal},
          -1))', value_format: !!null '', value_format_name: decimal_1, _kind_hint: measure,
        _type_hint: number}]
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: true
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: b8e44ce6-d0e6-4bd4-b72c-ab0f595726a6
      options:
        steps: 5
    isStepped: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [user_facts.count, runningtotal]
    listen:
      Country: users.country
    row: 0
    col: 0
    width: 12
    height: 7
  - title: Average Lifetime Spending
    name: Average Lifetime Spending
    model: case_study
    explore: order_items
    type: single_value
    fields: [user_facts.avg_lifetime_revenue]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
    single_value_title: Average Lifetime Spending
    conditional_formatting: [{type: greater than, value: 150, background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen:
      Country: users.country
    row: 0
    col: 12
    width: 12
    height: 7
  - title: Lifetime Revenue
    name: Lifetime Revenue
    model: case_study
    explore: order_items
    type: looker_pie
    fields: [user_facts.lifetime_revenue_tier, user_facts.count]
    fill_fields: [user_facts.lifetime_revenue_tier]
    sorts: [user_facts.count desc]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: b8e44ce6-d0e6-4bd4-b72c-ab0f595726a6
      options:
        steps: 5
        reverse: false
    series_colors: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Country: users.country
    row: 7
    col: 0
    width: 12
    height: 6
  - title: Customer groups contributing to monthly revenue
    name: Customer groups contributing to monthly revenue
    model: case_study
    explore: order_items
    type: looker_line
    fields: [user_facts.lifetime_revenue_tier, order_items.created_month, order_items.total_gross_revenue]
    pivots: [user_facts.lifetime_revenue_tier]
    fill_fields: [user_facts.lifetime_revenue_tier, order_items.created_month]
    sorts: [order_items.created_month desc, user_facts.lifetime_revenue_tier]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen:
      Country: users.country
    row:
    col:
    width:
    height:
  - title: Most Recent Customers
    name: Most Recent Customers
    model: case_study
    explore: order_items
    type: looker_donut_multiples
    fields: [user_facts.is_active, user_facts.count, user_facts.lifetime_revenue_tier]
    pivots: [user_facts.lifetime_revenue_tier]
    fill_fields: [user_facts.is_active, user_facts.lifetime_revenue_tier]
    sorts: [user_facts.is_active, user_facts.lifetime_revenue_tier]
    limit: 500
    column_limit: 50
    show_value_labels: false
    font_size: 12
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Country: users.country
    row:
    col:
    width:
    height:
  - title: Driving Factors that customers return to website
    name: Driving Factors that customers return to website
    model: case_study
    explore: order_items
    type: looker_column
    fields: [user_facts.is_active, users.traffic_source, user_facts.count]
    pivots: [user_facts.is_active]
    fill_fields: [user_facts.is_active]
    sorts: [users.traffic_source, user_facts.is_active]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Country: users.country
    row:
    col:
    width:
    height:
  - title: Repeat Purchase Rate
    name: Repeat Purchase Rate
    model: case_study
    explore: products
    type: looker_grid
    fields: [products.brand, product_facts.num_customers, product_facts.num_repeat_customers,
      product_facts.repeat_purchase_rate, product_facts.num_one_time_customers]
    sorts: [product_facts.num_repeat_customers desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen: {}
    row:
    col:
    width:
    height:
  - title: Revenue based on customer cohort
    name: Revenue based on customer cohort
    model: case_study
    explore: order_items
    type: looker_column
    fields: [order_items.total_gross_revenue, user_facts.months_since_signup_tier]
    fill_fields: [user_facts.months_since_signup_tier]
    sorts: [user_facts.months_since_signup_tier]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: b8e44ce6-d0e6-4bd4-b72c-ab0f595726a6
      options:
        steps: 5
    defaults_version: 1
    listen:
      Country: users.country
    row:
    col:
    width:
    height:
  - title: User Signup
    name: User Signup
    model: case_study
    explore: order_items
    type: looker_column
    fields: [user_facts.count, user_facts.months_since_latest_order]
    sorts: [user_facts.months_since_latest_order desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: b8e44ce6-d0e6-4bd4-b72c-ab0f595726a6
      options:
        steps: 5
    hide_legend: false
    reference_lines: []
    trend_lines: [{color: "#000000", label_position: right, order: 3, period: 7, regression_type: linear,
        series_index: 1, show_label: true}]
    defaults_version: 1
    listen:
      Country: users.country
    row:
    col:
    width:
    height:
  filters:
  - name: Country
    title: Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: []
    model: case_study
    explore: order_items
    listens_to_filters: []
    field: users.country
