# MyApp

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

Step by step
mix phx.new my-app --app my_app --module MyApp --no-brunch --no-html
edit file config/dev.exs change the postgres configuration
mix ecto.create # for create database
mix phx.server # for running the application

mix phx.gen.context Auth User users email:string:unique \
is_active:boolean # for generate User schema and Auth context

#note contex is the data like repository but different is the package of function related to database
#please see the file priv/repo/migrations/<some time stamp>_create_users.exs

mix ecto.migrate
#please see the file mix.exs and then you can see a bcrypt module included in deps

mix deps.get

#append the config/test.exs config :bcrypt_elixir, :log_rounds, 4 its only for test for increase performa
#when you running the test

#please see a file lib/my_app/auth/user.ex
# this file is schema for user

mix test
#you can see error, you mush fix erorr in file test/my_app/auth/auth_test.exs
#this test is not relevant because you added bcrypt manualy in schema
#it's has been solved by me: triadi

mix phx.gen.json Auth User users email:string password:string \
is_active:boolean --no-context --no-schema 

#you can added the controller user_controller
#when you run test again error because you don't added the router for handling user page
#see the file router.ex, fixed by me

mix test

#you can see error please remove password in user_view.ex and see the user_controller_test
#and remove password in function create and update 

iex -S mix phx.server

#test create user data via mix 
MyApp.Auth.create_user(%{email: "asd@asd.com", password: "qwerty"})

#or you can using CURL
curl -H "Content-Type: application/json" -X POST \
-d '{"user": {"email": "asd@asd.com", "password": "qwerty"}}' \
http://localhost:4000/api/users

#added crossica for CORS access web from different domain
#please added in mix.exs in deps {:corsica, "~> 1.0"}

#added plugin in router as your endpoint
#please see plugin in endpoint.ex

#please add to auth.ex please see a file
#please add sign in method in user_controller, see a comment by me

#please see file user controlled i added some function authorize
#create file error_view.ex and login_view.ex

curl -H "Content-Type: application/json" -X POST \
-d '{"email":"asd@asd.com","password":"qwerty"}' \
http://localhost:4000/api/users/sign_in -i

curl -H "Content-Type: application/json" -X POST \
-d '{"email":"asd@asd.com","password":"not the right password"}' \
http://localhost:4000/api/users/sign_in -i

#added the session
#please see router and added plug(:fetch_session)
#and added |> put_session(:current_user_id, user.id) in user_controller.ex and in error scene
#|> delete_session(:current_user_id)

#and in the router please add 
<!-- pipeline :api_auth do
  plug(:ensure_authenticated)
end -->
#see full in router

#if you not login you cannet create a user because user is protected by session 

#erorr unauthorize
curl -H "Content-Type: application/json" -X GET \
http://localhost:4000/api/users \
-c cookies.txt -b cookies.txt -i

#login first
curl -H "Content-Type: application/json" -X POST \
-d '{"email":"asd@asd.com","password":"qwerty"}' \
http://localhost:4000/api/users/sign_in \
-c cookies.txt -b cookies.txt -i

http://localhost:4000/api/users/sign_in

#not error
curl -H "Content-Type: application/json" -X GET \
http://localhost:4000/api/users \
-c cookies.txt -b cookies.txt -i

curl -H "Content-Type: application/json" -X GET \
http://localhost:4000/api/roles \
-c cookies.txt -b cookies.txt -i

#edit file MyAppWeb.ErrorView and see commented by me

#create file .formatter.exs in root folder
#run mix format

#Now, invoke mix format to format your whole project according to the default Elixir formatting rules.

#to spesify run port phoenix please see http: [port: System.get_env("PORT") || 4000], in file config/dev

#to run this please run with 
PORT=5000 mix phx.server
#or
PORT=5000 iex -S mix phx.server