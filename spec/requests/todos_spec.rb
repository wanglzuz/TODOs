require 'rails_helper'

RSpec.describe "Todos", type: :request do

  before :each do

    @user1 = User.create!({name: 'Applifter', email: 'info@applifting.com',
                         access_token: '93f39e2f-80de-4033-99ee-249d92736a25'})
    @user2 = User.create!({name: 'Batman', email: 'batman@applifting.com',
                         access_token: 'dcb20f8a-5657-4f1b-9f7f-ce65739b359e'})
    @todo1 = Todo.create!({text: 'Ongoing TODO.', created: DateTime.now,
                         done: false, user: @user1})
    @todo2 = Todo.create!({text: 'Done TODO.', created: DateTime.now,
                         done: true, user: @user1})

  end

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

  describe "TODO ownership error" do
    context "when TODO ID does not exist or TODO does not belong to user" do
      it "gives a NOT_FOUND error" do

        #non-existent ID
        get "/todos/a", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token}
        expect(response).to have_http_status 404
        expect(response.body).to include "NOT_FOUND"

        #TODO with this ID belongs to a different user
        get "/todos/#{@todo1.id}", headers: {"HTTP_ACCESS_TOKEN": @user2.access_token}
        expect(response).to have_http_status 404
        expect(response.body).to include "NOT_FOUND"

      end
    end
  end

  describe "index action" do

    context "when no status is specified" do
      it "lists all user's todos" do

        get "/todos", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token}
        expect(response).to have_http_status 200
        expect(assigns(:todos)).to eq @user1.todos
      end
    end

    context "when status is specified" do
      it "lists TODOs accordingly (or gives an error for an invalid status)" do

        get "/todos?status=ongoing", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token}
        expect(response).to have_http_status 200
        expect(assigns(:todos)).to eq @user1.todos.where(done: false)

        get "/todos?status=done", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token}
        expect(response).to have_http_status 200
        expect(assigns(:todos)).to eq @user1.todos.where(done: true)

        get "/todos?status=invalid_status", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token}
        expect(response).to have_http_status 404
        expect(response.body).to include "INVALID_STATUS"

      end
    end

  end

  describe "show action" do
    context "when a valid TODO is requested (by ID)" do
      it "shows TODO detail" do

        get "/todos/#{@todo1.id}", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token}
        expect(response).to have_http_status 200
        expect(assigns(:todo)).to eq @todo1

      end
    end
  end

  describe "create action" do
    context "when user sends text" do
      it "creates a new todo with this text and default other values" do

        new_text = "New todo."
        old_dtb_count = Todo.count
        post "/todos", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token},
                       params: {"text": new_text}
        expect(response).to have_http_status 201
        created_todo = Todo.last
        expect(created_todo.text).to eq new_text
        expect(Todo.count).to eq old_dtb_count + 1

      end
    end
  end

  describe "update action" do
    context "when user sends text" do
      it "saves it as TODO's updated text" do

        new_text = "Still ongoing."
        put "/todos/#{@todo1.id}", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token},
                                   params: {"text": new_text}
        expect(response).to have_http_status 200
        updated_todo = Todo.find_by(id: @todo1.id)
        expect(updated_todo.text).to eq new_text

      end
    end
  end

  describe "done action" do
    context "when done is called on a valid TODO" do
      it "sets the 'done' variable to 'true'" do

        put "/todos/#{@todo1.id}/done", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token}
        expect(response).to have_http_status 200
        updated_todo = Todo.find_by(id: @todo1.id)
        expect(updated_todo.done).to eq true

      end
    end
  end

  describe "destroy action" do
    context "when user requests a deletion of TODO with given ID" do
      it "deletes it from database" do

        old_dtb_count = Todo.count
        delete "/todos/#{@todo1.id}", headers: {"HTTP_ACCESS_TOKEN": @user1.access_token}
        expect(response).to have_http_status 200
        expect(Todo.count).to eq old_dtb_count - 1
        supposedly_deleted_todo = Todo.find_by(id: @todo1.id)
        expect(supposedly_deleted_todo).to eq nil

      end
    end
  end

end
