view: products {
  sql_table_name: `thelook.products`
    ;;
  drill_fields: [id]


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
    sql: {% parameter dynamic_measure_type%} (${retail_price});;
    value_format_name: decimal_0
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.name, distribution_centers.id, inventory_items.count]
  }


  dimension: brand_images {
    type: string
    sql: ${TABLE}.brand;;
     html:
      {% if brand._value == "O'Neill" %}
      <img src="https://upload.wikimedia.org/wikipedia/en/thumb/1/1b/O%27Neill_%28brand%29_logo.svg/220px-O%27Neill_%28brand%29_logo.svg.png">
      {% elsif brand._value == "Calvin Klein" %}
      <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Calvin_klein_logo.svg/220px-Calvin_klein_logo.svg.png">
      {% elsif brand._value == "Hanes" %}
      <img src="https://upload.wikimedia.org/wikipedia/en/thumb/f/f0/Hanes-logo.svg/150px-Hanes-logo.svg.png">
      {% elsif brand._value == "Tommy Hilfiger"%}
      <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Tommy_hilfig_vectorlogo.svg/250px-Tommy_hilfig_vectorlogo.svg.png">
      {% else %}
      <img src="https://icon-library.net/images/no-image-available-icon/no-image-available-icon-6.jpg" height="250" width="300">
      {% endif %} ;;}

}
