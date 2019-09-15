# README

## How to Setup

### Using Docker

```bash
docker-compose up
```

## Seeds

```bash
bundle exec rails db:setup
```

There will be 2 available data:
1. User `test@example.com:test0)`
2. Plane name `Tupolev` with id `1`

## For Simulation

This simulation will create `[[2,3], [3,4], [3,2], [4,3]]` seated plane.
Then, it will try to assign 30 users.

```bash
bundle exec rake simulation:queue
```

Then you will get something like this

![](https://i.ibb.co/0m3hx22/res.png)

## For frontend

We provide a flexible graphql endpoint to satisfy the needs of frontend. Graphql endpoint is in `/graphql`.
You can query all available types and mutation, we provide you with complete docs from each types.


### Assumption

1. User already logged in when accessing graphql endpoint.
2. Backend delivered first, then frontend.

### Authentication

1. We're using JWT token. Please set auth header with `Bearer <your-token-here>`
2. To get token use `/user_token` endpoint

```bash
curl -X POST \
  http://host/user_token \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: c9e54a43-06b5-40d0-91be-d6ec33c582da' \
  -H 'cache-control: no-cache' \
  -d '{
	"auth": {
		"email": "<your-email>@example.com",
		"password": "<your-password>"
	}
}'
```

Then you will get response

```json
{
  "jwt": "<your-token>"
}
```
