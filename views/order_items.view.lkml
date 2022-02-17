view: order_items {
  sql_table_name: `thelook.order_items`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  parameter: metric_selector {
    type: string
    allowed_value: {
      label: "first"
      value: "first"
    }
    allowed_value: {
      label: "last"
      value: "last"
    }
  }

  measure: metric {
    label_from_parameter: metric_selector
    type: number
    value_format: "0.00" #Removed percentage because when adding visits this will not work
    sql:
      CASE
      WHEN {% parameter metric_selector %} = 'first' THEN ${first_order_date}
      WHEN {% parameter metric_selector %} = 'last' THEN ${latest_order_date}
      ELSE NULL
    END ;;

    }





  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_extract_week {
    type: number
    sql: EXTRACT(WEEK FROM ${TABLE}.created_at);;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_country_UK {
    type: count
    drill_fields: [detail*]
    filters: [users.country: "UK"]
  }

  measure: total_sales {
    label: "total_sale"
    description: "total_sale"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }

  measure: avg_sale_price {
    label: "Average Sale Price"
    sql: ${total_sales}/NULLIF(${num_order_items},0) ;;
    value_format_name: usd_0
  }

  measure: num_order_items {
    label: "Number of order items"
    type:  count
    }

  measure: cum_total_sale_price {
    label: "Cumulative Total Sale Price"
    description: "Only use with Table Calculations (running_total) to retrieve Cumulative Total Sale Price"
    type: number
    sql: ${total_sales};;
    value_format_name: usd_0
  }

  measure: total_gross_revenue {
    label: "Total Gross Revenue"
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    type: sum
    sql: ${sale_price} ;;
    filters: [status: "-Cancelled,-Returned"]
    value_format_name: usd_0
  }

  measure: total_gross_margin_amount {
    label: "Total Gross Margin"
    description: "Total difference between the total revenue from completed sales and the cost of the goods that were sold"
    type: number
    sql: ${total_gross_revenue} - ${inventory_items.total_cost} ;;
    value_format_name: usd_0
    drill_fields: [details_products*]
  }

  measure: gross_margin_percentage{
    label: "Total Gross Margin Percentage"
    description: "Total Gross Margin Amount / Total Gross Revenue"
    type: number
    sql: ${total_gross_margin_amount}/NULLIF(${total_gross_revenue},0) ;;
    value_format_name: percent_2
    html:
    {% if value > 0.5 %}
    <div style="background-color: rgba(200,35,25,{{value}}); font-size:150%; text-align:center">{{rendered_value}}</div>
    {% elsif value > 0 %}
    <div style="background-color: rgba(25,35,150,{{value}}); font-size:150%; text-align:center">{{rendered_value}}</div>
    {% else %}
    <div style="background-color: rgba(25,35,150,0.99); font-size:150%; text-align:center">{{rendered_value}}</div>
    {% endif %}
    ;;
  }

  measure: num_items_returned {
    label: "order_label"
    description: "Number of items that were returned by dissatisfied customers"
    type: count
    filters: [status: "Returned"]
  }

  measure: item_return_rate {
    label: "Item Return Rate"
    description: "Number of Items Returned / total number of items sold"
    type: number
    sql: ${num_items_returned}/NULLIF(${num_order_items}, 0) ;;
  }

  measure: num_customers_returning_items{
    label: "Number customers returning Items"
    description: "Number of users who have returned an item at some point"
    type: count_distinct
    sql:  ${user_id} ;;
    filters: [status: "Returned"]
  }

  measure: total_customers {
    label: "Total number customers"
    description: "Total number of customers"
    type: count_distinct
    sql: ${user_id} ;;
    value_format_name: decimal_0

  }
  measure: per_users_returning_items {
    label: "Percentage Users returning items"
    description: "Number of Customer Returning Items / total number of customers"
    type: number
    sql:  ${num_customers_returning_items}/NULLIF(${total_customers}) ;;
    value_format_name: percent_2
  }

  measure: avg_spend_customer {
    label: "Average Spending per customer"
    description: "Total Sale Price / total number of customers"
    type: number
    sql: ${total_sales}/NULLIF(${total_customers},0) ;;
    value_format_name: decimal_2
    drill_fields: [detailed_customer_info*]
  }


  measure: first_order_date {
    # label: "First Order Date"
    hidden: yes
    type: min
    sql: ${created_date} ;;
  }

  measure: latest_order_date {
    # label: "Latest Order Date"
    hidden: yes
    type: max
    sql: ${created_date} ;;
  }

  dimension: country_link_customer_support {
    type: string
    sql: ${users.country} ;;
    link: {
      label: "Contact Customer Support"
      url: "mailto: customersupport@schuettflix.de"
    }
  }

  dimension: country_external_link {
    type: string
    sql: ${users.country} ;;
    link: {
      label: "Search Google for Country/Brand"
      url: "https://www.google.com/search?q= {{ value }}"
      icon_url: "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"
    }
  }

  dimension: country_drill_db {
    type: string
    sql: ${users.country} ;;
    link: {
      label: "Drill Dashboard using link"
      url: "/dashboards/3?Country={{ value }}"
      }
    }


  dimension: country_drill_db_html {
    type: string
    sql: ${users.country} ;;
    html: <a href = "/dashboards/3?Country={{ value }}&filter_2=filter_value">{{ value }}</a> ;;
    }

  dimension: drive_link {
    type: string
    html: <a href="https://drive.google.com/uc?export=view&id=XXX"><img src="https://drive.google.com/uc?export=view&id=XXX" style="width: 500px; max-width: 100%; height: auto" title="Click for the larger version." /></a> ;;
  }

  measure: UK_country_percent_gauge {
    type: number
    sql: 100.0*${count_country_UK}/nullif(${count},0) ;;
    value_format: "#.0\%"
    html:   <img src="https://chart.googleapis.com/chart?chs=400x250&cht=gom&chma=10,0,0,0&chxt=y&chco=635189,B1A8C4,1EA8DF,8ED3EF&chf=bg,s,FFFFFF00&chl={{ rendered_value }}&chd=t:{{ value }}">;;

  }

  measure: total_sales_today {
    type: sum
    sql: ${sale_price} ;;
    filters: [created_date: "today"]
    value_format_name: usd_0
  }

  measure: total_sales_one_year_ago {
    type: sum
    sql: ${sale_price} ;;
    filters: [created_date: "1 year ago"]
    value_format_name: usd_0
  }

  measure: total_sales_one_week_ago {
    type: sum
    sql: ${sale_price} ;;
    filters: [created_date: "1 week ago"]
    value_format_name: usd_0
  }

  measure: comparison_measure_second {
    type: number
    label: "Total Sales - today, last week, last year"
    value_format_name: usd_0
    sql:  ${total_sales_one_year_ago}   ;;
    html:
    <div>
    {% if total_sales_one_week_ago._value < 0 %}
    <p style="color: #9FBF7D">▲ {{ total_sales_one_week_ago._rendered_value }}
    {% elsif total_sales_one_week_ago._value > 0 %}
    <p style="color: #990000">▼ {{ total_sales_one_week_ago._rendered_value }}
    {% elsif total_sales_one_week_ago._value == 0 %}
    <p style="color: #BABCBE">{{ total_sales_one_week_ago._rendered_value }}
    {% else %}
    <p style="color: #BABCBE">∅
    {% endif %}
    WoW </p>
    </div>
    <div>
    {% if value > 0 %}
    <p style="color: #9FBF7D">▲ {{ rendered_value }}
    {% elsif value < 0 %}
    <p style="color: #990000">▼ {{ rendered_value }}
    {% elsif value == 0 %}
    <p style="color: #BABCBE">{{ rendered_value }}
    {% else %}
    <p style="color: #BABCBE">∅
    {% endif %}
    YoY </p>
    </div> ;;
  }



  measure: comparison_measure {
    type: number
    label: "Total Sales, total customers comparison"
    value_format_name: percent_1
    sql:  SAFE_DIVIDE(${total_sales}, ${total_customers}) -1   ;;
    html:
    <div>
    {% if total_sales._value < 0 %}
    <p style="color: #9FBF7D">▲ {{ total_sales._rendered_value }}
    {% elsif total_sales._value > 0 %}
    <p style="color: #990000">▼ {{ total_sales._rendered_value }}
    {% elsif total_sales._value == 0 %}
    <p style="color: #BABCBE">{{ total_sales._rendered_value }}
    {% else %}
    <p style="color: #BABCBE">∅
    {% endif %}
    Total Sales </p>
    </div>
    <div>
    {% if value > 0 %}
    <p style="color: #9FBF7D">▲ {{ rendered_value }}
    {% elsif value < 0 %}
    <p style="color: #990000">▼ {{ rendered_value }}
    {% elsif value == 0 %}
    <p style="color: #BABCBE">{{ rendered_value }}
    {% else %}
    <p style="color: #BABCBE">∅
    {% endif %}
    Total Sales per customer </p>
    </div>  ;;
    }








  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }

  set: detailed_customer_info {
    fields: [
      users.id,
      users.country,
      users.traffic_source,
      users.age_tier,
      users.gender,
      users.is_new_customer
    ]
  }

  set: details_products {
    fields: [
      inventory_item.product_brand,
      inventory_item.product_category,
      inventory_item.product_department,
      inventory_item.product_name,

    ]
  }
}
