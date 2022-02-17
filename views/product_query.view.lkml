view: product_query {

  # Let Looker write this query for BRAND, DATE, measureing SALES and ORDER for 30 days

  derived_table: {

    sql: SELECT

              DATE(CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', order_items.created_at)) AS created_date,

              products.brand AS brand,

              COUNT(DISTINCT order_items.id) AS orders_count,

              SUM(order_items.sale_price) AS sales

            FROM public.order_items AS order_items



            LEFT JOIN public.inventory_items AS inventory_items ON order_items.inventory_item_id = inventory_items.id

            LEFT JOIN public.products AS products ON inventory_items.product_id = products.id

            WHERE

              (((order_items.created_at) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(day,-29, DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())) )))) AND (order_items.created_at) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(day,30, DATEADD(day,-29, DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())) ) ))))))

            GROUP BY 1,2 ;;

    }

  }
