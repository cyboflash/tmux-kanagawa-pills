show_date_time() {
  local colors=$(get_module_colors "date_time" "$THM_GRAY")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local icon="$KANAGAWA_DATE_TIME_ICON"
  local format="$KANAGAWA_DATE_TIME_TEXT"

  build_module "$format" "$icon" "$bg" "$fg"
}
