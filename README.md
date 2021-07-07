1.  create new app

2. switch to folder

3. test server

4. add route

5. generate controller

6. define method in controller

7. create headings/html in views for the defined method

8. root "name#index"

9. generate model

10. rails db:migrate

11. manipulate data in the model with rails console

12. initialize new object; variable = Variable.new(column1: "string", column2: "string")

13. save new data with: variable.save

14. in the /app/controllers/variable_controller.rb to display all variables

    ```ruby
    def index
        @variables = Variable.all
    end
    ```

15. /app/views/variables/index.html.erb; prints every article in articles as an unordered list item

    ```ruby
    <ul>
      <% @articles.each do |article| %>
        <li>
          <%= link_to article.title, article%>
        </li>
      <% end %>
    </ul>
    ```

16. for each method you make inside a controller, a view name.html.erb needs to be made

17. add a new route

    ```ruby
      get "/articles/:id", to: "articles#show"
    ```

18. add the show method to the articles controller

    ```ruby
      def show
        @article = Article.find(params[:id])
      end
    ```

19. create  `app/views/articles/show.html.erb` with

    ```ruby
    <h1><%= @article.title %></h1>
    
    <p><%= @article.body %></p>
    ```

20. Link each article's title in `app/views/articles/index.html.erb` to its page

    ```ruby
    <h1>Articles</h1>
    
    <ul>
      <% @articles.each do |article| %>
        <li>
          <a href="/articles/<%= article.id %>">
            <%= article.title %>
          </a>
        </li>
      <% end %>
    ```

21. Replace the two `get` routes in `config/routes.rb` with `resources`

    ```
    Rails.application.routes.draw do
      root "articles#index"
    
      resources :articles
    end
    ```

22. Tidy up links in `app/views/articles/index.html.erb`

    ```ruby
    <h1>Articles</h1>
    
    <ul>
      <% @articles.each do |article| %>
        <li>
          <%= link_to article.title, article %>
        </li>
      <% end %>
    </ul>
    ```

23. add  `new` and `create` to `app/controllers/articles_controller.rb`, below the `show` action

    ```ruby
     def new
        @article = Article.new
      end
    
      def create
        @article = Article.new(title: "...", body: "...")
    
        if @article.save
          redirect_to @article
        else
          render :new
        end
      end
    ```

24. create `app/views/articles/new.html.erb` with the following contents:

    ```ruby
    <h1>New Article</h1>
    <%# The form_with helper method instantiates a form builder. %>
        <%# @article is the model we're interacting with%>
    <%= form_with model: @article do |form|%>
        <div>
        <%# creates a form with Title: textfield %>
            <%= form.label :title %><br>
            <%= form.text_field :title %>
        </div>
    
        <div>
        <%# creates a form labelled body with a big text area%>
            <%= form.label :body %><br>
            <%= form.text_area :body %>
        </div>
    
        <div>
        <%# creates a submit button :) %>
            <%= form.submit %>
        </div>
    <% end %>
    ```

25. add a private method to the bottom of `app/controllers/articles_controller.rb` named `article_params` that filters `params`. And let's change `create` to use it

    ```ruby
    def create
        @article = Article.new(article_params)
    
        if @article.save
          redirect_to @article
        else
          render :new
        end
      end
    ```

    ```ruby
      private
        def article_params
          params.require(:article).permit(:title, :body)
        end
    ```

26. add some validations to our model in `app/models/article.rb`

    ```ruby
    class Article < ApplicationRecord
      validates :title, presence: true
      validates :body, presence: true, length: { minimum: 10 }
    end
    ```

27. modify `app/views/articles/new.html.erb` to display any error messages for `title` and `body`:

    ```ruby
    <%= form_with model: @article do |form| %>
      <div>
        <%= form.label :title %><br>
        <%= form.text_field :title %>
        <% @article.errors.full_messages_for(:title).each do |message| %>
          <div><%= message %></div>
        <% end %>
      </div>
    
      <div>
        <%= form.label :body %><br>
        <%= form.text_area :body %><br>
        <% @article.errors.full_messages_for(:body).each do |message| %>
          <div><%= message %></div>
        <% end %>
      </div>
    
      <div>
        <%= form.submit %>
      </div>
    <% end %>
    ```

28. link to that page from the bottom of `app/views/articles/index.html.erb`:

    ```ruby
    <h1>Articles</h1>
    
    <ul>
      <% @articles.each do |article| %>
        <li>
          <%= link_to article.title, article %>
        </li>
      <% end %>
    </ul>
    
    <%= link_to "New Article", new_article_path %>
    ```

29. add a typical implementation of these actions to `app/controllers/articles_controller.rb`, below the `create` action, `edit` and `update` actions:

    ```ruby
    class ArticlesController < ApplicationController
      def index
        @articles = Article.all
      end
    
      def show
        @article = Article.find(params[:id])
      end
    
      def new
        @article = Article.new
      end
    
      def create
        @article = Article.new(article_params)
    
        if @article.save
          redirect_to @article
        else
          render :new
        end
      end
    
      def edit
        @article = Article.find(params[:id])
      end
    
      def update
        @article = Article.find(params[:id])
    
        if @article.update(article_params)
          redirect_to @article
        else
          render :edit
        end
      end
    
      private
        def article_params
          params.require(:article).permit(:title, :body)
        end
    end
    ```

Notice how the `edit` and `update` actions resemble the `new` and `create` actions.

