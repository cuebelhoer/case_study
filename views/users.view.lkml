view: users {
  sql_table_name: `thelook.users`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: avg_count {
    type: average
    sql: ${} ;;
  }

  measure: count_hard_coded {
    type: count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
    html:
    {% if value > 1 %}
    <div style="background-color: rgba(200,35,25,{{value}}); font-size:150%; text-align:center">{{rendered_value}}</div>
    {% elsif value > 0 %}
    <div style="background-color: rgba(25,35,150,{{value}}); font-size:150%; text-align:center">{{rendered_value}}</div>
    {% else %}
    <div style="background-color: rgba(25,35,150,0.99); font-size:150%; text-align:center">{{rendered_value}}</div>
    {% endif %}
    ;;
  }


  dimension: age_tier {
    label: "Age Buckets"
    description: "Key Age groups"
    type: tier
    style: integer
    tiers: [15,26,36,51,66]
    sql:  ${age} ;;
  }

  dimension_group: since_signup {
    type: duration
    sql_start: ${created_date} ;;
    sql_end: current_date() ;;
    intervals: [week, year, day, month]
  }

  measure: avg_days_since_signup {
    label: "Average Days Since Signup"
    type: average
    sql: ${days_since_signup} ;;
  }

  measure: avg_months_since_signup {
    label: "Average Months Since Signup"
    type: average
    sql: ${months_since_signup} ;;
  }

  dimension: is_new_customer {
    # drill_fields: [detailed_customer_info*]
    label: "Is new customer"
    description: "Yes if customer was created within last 90 days"
    type: yesno
    sql: ${days_since_signup} < 90 ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  # measure: num_orders {
  #   label: "Number of Orders"
  #   description: "Returns the number of orders"
  #   type: count_distinct
  #   sql: ${order_items.order_id} ;;
  # }

  dimension: latitude_short {
    type: number
    sql: round(${latitude},5) ;;
  }

  dimension: longitude_short {
    type: number
    sql: round(${latitude},5) ;;
  }

  dimension: location_short {
    type: location
    sql_latitude: ${latitude_short} ;;
    sql_longitude: ${longitude_short} ;;
  }


  measure: count_latitude {
    type: count_distinct
    sql: ${latitude};;
  }

  measure: count_latitude_short {
    type: count_distinct
    sql: ${latitude_short};;
  }
}
