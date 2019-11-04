# Accessing The Scooter Data
library(httr);library(uuid)
# Requires source Functions

# Bird
bird_email(Sys.getenv('email'))
bird_auth('')
bird_scooters()

# Lime
lime_sms(Sys.getenv('phone'))
lime_auth('')
lime_scooters()

# Spin
spin_email(Sys.getenv('email'))
spin_auth('')
spin_scooters()
