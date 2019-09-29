# Lime Scooters

lime_sms <- function(phone){
  url <- str_glue('https://web-production.lime.bike/api/rider/v1/login?phone={phone}')
  GET(url)
}

lime_auth <- function(phone, code){
  login <- POST(
    url = "https://web-production.lime.bike/api/rider/v1/login",
    content_type_json(),
    body = list(login_code = code, phone = phone),
    encode = "json",
    verbose()
  )
  bearerToken <- content(login)[[1]] # bearer token
  cookies     <- cookies(login)[[7]] # cookie
  
  info <- list(token = bearerToken,cookie = cookies)
  return(info)
}

lime_scooters <- function(token, cookies, lat, long){
  header <- paste0("authorization: Bearer ", token)
  cookie <- paste0("_limebike-web_session=", cookies)
  
  response <- GET(
    url = "https://web-production.lime.bike/api/rider/v1/views/map",
    query = list(
      ne_lat = 38.77443,
      ne_lng = -90.16657,
      sw_lat = 38.53185,
      sw_lng = -90.32052,
      user_latitude = lat,
      user_longitude = long,
      zoom = 15
    ),
    add_headers(header),
    set_cookies(cookie)
  )
  
  return(content(response))

}