view: funnel_example_basic {
  derived_table: {
    sql:
          SELECT * FROM
            ( SELECT distinct
                user_id
              , country
              , city
              , browser
              , traffic_source
              , event_type
              , concat('Step', dense_rank() over (partition by user_id order by created_at asc)) as event_sequence
                FROM `looker-onboarding.ecommerce.events` AS events
              where {% condition date_range %} events.created_at {% endcondition %}
            )
            PIVOT(STRING_AGG(event_type) FOR event_sequence IN ('Step1', 'Step2', 'Step3', 'Step4', 'Step5'));; # could add more steps here if so desire
  }

  filter: date_range {
    type: date
  }

  dimension: user_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
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

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: step1 {
    label: "Step 1"
    type: string
    sql: ${TABLE}.step1 ;;
  }

  dimension: step2 {
    label: "Step 2"
    type: string
    sql: ${TABLE}.step2 ;;
  }

  dimension: step3 {
    label: "Step 3"
    type: string
    sql: ${TABLE}.step3 ;;
  }

  dimension: step4 {
    label: "Step 4"
    type: string
    sql: ${TABLE}.step4 ;;
  }

  dimension: step5 {
    label: "Step 5"
    type: string
    sql: ${TABLE}.step5 ;;
  }

  dimension: event_sequence {
    type: string
    sql: concat(${step1},${step2},${step3},${step4},${step5}) ;;
  }

  dimension: last_action { # this is what is displayed in dashboard as exit rate by category
    description: "The last category visited by the user, regardless of which step # this corresponds to."
    type: string
    sql: case when ${step2} is null and ${step1} is not null then ${step1}
              when ${step3} is null and ${step2} is not null then ${step2}
              when ${step4} is null and ${step3} is not null then ${step3}
              when ${step5} is null and ${step4} is not null then ${step4}
              when ${step5} is not null then ${step5} else 'error' end;;
  }

  dimension: last_aciton_number{# this is what is displayed in dashboard as exit rate by step #
    description: "The last action step #.  Can also think of this as how many actions occur before the client exits."
    type: string
    sql: case when ${step2} is null and ${step1} is not null then 'Step1'
          when ${step3} is null and ${step2} is not null then 'Step2'
          when ${step4} is null and ${step3} is not null then 'Step3'
          when ${step5} is null and ${step4} is not null then 'Step4'
          when ${step5} is not null then 'Step5' else 'error' end;;
  }

  measure: user_cnt {
    label: "User Count"
    type: count_distinct
    sql: ${user_id} ;;
  }

  ## For this example, I want to model a *specific path*.  The following achieves metrics for this path: Register > Cart > Purchase > History > Category
  ## the fields ABOVE are better used with Sankey visualizaiton where a visual of all the paths possible are desired
  measure: user_cnt_step1 {
    label: "1: Register"
    group_label: "Basic Path"
    description: "Register > Cart > Purchase > History > Category"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [step1: "Register"]
  }

  measure: user_cnt_step2 {
    label: "2: Cart"
    group_label: "Basic Path"
    description: "Register > Cart > Purchase > History > Category"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [step1: "Register", step2: "Cart"]
  }

  measure: user_cnt_step3 {
    label: "3: Purchase"
    group_label: "Basic Path"
    description: "Register > Cart > Purchase > History > Category"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [step1: "Register",step2: "Cart", step3: "Purchase"]
  }

  measure: user_cnt_step4 {
    label: "4: History"
    group_label: "Basic Path"
    description: "Register > Cart > Purchase > History > Category"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [step1: "Register",step2: "Cart", step3: "Purchase", step4: "History"]
  }

  measure: user_cnt_step5 {
    label: "5: Category"
    group_label: "Basic Path"
    description: "Register > Cart > Purchase > History > Category"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [step1: "Register",step2: "Cart", step3: "Purchase", step4: "History", step5: "Category"]
  }

  measure: total_user_cnt {
    hidden: yes
    type: number
    sql: sum(${user_cnt}) over() ;;
  }

  measure: user_rate { # this is more like user cnt/total users.... if you look by last action dimension then it turns into an exit rate... if you were to look at by first action, then would give you...first step rate
    label: "User Rate"
    description: "user count/total users.  This can can give various metrics depending on selected dimensions"
    type: number
    value_format_name: percent_1
    sql: ${user_cnt}/${total_user_cnt} ;;
  }


}
