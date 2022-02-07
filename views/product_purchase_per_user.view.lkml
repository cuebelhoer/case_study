# If necessary, uncomment the line below to include explore_source.
# include: "case_study.model.lkml"

view: product_purchase_per_user{
  derived_table: {
    explore_source: order_items {
      filters: [order_items.status: "-Returned, -Cancelled"]
      filters: [order_items.count: ">=1"]
      column: product_id { field: inventory_items.product_id }
      column: user_id {field: users.id }
      column: count {}
    }
  }
  dimension: product_id {
    type:  number
  }
  dimension: user_id {
    type:  number
  }
  dimension: count {
    type: number
    hidden: yes
  }

  measure: num_customers {
    type: count_distinct
    sql:  ${user_id} ;;
  }
  measure: num_one_time_customers {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [count: "=1"]
  }
  measure: num_repeat_customers{
    type: count_distinct
    sql: ${user_id} ;;
    filters: [count: ">1"]
  }
}
