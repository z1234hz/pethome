# PetHome API v1.0
Base: https://api.pethome.app/api/v1
Auth: Bearer JWT Token
Rate: 60/min (normal), 300/min (VIP)

## Auth
POST /auth/send-code - Send SMS code
POST /auth/login - Login with phone+code
POST /auth/wechat - WeChat OAuth
POST /auth/apple - Apple ID login

## Lost Pets
POST /lost-pets - Create
GET /lost-pets - List (filters: species, city, status)
GET /lost-pets/:id - Detail
PUT /lost-pets/:id - Update
POST /lost-pets/:id/pin - Pin post (paid)
POST /lost-pets/:id/urgent - Mark urgent (paid)

## Found Pets
POST /found-pets - Report found
GET /found-pets - List
GET /found-pets/:id - Detail

## Matches
GET /matches - Get AI matches
POST /matches/:id/contact - Contact

## Messages
GET /conversations - List
GET /conversations/:id/messages - Messages
POST /conversations/:id/messages - Send

## Orders
POST /orders/create - Create order
POST /orders/:id/pay - Pay
GET /orders - List user orders

## Admin
GET /admin/dashboard - Stats
GET /admin/users - Users list
GET /admin/posts - Posts list
GET /admin/orders - Orders list
POST /admin/exports - Export data
