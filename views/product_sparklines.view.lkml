view: product_sparklines {

  derived_table: {

    sql: SELECT

              pv.brand

              , STRING_AGG(COALESCE(pq.sales,0.0),',') WITHIN GROUP (ORDER BY pv.date) as sales

              , STRING_AGG(COALESCE(pq.orders_count,0),',') WITHIN GROUP (ORDER BY pv.date) as orders

            FROM  ${product_query.SQL_TABLE_NAME} as pq

            RIGHT JOIN  ${product_possible_values.SQL_TABLE_NAME} as pv

              ON pv.date = pq.created_date

               AND pv.brand = pq.brand

            GROUP BY 1 ;;

    }

    dimension: brand {hidden: yes}

    dimension: sales{hidden: yes}

    dimension: orders{hidden: yes}



    dimension: brand_sales_30_days{

      sql: '1';;

      html:

        <img src="https://chart.googleapis.com/chart?chs=200x50&cht=ls&chco=0077CC&chf=bg,s,FFFFFF00&chds=a&chxt=x,y&chd=t:{{sales._value}}&chxr=0,-30,0,4">

      ;;

      }

      dimension: brand_orders_30_days{

        sql: '1';;

        html: |

            <img src="https://chart.googleapis.com/chart?chs=200x50&cht=ls&chco=0077CC&chf=bg,s,FFFFFF00&chds=a&chxt=x,y&chd=t:{{orders._value}}&chxr=0,-30,0,4">

            ;;

        }

      }
