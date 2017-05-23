require 'rails_helper'

RSpec.describe "Todos", type: :request do


  describe "user authentication" do
    context "only when user provides correct access token" do
      it "access is allowed" do

        user1 = User.create({name: 'Applifter', email: 'info@applifting.com',
                             access_token: '93f39e2f-80de-4033-99ee-249d92736a25'})

        get "/todos", :headers => {"HTTP_ACCESS_TOKEN" => "93f39e2f-80de-4033-99ee-249d92736a25"}
        expect(response).to have_http_status 200

        get "/todos", :headers => {"HTTP_ACCESS_TOKEN" => "an invalid acces token"}
        expect(response).to have_http_status 401

        get "/todos"
        expect(response).to have_http_status 401

      end
    end
  end


  describe "index action" do
    context "when no status is specified" do
      it "lists all user's todos" do

        user1 = User.create({name: 'Applifter', email: 'info@applifting.com',
                             access_token: '93f39e2f-80de-4033-99ee-249d92736a25'})

        get "/todos", :headers => {"HTTP_ACCESS_TOKEN" => user1.access_token}
        expect(response).to have_http_status 200
        expect(assigns(:todos)).to eq user1.todos
      end
    end

    context "when status is specified" do
      it "lists TODOs accordingly (or gives an error for an invalid status)" do

        user1 = User.create({name: 'Applifter', email: 'info@applifting.com',
                             access_token: '93f39e2f-80de-4033-99ee-249d92736a25'})
        todo1 = Todo.create({text: 'Ongoing TODO.', created: DateTime.now,
                             done: false, user: user1})
        todo2 = Todo.create({text: 'Done TODO.', created: DateTime.now,
                             done: true, user: user1})

        get "/todos", :headers => {"HTTP_ACCESS_TOKEN" => user1.access_token},
                              :params => {"status" => "ongoing"}
        expect(response).to have_http_status 200
        expect(assigns(:todos)).to eq user1.todos.where(done: false)

        get "/todos", :headers => {"HTTP_ACCESS_TOKEN" => user1.access_token},
                           :params => {"status" => "done"}
        expect(response).to have_http_status 200
        expect(assigns(:todos)).to eq user1.todos.where(done: true)

        get "/todos", :headers => {"HTTP_ACCESS_TOKEN" => user1.access_token},
                                          :params => {"status" => "an_invalid_status"}
        expect(response).to have_http_status 404
      end
    end
  end


  describe "show action" do
    context "when id is valid" do
      it "shows TODO detail / refuses non-owner" do

        user1 = User.create({name: 'Applifter', email: 'info@applifting.com',
                             access_token: '93f39e2f-80de-4033-99ee-249d92736a25'})
        user2 = User.create({name: 'Batman', email: 'batman@applifting.com',
                             access_token: 'dcb20f8a-5657-4f1b-9f7f-ce65739b359e'})
        todo1 = Todo.create({text: 'Ongoing TODO.', created: DateTime.now,
                             done: false, user: user1})

        get "/todos/#{todo1.id}", :headers => {"HTTP_ACCESS_TOKEN" => user1.access_token}
        expect(response).to have_http_status 200
        expect(assigns(:todo)).to eq todo1

        get "/todos/#{todo1.id}", :headers => {"HTTP_ACCESS_TOKEN" => user2.access_token}
        expect(response).to have_http_status 403

      end
    end

    context "when id is invalid" do
      it "gives an 'invalid ID' error" do

        user1 = User.create({name: 'Applifter', email: 'info@applifting.com',
                             access_token: '93f39e2f-80de-4033-99ee-249d92736a25'})
        todo1 = Todo.create({text: 'Ongoing TODO.', created: DateTime.now,
                             done: false, user: user1})

        get "/todos/#{todo1.id + 1}", :headers => {"HTTP_ACCESS_TOKEN" => user1.access_token}
        expect(response).to have_http_status 404

      end
    end


  end
end
