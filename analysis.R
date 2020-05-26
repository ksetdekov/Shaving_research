library(googlesheets4)
library(googledrive)

drive_get("Бритье (Ответы)") %>%    read_sheet()