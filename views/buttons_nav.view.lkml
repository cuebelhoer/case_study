view: buttons_nav {

dimension: navigation_button {
  type: yesno
  sql: true ;;
  allow_fill: yes
  html: <div>
  <a style="@{navigation_buttons_style}" href ="/dashboards/3?@{navigation_buttons_filters}"> Customer Behavior </a>
  </div>;;
}

}
