connection: "bq_thelook"
# this is anothre change
# this is a change
# include all the views
include: "/views/**/*.view"
include: "/explore/*.lkml"

# include: "/dashboards/**/*.dashboard.lookml"

datagroup: case_study_default_datagroup {
  sql_trigger: SELECT 1;;
  max_cache_age: "1 hour"
}

datagroup: 24_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hour"
}



persist_with: case_study_default_datagroup
