view: product_facts {
  derived_table: {
    explore_source: product_purchase_per_user {
      column: product_id {}
      column: num_customers {}
      column: num_one_time_customers {}
      column: num_repeat_customers {}
      # derived_column:  {}
    }
  }


  dimension: product_id {
    view_label: "Again another label"
    primary_key: yes
    type:  number
  }
  measure: num_customers {
    type:  sum
    sql: ${TABLE}.num_customers ;;
  }
  measure: num_one_time_customers {
    type:  sum
    sql: ${TABLE}.num_one_time_customers ;;
  }
  measure: num_repeat_customers {
    type:  sum
    sql: ${TABLE}.num_one_time_customers ;;
  }
  measure: repeat_purchase_rate {
    type: number
    sql: ${num_repeat_customers}/NULLIF(${num_customers},0) ;;
    value_format_name: percent_2
  }
  parameter: dynamic_measure_type {
    type: unquoted
    allowed_value: {
      label: "Total"
      value: "SUM"
    }
    allowed_value: {
      label: "Average"
      value: "AVG"
    }
    allowed_value: {
      label: "Minimum"
      value: "MIN"
    }
  }

  measure: dynamic_measure {
    type: number
    sql: {% parameter dynamic_measure_type%} (${repeat_purchase_rate});;
    value_format_name: decimal_0
  }



}
