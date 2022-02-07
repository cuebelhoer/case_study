view: templated_filters {
  derived_table: {
    sql:
      SELECT
        id as customer_id,
        SUM(sale_price) AS lifetime_spend,
        status
      FROM
        order_items
      WHERE
        {% condition order_region %} order.region {% endcondition %}
      GROUP BY 1, 3
    ;;
  }

  # Templated filters insert values as logical statements
  # for more flexible input
  # such as date ranges or string searches
  filter: order_region {
    type: string
  }

  # For liquid statemenrts add parameters
  # isert user input directly
  # when locical statements cannot be inserted
  parameter: status_to_count {
    type: unquoted
    allowed_value: {
      value: "Returned"
      label: "Returned"
      }
    allowed_value: {
      value: "Cancelled"
      label: "Cancelled"
    }
    allowed_value: {
      value: "Shipped"
      label: "Shipped"
      }
    allowed_value: {
      value: "Processing"
      label: "Processing"
    }
    allowed_value: {
      value: "Complete"
      label: "Complete"
    }
    }
  measure: status_count {
    type:  sum
    sql:
      CASE
        WHEN ${status} = '{% parameter status_to_count %}'
        THEN 1
        ELSE 0
      END ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: lifetime_spend {
    type: number
    sql:${TABLE}.lifetime_spend ;;
  }

  dimension: status {
    type: string
    sql:${TABLE}.status ;;
  }

}
