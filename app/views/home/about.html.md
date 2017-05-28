TODO management system
===
About
---
TODO is a system intended for management of ongoing and completed tasks. It includes a database of users, all of whom can access their own TODOs; they can create, view, edit and delete their tasks.

Prerequisities
---
- Ruby 2.4.1
- Postgresql (database system)
- Bundler
- Git

How to set up
---
1) Clone the repository "TODOs" into your computer.

    `git clone https://github.com/wanglzuz/TODOs.git`
    
2) Install the dependencies - run

    `bundle install`

2) Set up the database:<br>
Choose your psql user. The permission to create a new database is necessary. Then add this database user and password into your environment variables as 'POSTGRES_USERNAME' and 'POSTGRES_PASSWORD' (see file "/config/database.yml").<br>
Run the following commands to create the database and to fill it with some test data:

    `rake db:create`
    
    `rake db:migrate`
    
    `rake db:seed`
    
    This data is accessible in the file "/db/seeds.rb" and it is only possible to add users into the user database here (for their parameters, see example users). When you make changes to this file, you can update the database with this command: 
    
    `rake db:reset`
     
    This will erase all the current database data and replace it with everything included in the said file. 

3) Running the service<br>
The service can be run and tested locally. Start up the server like this:

    `bundle exec rails server`
    
    Then send your requests to their respective routes at `http://localhost:3000`.<br>
A functional version of this service can also be accessed at `https://wanglzuz-todo.herokuapp.com/`.

How to use
---
1) Authorization<br>The user is required to provide their authorization for every request. That way, the user's identity is confirmed. To do this, add "access_token" and its value to the request header. If a false or no access token is provided, the service will refuse to cooperate.

2) Viewing existing tasks<br>
It is possible to view all user's tasks. To do that, use the following endpoint:<br>
GET "/todos"<br>
It is possible to view only the ongoing or finished tasks. To do that, add "status" into the URL as a param with the value "ongoing" or "done", respectively. Example:<br>
"/todos?status=done"

3) Viewing a single task<br>
To view a single task, you must know its ID (for that purpose, view the list of all tasks, as described above). Then send the following request:<br>
GET "/todos/id"<br>
where "id" is the ID of your desired task.<br>

4) Adding a new task<br>
You are required and permitted to include only the parameter "text" in the request body. Send this request:<br>
POST "/todos"<br>
Example of the text parameter in the request body:<br>
`{"text": "Example text."}`

5) Editing task description<br>
Send a JSON in the request body with the updated text (see 4.) to:<br>
PUT "/todos/id"<br>
 where "id" is the ID of the task you mean to edit.

6) Marking task as "done"<br>
Use the following endpoint:<br>
PUT "/todos/id/done"<br>
 where "id" is replaced by the task ID. The status 'done' will be subsequently assigned to the indicated task.

7) Deleting a task<br>
To delete a task, look up its ID and then send this request:<br>
DELETE "/todos/id"<br>
Watch out, the change, once the request is sent, is irreversible!