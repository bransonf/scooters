# Bird Scooters

bird_auth <- function(email, guid){
  POST(url = 'https://api.birdapp.com/user/login',
       body = list(email = email),
       encode = "json",
       user_agent('Bird/4.41.0 (co.bird.Ride; build:37; iOS 12.3.1) Alamofire/4.41.0'),
       content_type_json(),
       add_headers(
         `Device-Id` = guid,
         Platform = 'ios',
         `App-Version` = '4.41.0'
       )
       ) -> p
  
  # parse content into list
  cnt <- content(p)
  
  auth = list(
    id = cnt$id,
    token = cnt$token
  )
  
  return(auth)
}

bird_scooters <- function(guid, token, lat, lon, radius){
  GET('https://api.birdapp.com/bird/nearby?',
      query = list(latitude=lat, longitude=lon,radius=radius),
      user_agent('Bird/4.41.0 (co.bird.Ride; build:37; iOS 12.3.1) Alamofire/4.41.0'),
      content_type_json(),
      add_headers(
        Authorization = paste0('Bird ', token),
        `Device-Id` = guid,
        `App-Version` = '4.41.0',
        Location = paste0('{"latitude":',lat,',"longitude":',lon,',"altitude":500,"accuracy":100,"speed":-1,"heading":-1}')
      )  
    
  ) -> g
  
  c = content(g)
  
  return(c)
  
}

