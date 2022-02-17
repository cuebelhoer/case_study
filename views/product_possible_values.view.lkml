view: product_possible_values {

  # Get all the possible values for dates and brands combinations so we can zero fill.

  derived_table: {

    sql: SELECT date, brand FROM

              (SELECT DISTINCT created_date as date FROM ${product_query.SQL_TABLE_NAME}) as dates

            CROSS JOIN (SELECT DISTINCT brand FROM ${product_query.SQL_TABLE_NAME}) brands ;;

    }

  }
