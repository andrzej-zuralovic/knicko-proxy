# Knicko Proxy App

### API Documentation:
* API Endpoint: https://knicko-proxy.zuralovic.lt/api/v1/orders
* https://knicko-proxy-docs.zuralovic.lt
* [CoinGate Docs](https://developer.coingate.com/reference/cryptocurrency-payment-api)

### Credentials:
* Bearer Token: `b85e810128b1e5718fe3c5ea1f18d3db4f8512e90155292149a29588c8a7b64f`
* `export RAILS_MASTER_KEY="cc29331845de671df871a5e2b0bacadc`

## Fast demo
### Create Order
```bash
curl -X 'POST' \
  'https://knicko-proxy.zuralovic.lt/api/v1/orders' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer b85e810128b1e5718fe3c5ea1f18d3db4f8512e90155292149a29588c8a7b64f' \
  -H 'Content-Type: multipart/form-data' \
  -F 'price_amount=10' \
  -F 'price_currency=EUR' \
  -F 'receive_currency=EUR'
```
### Get Order
```bash
curl -X 'GET' \
  'https://knicko-proxy.zuralovic.lt/api/v1/orders/1' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer b85e810128b1e5718fe3c5ea1f18d3db4f8512e90155292149a29588c8a7b64f'
```
