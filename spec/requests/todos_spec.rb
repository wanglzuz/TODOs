require 'rails_helper'

RSpec.describe "Todos", type: :request do

  before :each do

    user1 = User.create!({name: 'Applifter', email: 'info@applifting.com',
                         access_token: '93f39e2f-80de-4033-99ee-249d92736a25'})
    user2 = User.create!({name: 'Batman', email: 'batman@applifting.com',
                         access_token: 'dcb20f8a-5657-4f1b-9f7f-ce65739b359e'})
    todo1 = Todo.create!({text: 'Ongoing TODO.', created: DateTime.now,
                         done: false, user: user1})
    todo2 = Todo.create!({text: 'Done TODO.', created: DateTime.now,
                         done: true, user: user1})


    describe "user authentication" do
      context "only when user provides correct access token" do
        it "access is allowed" do

          get "/todos", headers: {"HTTP_ACCESS_TOKEN": "93f39e2f-80de-4033-99ee-249d92736a25"}
          expect(response).to have_http_status 200

          get "/todos", headers: {"HTTP_ACCESS_TOKEN": "an invalid acces token"}
          expect(response).to have_http_status 401
          expect(response.body).to include "ACCESS_DENIED"

          get "/todos"
          expect(response).to have_http_status 401
          expect(response.body).to include "ACCESS_DENIED"

        end
      end
    end


    describe "index action" do

      context "when no status is specified" do
        it "lists all user's todos" do

          get "/todos", headers: {"HTTP_ACCESS_TOKEN": user1.access_token}
          expect(response).to have_http_status 200
          expect(assigns(:todos)).to eq user1.todos
        end
      end

      context "when status is specified" do
        it "lists TODOs accordingly (or gives an error for an invalid status)" do

          get "/todos?status=ongoing", headers: {"HTTP_ACCESS_TOKEN": user1.access_token}
          expect(response).to have_http_status 200
          expect(assigns(:todos)).to eq user1.todos.where(done: false)

          get "/todos?status=done", headers: {"HTTP_ACCESS_TOKEN": user1.access_token}
          expect(response).to have_http_status 200
          expect(assigns(:todos)).to eq user1.todos.where(done: true)

          get "/todos?status=invalid_status", headers: {"HTTP_ACCESS_TOKEN": user1.access_token}
          expect(response).to have_http_status 404
          expect(response.body).to include "INVALID_STATUS"

        end
      end

    end


    describe "show action" do

      context "when id is valid (exists and belongs to the user)" do
        it "shows TODO detail" do

          get "/todos/#{todo1.id}", headers: {"HTTP_ACCESS_TOKEN": user1.access_token}
          expect(response).to have_http_status 200
          expect(assigns(:todo)).to eq todo1

        end
      end

      context "when id is invalid (non-existent or does not belong to the user)" do
        it "gives an 'invalid ID' error" do

          get "/todos/#{todo1.id + 1}", headers: {"HTTP_ACCESS_TOKEN": user1.access_token}
          expect(response).to have_http_status 404
          expect(response.body).to include "NOT_FOUND"

          get "/todos/#{todo1.id}", headers: {"HTTP_ACCESS_TOKEN": user2.access_token}
          expect(response).to have_http_status 404
          expect(response.body).to include "NOT_FOUND"

        end
      end

    end

  end

end
