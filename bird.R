# Bird Scooters

bird_email <- function(email){
  POST(url = 'https://api-auth.prod.birdapp.com/api/v1/auth/email',
       body = list(email = email),
       encode = 'json',
       user_agent('Bird/4.41.0 (co.bird.Ride; build:37; iOS 12.3.1) Alamofire/4.41.0'),
       content_type_json(),
       add_headers(
         `Device-Id` = uuid::UUIDgenerate(),
         Platform = 'ios',
         `App-Version` = '4.41.0'
       )
  )
}

bird_auth <- function(token){
  POST(url = 'https://api-auth.prod.birdapp.com/api/v1/auth/magic-link/use',
       body = list(token = token),
       encode = 'json',
       content_type_json()
       ) -> p
  
  return(p)
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

