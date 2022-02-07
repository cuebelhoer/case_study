view: user_facts {
  derived_table: {
    explore_source: order_items {
      column: id { field: order_items.user_id }
      # column: lifetime_orders { field: users.num_orders }
      column: lifetime_revenue {field: order_items.total_gross_revenue}
      column: first_order_date {}
      column: latest_order_date {}
      column: avg_months_since_signup {field: users.avg_months_since_signup}
      column: avg_days_since_signup {field: users.avg_days_since_signup}
      column: days_since_signup {field: users.days_since_signup}
      column: months_since_signup {field: users.months_since_signup}
    }

  }

  measure: count {
    type: count
    # drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: lifetime_orders {
    label: "Lifetime Orders"
    description: "Returns the number of orders"
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: lifetime_revenue {
    label: "Lifetime Revenue"
    description: "Total amount of revenue brought in from an individual customer"
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension: first_order_date {
    label: "First order date"
    sql: ${TABLE}.first_order_date ;;
  }

  dimension: latest_order_date {
    label: "Latest order date"
    sql: ${TABLE}.latest_order_date ;;
  }

  dimension: avg_months_since_signup {
    sql: ${TABLE}.avg_months_since_signup ;;
  }
  dimension: avg_days_since_signup {
    sql: ${TABLE}.avg_days_since_signup ;;
  }
  dimension: days_since_signup {
    sql: ${TABLE}.days_since_signup ;;
  }
  dimension: months_since_signup {
    sql: ${TABLE}.months_since_signup ;;
  }

  dimension: months_since_signup_tier {
    type: tier
    tiers: [1, 5, 10, 20, 30, 40]
    sql: ${months_since_signup} ;;
    style: integer
  }


  dimension_group: since_latest_order {
    label: "Time period since last order"
    type: duration
    sql_start: ${latest_order_date} ;;
    sql_end: current_date ;;
    intervals: [day,week,month,year]
  }

  measure: avg_days_since_latest_order{
    label: "Average days since latest order"
    type: average
    sql:  ${days_since_latest_order} ;;
  }

  dimension: is_active {
    label: "Is Active"
    type: yesno
    sql: ${days_since_latest_order} <= 90  ;;
  }

  dimension: lifetime_orders_tier {
    label: "Number of total Orders Buckets"
    type: tier
    tiers: [1, 2, 3, 6, 10]
    sql: ${lifetime_orders} ;;
    style: integer
  }

  # measure: total_lifetime_orders {
  #   description: "The total number of orders placed over the course of customers’ lifetimes."
  #   label: "Total Lifetime Orders"
  #   type: sum
  #   sql:  ${num_orders} ;;
  # }

  dimension: is_repeat_customer {
    label: "Is Repeat Customer"
    type: yesno
    sql: ${lifetime_orders} > 1 ;;
  }

  measure: avg_lifetime_orders {
    description: "The average number of orders placed over the course of customers’ lifetimes."
    label: "Average Lifetime Orders"
    type: average
    sql:  ${lifetime_orders} ;;
  }

  # measure: total_lifetime_revenue {
  #   label: "Total lifetime revenue"
  #   description: "The total amount of revenue brought in over the course of customers’ lifetimes."
  #   type: sum
  #   sql:  ${lifetime_revenue} ;;
  #   value_format_name: usd_0
  # }

  measure: avg_lifetime_revenue {
    label: "Average lifetime revenue"
    description: "The average amount of revenue brought in over the course of customers’ lifetimes."
    type: average
    sql:  ${lifetime_revenue} ;;
    value_format_name: usd_0
  }

  dimension: lifetime_revenue_tier {
    label: "Lifetime Revenue Buckets"
    alpha_sort: yes
    case: {
      when: {
        sql: ${lifetime_revenue} < 5.00;;
        label: "$0.00 - $4.99"
      }
      when: {
        sql: ${lifetime_revenue} >= 5.00 AND ${lifetime_revenue} < 20.00;;
        label: "$5.00 - $19.99"
      }
      when: {
        sql: ${lifetime_revenue} >= 20.00 AND ${lifetime_revenue} < 50.00;;
        label: "$20.00 - $49.99"
      }
      when: {
        sql: ${lifetime_revenue} >= 50.00 AND ${lifetime_revenue} < 100.00;;
        label: "$50.00 - $99.99"
      }
      when: {
        sql: ${lifetime_revenue} >= 100.00 AND ${lifetime_revenue} < 500.00;;
        label: "$100.00 - $499.99"
      }
      when: {
        sql: ${lifetime_revenue} >= 500.00 AND ${lifetime_revenue} < 1000.00;;
        label: "$500.00 - $999.99"
      }
      when: {
        sql: ${lifetime_revenue} > 1000.00;;
        label: "$10000+"
      }
      else:"Unknown"
    }
  }

}
