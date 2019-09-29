# Spin Scooters

spin_email <- function(email){
  POST('https://web.spin.pm/api/v1/magic_links',
       content_type_json(),
       body = list(email = email),
       encode = 'json',
       user_agent('Spin/857 CFNetwork/978.0.7 Darwin/18.7.0'))
}

spin_auth <- function(email, token){
  POST('https://web.spin.pm/api/v1/auth_tokens',
       content_type_json(),
       body = list(grant_type = "magic_link", magic_link = list(email = email, token = token)),
       encode = 'json',
       user_agent('Spin/857 CFNetwork/978.0.7 Darwin/18.7.0')
       )
}

spin_scooters <- function(lat, lon, token){
  url <- str_glue('https://web.spin.pm/api/v3/vehicles?lng={lon}&lat={lat}&distance=1000&mode=undefined')
  GET(url,
      add_headers(
       authorization = paste0("Bearer ", token)
      ),
      content_type_json()
  )
}
