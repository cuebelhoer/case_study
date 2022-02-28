include: "/views/**/*.view"

explore: product_purchase_per_user {}


explore: products {
  # required_access_grants: [team_a]
  join: product_facts {
    # view_label: "This is another label"
    type: left_outer
    sql_on: ${products.id} = ${product_facts.product_id} ;;
    relationship: one_to_one
  }
}

explore: events {}
explore: order_items {

  join: buttons_nav {}
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id};;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    type: left_outer
    sql_on: ${users.id} = ${user_facts.id} ;;
    relationship: many_to_one
  }

# explore: product_purchase_per_user{}

# explore: orders {
#   from: order_items
#   always_filter: {
#     filters: [orders.status: "Returned"]
#   }
#   aggregate_table: orders_per_day {
#     query: {
#       dimensions: [orders.created_date]
#       measures: [orders.count]
#       filters: [orders.status: "Returned"]
#     }
#     materialization: {
#       datagroup_trigger: case_study_default_datagroup
#     }
#   }
#   aggregate_table: orders_per_month {
#     query: {
#       dimensions: [orders.created_month]
#       measures: [orders.count]
#     }
#     materialization: {
#       datagroup_trigger: case_study_default_datagroup
#     }
#   }

}
